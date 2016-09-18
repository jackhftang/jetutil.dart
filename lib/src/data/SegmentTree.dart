class SegmentTree<E> {
  int width;
  E identity;
  Function combine;
  List<E> arr;

  // len is maximum number of element
  // combine(identity, x) = combine(x, identity) = x for all x
  // O(log(N)) or practically constant time
  SegmentTree(int len, E this.identity, E this.combine(E a, E b) ){
    var total = 1;
    width = 1;
    while( width < len ){
      total = 2*total + 1;
      width *= 2;
    }
    arr = new List.filled(total, identity);
  }

  // O(N)
  SegmentTree.fromList(List lis, this.identity, E this.combine(E a, E b)){
    var total = 1;
    width = 1;
    while( width < lis.length ){
      total = 2*total + 1;
      width *= 2;
    }
    arr = new List(total);
    for(var i=0; i<lis.length; i++) arr[width-1+i] = lis[i];
    for(var i=lis.length; i<width; i++) arr[width-1+i] = identity;
    for(var i=width-1; i-->0;) arr[i] = combine(arr[2*i+1], arr[2*i+2]);
  }

  // i is 0-based
  // O( log(N) * combine )
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
  // O( log( N ) * combine )
  E query(int lbnd, int rbnd){
    E run(i, lo, up){
      if( lbnd <= lo && up <= rbnd ) return arr[i];
      if( up <= lbnd || rbnd <= lo ) return identity;
      var mid = (lo+up) ~/ 2;
      return combine(run(2*i+1, lo, mid), run(2*i+2, mid, up));
    }
    return run(0,0,width);
  }
}


main(){
  var t = new SegmentTree(100, 0, (a,b) => a+b);
}