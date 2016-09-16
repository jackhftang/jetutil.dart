/**
 * find max c . x subject to a . x <= b, x >= 0
 * constraint
 *  a.length == b.length
 *  a[i].length == c.length for all i
 *
 */
simplex( List< List<num> > a, List<num> b, List<num> c ){
  // todo: add class version
  if( a.length != b.length ) throw new StateError('a and b should have same length');
  for(var i=0; i<a.length; i++){
    if( a[i].length != c.length ) throw new StateError('a[$i] and c should have same length');
  }

  int dim = c.length, ineq = b.length;

  // build tableau
  int h = ineq+1, w = dim + ineq + 1;
  var m = new List.generate(h, (i) => new List.filled(w, 0.0), growable: false);
  for(int i=0; i<ineq; i++){
    for(int j=0; j<dim; j++){
      m[i][j] = a[i][j];
    }
  }
  for(int i=0; i<b.length; i++){
    m[i][dim+i] = 1;
    m[i][w-1] = b[i];
  }
  for(int i=0; i<c.length; i++){
    m[h-1][i] = c[i];
  }

  int findMaxPosCol(){
    var mi = 0, ix = -1;
    for(int i=0; i<w-1; i++) {
      var t = m[h - 1][i];
      if (t > mi) {
        mi = t;
        ix = i;
      }
    }
    return ix;
  }

  int findMinRatioRow(col){
    var mi = double.INFINITY, ix = -1;
    for(int i=0; i<h-1; i++) {
      if (m[i][col] == 0) continue;
      var t = m[i][w - 1] / m[i][col];
      if (t > 0 && t < mi) {
        mi = t;
        ix = i;
      }
    }
    return ix;
  }

  var col = findMaxPosCol();
  while( col >= 0 ){
    var row = findMinRatioRow(col);
    if( row < 0 ) return double.INFINITY;  // unbound

    // divide row
    var t = m[row][col];
    for(int i=0; i<w; i++) m[row][i] /= t;

    // subtract rows
    for(int i=0; i<h; i++){
      if( i == row ) continue;
      var t = m[i][col];
      for(int j=0; j<w; j++){
        m[i][j] -= t*m[row][j];
      }
    }

    col = findMaxPosCol();
  }
  return -m.last.last;
}
