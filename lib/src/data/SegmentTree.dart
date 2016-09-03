class SegmentTree<E> {
  int width;
  E identity;
  Function combine;
  List<E> arr;

  // len is maximum number of element
  SegmentTree(int len, E this.identity, int this.combine(E a, E b) ){
    var total = 1;
    width = 1;
    while( width < len ){
      total = 2*total + 1;
      width *= 2;
    }
    arr = new List.filled(total, identity);
  }

  // i is 0-based
  void update(int i, E v){
    var ix = width - 1 + i;
    arr[ix] = v;
    while( ix != 0 ){
      ix = (ix-1) ~/ 2;
      int l = 2*ix + 1;
      int r = 2*ix + 2;
      arr[ix] = combine(arr[l],arr[r]);
    }
  }

  // half-inclusive [lbnd, rbnd), 0-based
  E query(lbnd, rbnd){
    E run(i, lo, up){
      if( lbnd <= lo && up <= rbnd ) return arr[i];
      if( up <= lbnd || rbnd <= lo ) return identity;
      var mid = (lo+up) ~/ 2;
      return combine(run(2*i+1, lo, mid), run(2*i+2, mid, up));
    }
    return run(0,0,width);
  }
}