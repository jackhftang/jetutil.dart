import 'dart:math' show min, max;


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

