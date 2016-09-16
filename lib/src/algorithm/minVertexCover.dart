import 'dart:math' show min;

class MinVertexCover {
  var edges = [];

  add(a,b){
    edges.add([a,b]);
  }

  // return number of vertices to select
  solve() => run(edges);

  List scan(edges, v){
    var lis = [];
    for(var e in edges) if( e[0] != v && e[1] != v ) lis.add(e);
    return lis;
  }

  run(List edges){
    if( edges.length == 0 ) return 0;
    var n1 = run(scan(edges, edges[0][0])) + 1;
    var n2 = run(scan(edges, edges[0][1])) + 1;
    return min(n1,n2);
  }
}