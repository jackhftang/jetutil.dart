import 'dart:math';
import 'dart:collection';

//class Edge {
//  int to;   // to node index
//  num cap;
//  int rev;  // reverse node adjacent index
//
//  Edge(this.to, this.cap, this.rev);
//}

// depend on the longest path and number of path
// for large capacity, it is under 10% of time of fulkerson
// on macbook pro 2014, 3000 node ~4.5M edge random graph take 0.3~0.8sec
// O(E^2) the coefficient is small that ~O(V*E)
//class MaxFlow {
//  // todo: do not use Edge, use array
//  int len;
//  List<int> level;
//  List<int> visited;
//  List<List<Edge>> graph;
//
//  MaxFlow(int this.len){
//    level = new List(len);
//    visited = new List(len);
//    graph = new List.generate(len, (i) => []);
//  }
//
//  add(from, cap, to){
//    graph[from].add(new Edge(to, cap, graph[to].length));
//    graph[to].add(new Edge(from,  0, graph[from].length-1));
//  }
//
//  // O(E)
//  void bfs(s,t){
//    // unreachable within distance = -1
//    level.fillRange(0, len, -1);
//
//    var q = new Queue();
//    level[s] = 0;
//    q.add(s);
//    while( q.isNotEmpty ){
//      var n = q.removeFirst();
//      for(var e in graph[n] ){
//        if( level[e.to] != -1 || e.cap == 0 ) continue;
//        level[e.to] = level[n] + 1;
//        // Optimization:
//        // all nodes which level < level[t] are already marked
//        // when performing dfs, level[e.to] == level[v] + 1 is enough
//        if( e.to == t ) return;
//        q.add(e.to);
//      }
//    }
//  }
//
//  // O(E)
//  num dfs(v, flow, t){
//    if( v == t ) return flow;
//
//    while( visited[v] < graph[v].length ){
//      var e = graph[v][visited[v]];
//      if( e.cap > 0 && level[e.to] == level[v] + 1 ){
//        int d = dfs(e.to, min(flow, e.cap), t);
//        if( d > 0 ){
//          e.cap -= d;
//          graph[e.to][e.rev].cap += d;
//          return d;
//        }
//      }
//      // Optimization:
//      // visited path has no use
//      visited[v]++;
//    }
//    return 0;
//  }
//
//  solve(s,t){
//    // O(E) loop at most V times
//    // do not know how many path
//    int len = graph.length;
//    num flow = 0;
//    while(true){
//      bfs(s,t);
//      if( level[t] == -1 ) return flow;
//      visited.fillRange(0, len, 0);
//
//      while(true){
//        var f = dfs(s, double.INFINITY, t);
//        if( f == 0 ) break;
//        flow += f;
//      }
//    }
//  }
//}

class MaxFlow {
  List<List<int>> graph;
  List<num> cap = [];
  List<num> to = [];

  MaxFlow(int nNode){
    graph = new List.generate(nNode, (i) => []);
  }

  add(from, capacity, dest){
    graph[from].add(cap.length);
    cap.add(capacity);
    to.add(dest);
    graph[dest].add(cap.length);
    cap.add(0);
    to.add(from);
  }

  reset(){
    assert(cap.length == to.length);
    var len = cap.length;
    for(var i=0; i<len; i+=2){
      cap[i] = cap[i] + cap[i+1];
      cap[i+1] = 0;
    }
  }

  // can re-call after reset()
  solve(s,t){
    int len = graph.length;
    List<int> level = new List(len);
    List<int> next = new List(len);

    // O(E)
    void bfs(){
      // unreachable within distance = -1
      level.fillRange(0, len, -1);

      var q = new Queue();
      level[s] = 0;
      q.add(s);
      while( q.isNotEmpty ){
        var n = q.removeFirst();
        for(var e in graph[n] ){
          if( level[to[e]] != -1 || cap[e] == 0 ) continue;
          level[to[e]] = level[n] + 1;
          // Optimization:
          // all nodes which level < level[t] are already marked
          // when performing dfs, level[e.to] == level[v] + 1 is enough
          if( to[e] == t ) return;
          q.add(to[e]);
        }
      }
    }

    // O(E)
    num dfs(v, flow){
      if( v == t ) return flow;

      while( next[v] < graph[v].length ){
        var e = graph[v][next[v]];
        if( cap[e] > 0 && level[to[e]] == level[v] + 1 ){
          num d = dfs(to[e], min(flow, cap[e]));
          if( d > 0 ){
            cap[e] -= d;
            cap[e^1] += d;
            return d;
          }
        }
        // Optimization:
        // visited path has no use
        next[v]++;
      }
      return 0;
    }

    num flow = 0;
    while(true){
      bfs();
      if( level[t] == -1 ) return flow;

      next.fillRange(0,len,0);
      while(true){
        var f = dfs(s, double.INFINITY);
        // no rounding error, because dfs() return integer 0
        if( f == 0 ) break;
        flow += f;
      }
    }
  }
}