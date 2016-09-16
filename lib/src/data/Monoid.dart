class Histogram<E> {
  Map<E, int> map = {};

  Histogram();

  Histogram.fromIterable(Iterable<E> iterable){
    for(var x in iterable) add(x);
  }

  get keys => map.keys;
  get values => map.values;
  get length => map.length;
  get isEmpty => map.isEmpty;
  get isNotEmpty => map.isNotEmpty;

  void add(E x){
    map[x] = (map[x] ?? 0) + 1;
  }

  void addAll(Iterable<E> xs){
    for(var x in xs) add(x);
  }

  bool contains(E x) => map[x] != null;

  int remove(E x) => map.remove(x);

  int operator [](k) => map[k] ?? 0;

  List<List> toList() => keys.map((k) => [k, map[k]]);
}

class Reduce<T> {
  // null as default identity element
  T value = null;
  var reduce;

  Reduce(T this.reduce(T a, T b));

  add(T x){
    if( value == null ) value = x;
    else value = reduce(value, x);
  }

  addAll(Iterable<T> xs){
    for(var x in xs) add(x);
  }

  String toString() => value.toString();
}

//class Max extends Reduce<Comparable> {
//  // return first max
//  var transform;
//
//  Max([Function this.transform]) : super((a, b){
//    var a_ = transform(a);
//    var b_ = transform(b);
//    return Comparable.compare(a,b) < 0 ? b : a;
//  }){
//    transform ??= (x) => x;
//  }
//}
//
//class Min extends Reduce<Comparable> {
//  var transform;
//
//  Min([Function this.transform]) : super((a, b){
//    return Comparable.compare(a,b) > 0 ? b : a;
//  }){
//    transform ??= (x) => x;
//  }
//}
