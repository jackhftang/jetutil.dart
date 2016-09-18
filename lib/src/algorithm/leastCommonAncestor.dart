import 'package:jetutil/src/data/SegmentTree.dart';


// assume root is index 0
// depth of root is 0
class LeastCommonAncestor {
  List<List> tree;
  SegmentTree<int> segment;
  List<int> encode;
  List<int> depth;

  LeastCommonAncestor(int n) {
    tree = new List.generate(n, (i) => []);
  }

  // assume no repeat children
  // O(1)
  add(int parent, int child) {
    tree[parent].add(child);
  }

  // O(N)
  build() {
    var n = tree.length;
    encode = new List.filled(n, -1);
    depth = new List.filled(n, -1);
    depth[0] = 0;

    // O(N)
    var seq = [];
    var stack = [0];
    while(stack.isNotEmpty){
      var n = stack.removeLast();
      seq.add(n);
      if( encode[n] < 0 ){
        encode[n] = seq.length-1;
        var d = depth[n]+1;
        for(var c in tree[n]){
          depth[c] = d;
          stack.add(n);
          stack.add(c);
        }
      }
    }

    // O(N)
    var identity = -1;
    segment = new SegmentTree.fromList(seq, identity, (a, b) {
      if( a < 0 ) return b;
      if( b < 0 ) return a;
      return depth[a] <= depth[b] ? a : b;
    });
  }

  // depth of parent == depth[query(a,b)]]
  // O(log(N))
  query(int a, int b) {
    var ix1 = encode[a];
    var ix2 = encode[b];
    if( ix2 < ix1 ){
      var t = ix1;
      ix1 = ix2;
      ix2 = t;
    }
    return segment.query(ix1, ix2+1);
  }

  distance(int a, int b){
    var p = query(a,b);
    return depth[a] + depth[b] - 2*depth[p];
  }
}