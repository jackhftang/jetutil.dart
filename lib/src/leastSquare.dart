import 'dart:math';

// work even on singular matrix
// x.length do not necessarily large than x[0].length
// O( min(nSample,nDim) * nDim^2 * nSample )
List leastSquare(List< List<double> > x, List<double> y, [EPS=1e-12]){
  assert(y.length == x.length);

  var h = x[0].length;    // nDim
  var w = x.length;       // nSample

  var mat = new List.generate(h,
      (i) => new List.generate(w, (j) => x[j][i], growable: false),
      growable: false
  );
  var vec = new List.from(y, growable: false);

  dotFrom(i,a,b){
    var s = 0.0;
    for(var j=i; j<w; j++) s += a[j] * b[j];
    return s;
  }

  // a[i..w] += c * b[i..w]
  rowAddFrom(i, a, c, b){
    for(var j=i; j<w; j++){
      a[j] += c * b[j];
    }
  }

  var rank = [];
  var l = min(w,h);
  for(var i=0; i<l; i++){
    var r = rank.length;
    var p = mat[i][r];
    var s = dotFrom(r+1, mat[i], mat[i]);
    var t = sqrt(p*p+s);

    // singular
    if( t < EPS ) continue;

    // avoid subtraction near equal number
    if( p.sign == 1 ) t = -t;
    p = mat[i][i] -= t; // update p

    var b0 = 2/(p*p+s);
    for(var j=i+1; j<h; j++){
      // fast Householder reflection
      var b1 = dotFrom(r, mat[i], mat[j]);
      rowAddFrom(r, mat[j], -b1*b0, mat[i]);
    }
    var b1 = dotFrom(r, mat[i], vec);
    rowAddFrom(r, vec, -b1*b0, mat[i]);


    // override columns-i
    mat[i][r] = t;
//    mat[i].fillRange(r+1, w, 0.0);
    rank.add(i);
  }

  // solve triangular matrix (may not full rank)
  var ans = new List.filled(h, 0.0);
  for(var i=rank.length; i-- > 0; ){
    ans[i] = vec[i];
    for(var j=h-1; j>rank[i]; j--){
      ans[i] -= mat[j][i] * ans[j];
    }
    ans[i] /= mat[rank[i]][i];
  }

  var err = dotFrom(rank.length, vec, vec);

  return [ans, err];
}