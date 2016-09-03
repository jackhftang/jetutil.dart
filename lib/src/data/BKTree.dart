import 'dart:collection';

class Node<T> {
  T value;
  Map< int, Node<T> > children = new Map();

  Node(this.value);
}


class BKTree<T> {
  Function dist;
  Node<T> root;

  // distance(x,x) = 0.0 forall x
  BKTree(double this.dist(T,T));

  distance(T a, T b){
    return this.dist(a,b);
  }

  add(T elem){
    if( root == null ){
      root = new Node(elem);
      return;
    }

    var n = root;
    while(true){
      var d = distance(n.value, elem);

      // already added
      if( d == 0.0 ) return;

      var ch = n.children[d];
      if( ch == null ){
        n.children[d] = new Node(elem);
        break;
      }
      else n = ch;
    }
  }

  /**
   * range >= 0.0
   */
  query(T elem, num range){
    assert( ! range.isNegative );

    if( root == null ) return [];

    var res = [];
    var q = new Queue();
    q.add(root);
    while( q.isNotEmpty ){
      var n = q.removeFirst();
      var d = distance(n.value, elem);

      // found
      if( d <= range ) res.add(n.value);

      for(var i in n.children.keys){
        if( d - range <= i && i <= d + range ){
          var ch = n.children[i];
          if( ch != null ) q.add(ch);
        }
      }
    }
    return res;
  }
}


//main(){
//  var bk = new BKTree((a,b) => a.distanceTo(b));
//  var r = new Random();
//  for(var i=0; i<100; i++){
//    bk.add(new Point(r.nextDouble(), r.nextDouble()) );
//  }
//
//  print(bk.query(new Point(0.5,0.5), 0.1));
//}