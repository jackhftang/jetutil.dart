import 'dart:collection' show Queue;

class HornSAT {
  static const FALSE = -1;
  int len;                  // number of variables
  List<List<int> > dep;     // dep[i] clause that depend on i

  // refCnt.length == pop.length
  List<int> falsity = [];   // number of false in a clause
  List<int> pop = [];       // n-th variable to turn false to true
  // number of clause = fact.length + pop.length
  List<int> fact = [];      // must be true initially

  HornSAT(int this.len){
    dep = new List.generate(len, (i) => []);
  }

  // element in negs must be distinct for refCnt to work
  add(int pos, List<int> negs ){
    // assert( negs.indexOf(pos) == -1 )
    if( negs.length > 0 ){
      var j = falsity.length;
      falsity.add(negs.length);
      pop.add( pos == null ? FALSE : pos);
      // dep[i] mentioned in clause-j
      for(var i in negs) dep[i].add(j);
    }
    else {
      // must be true
      fact.add(pos);
    }
  }

  // return null if no solution
  solve(){
    var assignment = new List.filled(len, false);
    var q = new Queue();
    for(var i in fact){
      q.add(i);
      while(q.isNotEmpty){
        var b = q.removeFirst();
        assignment[b] = true;
        for(var j in dep[b]){
          if( --falsity[j] == 0 ){
            var c = pop[j];
            if( c < 0 ) return null;
            if(!assignment[c]) q.add(c);
          }
        }
      }
    }
    return assignment;
  }
}
