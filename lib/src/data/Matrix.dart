import 'package:jetutil/src/data/list.dart';
import 'package:jetutil/src/predicate.dart';

/* matrix */
List<List> matrix(int height, int width, [x]){
  if( x is Function ) return new List.generate(height, (i) =>
  new List.generate(width, (j) => x(i,j))
  );
  return new List.generate(height, (i) => list(width, x));
}

// a[i].length == b.length forall i && b[0].length == b[j].length for all j
// time: O( a.length * (sum[i = 0.. b.length] b[i].length)
// space:
matMul(List<List<double>> a, List<List> b){
  var h = a.length;
  var w = b[0].length;
  var d = b.length;

  return new List.generate(h, (i){
    return new List.generate(w, (j){
      var acc = 0;  // support int and double
      for(var k=0; k<d; k++) acc += a[i][k] * b[k][j];
      return acc;
    });
  });
}

matModMul(int m, List<List<int>> a, List<List<int>> b){
  var h = a.length;
  var w = b[0].length;
  var d = b.length;

  return new List.generate(h, (i){
    return new List.generate(w, (j){
      var acc = 0;
      for(var k=0; k<d; k++) acc = (acc + a[i][k] * b[k][j]) % m;
      return acc;
    });
  });
}

// a[i].length == a.length forall i
// time: O(ln(n))
matPow(List<List<double>> a, int n){
  assert(n >= 0);
  var l = a.length;

  // result matrix
  var r = matrix(l,l, 0);
  // initially a unit matrix
  for(var i=0; i<l; i++) r[i][i] = 1;

  var b = matClone(a);
  while(n > 0){
    if( isOdd(n) ) r = matMul(r, b);
    b = matMul(b,b);
    n ~/= 2;
  }
  return r;
}

matModPow(int m, List<List<int>> a, int n){
  assert(n >= 0);
  var l = a.length;

  // result matrix
  var mat = matrix(l,l, 0);
  for(var i=0; i<l; i++) mat[i][i] = 1;

  var b = matClone(a);
  while(n > 0){
    if( isOdd(n) ) mat = matModMul(m, mat, b);
    b = matModMul(m, b, b);
    n ~/= 2;
  }
  return mat;
}

matClone(List<List> m) => new List.generate(m.length, (i) => listClone(m[i]) );

matAdd(a, b, [c=1.0]){
  // todo: add to a && coefficient?
  assert(a.length == b.length);
  var h = a.length;
  var mat = new List(h);
  for(var i=0; i<h; i++){
    assert(a[i].length == b[i].length);
    var w = a[0].length;
    mat[i] = new List.generate(w, (j) => a[i] + b[i] );
  }
  return mat;
}

matDet(a){
  // todo
}