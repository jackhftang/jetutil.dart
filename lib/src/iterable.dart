import 'dart:math' show min, max;
import 'package:jetutil/src/predicate.dart' show isOdd;
import 'package:jetutil/src/data/list.dart' show swap;

/* iterable */
Iterable range(int n) => new Iterable.generate(n);


num summation(Iterable ite){
  // return 0 if empty (unlike reduce)
  var t = 0;
  for(var i in ite) t += i;
  return t;
}
num product(Iterable ite){
  var t = 1;
  for(var i in ite) t *= i;
  return t;
}

num minimum(Iterable ite) => ite.reduce(min);
num maximum(Iterable ite) => ite.reduce(max);

Map histogram(Iterable xs){
  var m = {};
  for(var x in xs) m[x] = (m[x] ?? 0) + 1;
  return m;
}

//class Zip2 extends Iterator {
//  Iterator x, y;
//
//  Zip2(this.x, this.y);
//
//  @override
//  E get current => [x.current, y.current];
//
//  @override
//  bool moveNext() => x.moveNext() && y.moveNext();
//}

void for2(Iterable a, Iterable b, Function callback, {exhaustive: false}){
  var x = a.iterator, y = b.iterator;
  if(exhaustive) while( x.moveNext() || y.moveNext() ) callback(x.current, y.current);
  else while( x.moveNext() && y.moveNext() ) callback(x.current, y.current);
}

void for3(Iterable a, Iterable b, Iterable c, Function callback, {exhaustive: false}){
  var x = a.iterator, y = b.iterator, z = c.iterator;
  if(exhaustive) while( x.moveNext() || y.moveNext() || z.moveNext() )
    callback(x.current, y.current, z.current);
  else while( x.moveNext() && y.moveNext() && z.moveNext() )
    callback(x.current, y.current, z.current);
}

void cartesian(int n, List lis, callback){
  var v = new List(n);
  run(i){
    if( i == n ) callback(v);
    else for(var j=0; j<lis.length; j++){
      v[i] = lis[j];
      run(i+1);
    }
  }
  run(0);
}

void powerSet(List lis, callback){
  var x = [];
  var n = lis.length;
  run(i){
    if( i == n ) callback(x);
    else {
      run(i+1);
      x.add(lis[i]);
      run(i+1);
      x.removeLast();
    }
  }
  run(0);
}

void combination(int sel, List lis, callback){
  var len = lis.length;
  var leastUpperBound = 0;
  var val = new List.generate(sel, (i) => i);

  combinator(int i){
    if(i == sel) callback(val);
    else {
      var m = len-sel+i;
      for(var j=leastUpperBound; j<=m; j++){
        val[i] = lis[j];
        leastUpperBound=j+1;
        combinator(i+1);
      }
    }
  }
  combinator(0);
}

void permutation(List lis, callback){
  // modify in-place
  run(n){
    if(n == 0 ) callback(lis);
    else if( isOdd(n) ){
      for(var i=0; i<=n; i++){
        run(n-1);
        swap(lis, 0, n);
      }
    }
    else {
      for(var i=0; i<=n; i++){
        run(n-1);
        swap(lis, i, n);
      }
    }
  }
  run(lis.length-1);
}