class Enum<T> {
  Map<T,int> map = {};
  List<T> lis = [];

  int add(T e){
    if( map[e] != null ) return map[e];
    var n = lis.length;
    map[e] = n;
    lis.add(e);
    return n;
  }

  int encode(T e) => map[e];
  T decode(int i) => lis[i];
  get length => lis.length;
}