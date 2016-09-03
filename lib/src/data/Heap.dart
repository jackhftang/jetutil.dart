// minimum at root
class Heap<T> {
  List lis;
  Comparator<T> compare;

  Heap(this.compare){
    lis = [];
  }


  Heap.heapify(List<T> list, this.compare){
    // mutable
    lis = list;
    for(int i=lis.length-1; i>=0; i--) heapDown(i);
  }

  void heapUp(int i){
    while( i > 0 ){
      int p = (i-1)~/2;
      T a = lis[i];
      T b = lis[p];
      if( compare(a,b) >= 0 ) return;
      lis[i] = b; lis[p] = a; // swap
      i = p;
    }
  }

  void heapDown(int i){
    final int len = lis.length;
    min(a,b){
      if(b >= len || compare(lis[a], lis[b]) <= 0) return a;
      return b;
    }
    for(;;){
      int l = 2*i+1, r = 2*i+2;
      int m = min(i, min(l,r));
      if( m == i ) return;
      T t = lis[m];
      lis[m] = lis[i];
      lis[i] = t;
      i = m;
    }
  }

  void add(T t){
    lis.add(t);
    heapUp(lis.length-1);
  }

  T peek() => lis[0];

  T take(){
    int len = lis.length;
    if(len == 0) throw new RangeError.value(-1);
    if(len == 1) return lis.removeLast();
    T ret = lis[0];
    lis[0] = lis.removeLast();
    heapDown(0);
    return ret;
  }

  bool get isEmpty => lis.isEmpty;
  bool get isNotEmpty => lis.isNotEmpty;

  @override
  String toString() => lis.toString();
}
