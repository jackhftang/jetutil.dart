import 'dart:math';
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
  add(int parent, int child) {
    tree[parent].add(child);
  }

  build() {
    var n = tree.length;
    encode = new List.filled(n, -1);
    depth = new List.filled(n, -1);

    var seq = [];
    dfs(int n, int dep) {
      if (encode[n] < 0){
        encode[n] = seq.length;
        depth[n] = dep;
      }
      seq.add(n);
      for (var c in tree[n]){
        dfs(c, dep + 1);
        seq.add(n);
      }
    }
    dfs(0, 0);

    var identity = -1;
    segment = new SegmentTree.fromList(seq, identity, (a, b) {
      if( a < 0 ) return b;
      if( b < 0 ) return a;
      return depth[a] <= depth[b] ? a : b;
    });
  }

  // depth of parent == depth[query(a,b)]]
  query(int a, int b) {
    var ixA = encode[a];
    var ixB = encode[b];
    return segment.query(ixA, ixB+1);
  }
}