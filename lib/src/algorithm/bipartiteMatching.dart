class BipartiteMatching {
  List<List<int>> graph;
  List avail;
  List match; // contain the matched nodes

  BipartiteMatching(int len){
    graph = new List.generate(len, (i) => [], growable: false);
    match = new List.filled(len, -1);
    avail = new List(len);
  }

  add(int a, int b){
    graph[a].add(b);
    graph[b].add(a);
  }

  bool dfs(int v){
    avail[v] = false;
    for(var u in graph[v] ){
      var m = match[u];
      // if already has a match, find another match
      if( m == -1 || avail[m] && dfs(m) ){
        match[v] = u;
        match[u] = v;
        return true;
      }
    }
    return false;
  }

  solve(){
    var len = graph.length;
    var cnt = 0;
    for(int i=0; i<len; i++){
      if( match[i] == -1 ){
        avail.fillRange(0, len, true);
        if( dfs(i) ) cnt++;
      }
    }
    return cnt;
  }
}