import 'dart:math';
import 'dart:collection';

class Edge {
  int to;   // to node index
  num cap;
  int rev;  // reverse node adjacent index

  Edge(this.to, this.cap, this.rev);

  String toString(){
    return '($cap)->$to';
  }
}

// depend on the longest path and number of path
// for large capacity, it is under 10% of time of fulkerson
// on macbook pro 2014, 3000 node ~4.5M edge random graph take 0.3~0.8sec
// O(E^2) the coefficient is small that ~O(V*E)
class MaxFlow {
  int len;
  List<int> level;
  List<int> visited;
  List<List<Edge>> graph;

  MaxFlow(int this.len){
    level = new List(len);
    visited = new List(len);
    graph = new List.generate(len, (i) => []);
  }

  add(from, cap, to){
    graph[from].add(new Edge(to, cap, graph[to].length));
    graph[to].add(new Edge(from,  0, graph[from].length-1));
  }

  // O(E)
  void bfs(s,t){
    // unreachable within distance = -1
    level.fillRange(0, len, -1);

    var q = new Queue();
    level[s] = 0;
    q.add(s);
    while( q.isNotEmpty ){
      var n = q.removeFirst();
      for(var e in graph[n] ){
        if( level[e.to] != -1 || e.cap == 0 ) continue;
        level[e.to] = level[n] + 1;
        // Optimization:
        // all nodes which level < level[t] are already marked
        // when performing dfs, level[e.to] == level[v] + 1 is enough
        if( e.to == t ) return;
        q.add(e.to);
      }
    }
  }

  // O(E)
  num dfs(v, flow, t){
    if( v == t ) return flow;

    while( visited[v] < graph[v].length ){
      var e = graph[v][visited[v]];
      if( e.cap > 0 && level[e.to] == level[v] + 1 ){
        int d = dfs(e.to, min(flow, e.cap), t);
        if( d > 0 ){
          e.cap -= d;
          graph[e.to][e.rev].cap += d;
          return d;
        }
      }
      // Optimization:
      // visited path has no use
      visited[v]++;
    }
    return 0;
  }

  solve(s,t){
    // O(E) loop at most V times
    // do not know how many path
    int len = graph.length;
    num flow = 0;
    while(true){
      bfs(s,t);
      if( level[t] == -1 ) return flow;

      visited.fillRange(0, len, 0);
      while(true){
        var f = dfs(s, double.INFINITY, t);
        if( f == 0 ) break;
        flow += f;
      }
    }
  }
}
