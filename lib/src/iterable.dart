import 'dart:math' show min, max;

/* List */
List list(int len, [x]){
  if( x is Function ) return new List.generate(len, x);
  if( x == null ) return new List(len);
  return new List.filled(len, x);
}

void swap(List lis, int i, int j){
  var t = lis[i];
  lis[i] = lis[j];
  lis[j] = t;
}

List<int> listIndices(List list, e){
  var ix = [];
  for(var i = list.indexOf(e); i != -1; i = list.indexOf(e,i) ) ix.add(i);
  return ix;
}

listReverse(List lis){
  var i=0, j=lis.length;
  while( i < j ) swap(lis, i, j);
}

listDot(List a, List b){

}

/* matrix */
List<List> matrix(int height, int width, [x]){
  if( x is Function ) return new List.generate(height, (i) =>
  new List.generate(width, (j) => x(i,j))
  );
  return new List.generate(height, (i) => list(width, x));
}

matMul(a,b){
  // todo
}

matAdd(a,b){
  // todo
}

matDet(a){
  // todo
}



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
