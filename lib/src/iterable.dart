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

void cartesian(int n, List lis, bool callback(List) ){
  var v = new List(n);
  bool run(i){
    if( i == n ) return callback(v) ?? false;
    else {
      for(var j=0; j<lis.length; j++){
        v[i] = lis[j];
        if( run(i+1) ) return true;
      }
      return false;
    }
  }
  run(0);
}

void powerSet(List lis, callback){
  var x = [];
  var n = lis.length;
  bool run(i){
    if( i == n ) return callback(x) ?? false;
    else {
      if( run(i+1) ) return true;
      x.add(lis[i]);
      if( run(i+1) ) return true;
      x.removeLast();
      return false;
    }
  }
  run(0);
}

void combination(int sel, List lis, callback){
  var len = lis.length;
  var start = 0;
  var val = new List.generate(sel, (i) => i);

  bool combinator(int i){
    if(i == sel) return callback(val) ?? false;
    else {
      var m = len-sel+i;
      for(var j=start; j<=m; j++){
        val[i] = lis[j];
        start=j+1;
        if( combinator(i+1) ) return true;
      }
      return false;
    }
  }
  combinator(0);
}

void permutation(List lis, callback){
  // modify in-place
  bool run(n){
    if( n == 0 ) return callback(lis) ?? false;
    else if( isOdd(n) ){
      for(var i=0; i<=n; i++){
        if( run(n-1) ) return true;
        swap(lis, 0, n);
      }
    }
    else {
      for(var i=0; i<=n; i++){
        if( run(n-1) ) return true;
        swap(lis, i, n);
      }
    }
    return false;
  }
  run(lis.length-1);
}