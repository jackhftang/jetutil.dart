
/* List */
List list(int len, [x]){
  if( x is Function ) return new List.generate(len, x);
  if( x == null ) return new List(len);
  return new List.filled(len, x);
}

listClone(List x) => new List.from(x);

void swap(List lis, int i, int j){
  var t = lis[i];
  lis[i] = lis[j];
  lis[j] = t;
}

List<int> indices(List list, e){
  var ix = [];
  for(var i = list.indexOf(e); i != -1; i = list.indexOf(e,i) ) ix.add(i);
  return ix;
}

listReverse(List lis, [int start=0, int end]){
  end ??= lis.length;
  while( start < end ) swap(lis, start, end);
}

listCompare(List a, List b){
  assert( a.length == b.length );
  int len = a.length;
  for(var i=0; i<len; i++){
    var n = Comparable.compare(a[i], b[i]);
    if( n != 0 ) return n;
  }
  return 0;
}


