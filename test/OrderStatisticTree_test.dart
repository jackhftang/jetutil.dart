import 'dart:math';
import 'dart:collection';
import 'package:test/test.dart';
import 'package:jetutil/src/data/OrderStatisticTree.dart';

const SIZE = 2000;
const SEED = 88;

takeMinTest(){
  var size = SIZE;
  var n = new OrderStatisticTree();
  for(var i=0; i<size; i++){
    n.add(i);
    assert(n.size == i+1);
    assert(n.isAllValid);
    assert(n.verify(-1, size));
  }
//  print(n);
  var i = 0;
  while( n.isNotDummy ){
    var t = n.removeMin();
    assert(t == i++);
    assert(n.size == size-i);
    assert(n.isAllValid);
    assert(n.verify(-1, size));
  }
}

takeMaxTest(){
  var size = SIZE;
  var n = new OrderStatisticTree();
  for(var i=size; i-- >0; ){
    n.add(i);
    assert(n.size == size-i);
    assert(n.isAllValid);
    assert(n.verify(-1, size));
  }
  var i=size-1;
//  print(n);
  while( n.isNotDummy ){
    var t = n.removeMax();
    assert(n.size == i);
    assert(t == i--);
    assert(n.isAllValid);
    assert(n.verify(-1, size));
  }
}

removeTest(){
  var size = SIZE;
  var n = new OrderStatisticTree();
  var r = new Random(SEED);
  var v = new List.generate(size, (i) => i);
  v.shuffle();
  for(var i=0; i<size; i++){
    n.add(v[i]);
    assert(n.size == i+1);
    assert(n.isAllValid);
    assert(n.verify(-1, size));
  }
  var j = size;
  while(v.isNotEmpty){
    var x = v.removeLast();
//    print('removing $x');
    n.remove(x);
//    print(n);
    assert(n.size == --j);
    assert(n.isAllValid);
    assert(n.verify(-1, size));
  }
}

peekAndRemoveTest(){
  var size = SIZE;
  var arr = new List.generate(size, (i) => i)..shuffle();
  var vs = [];
  var n = new OrderStatisticTree();
  for(var i=0; i<size; i++){
    var x = arr[i];
    vs.add(x);
    n.add(x);
    assert(n.size == i+1);
    assert(n.isAllValid);
    assert(n.verify(-1, size));
  }
  vs.sort();
  var q = new Queue.from(vs);
  while(q.isNotEmpty){
    var mi = q.removeFirst();
    var mx = q.removeLast();
    assert(n.peekMin() == mi);
    assert(n.peekMax() == mx);
    assert(n.verify(mi-1, mx+1));
    n.remove(mi);
    n.remove(mx);
    assert(n.size == q.length);
  }
}

rankTest(){
  var trans = (x) => x*2.0;
  var vs = new List.generate(SIZE, trans);
  var n = new OrderStatisticTree<double>();
  var r = new Random(SEED);
  vs.shuffle(r);
  for(var i=0; i<vs.length; i++){
    n.add(vs[i]);
    var t = vs.sublist(0,i+1)..sort();
    for(var j=0; j<t.length; j++){
      assert(n.select(j) == t[j]);
      assert(n.rank(t[j]) == j);
    }
    assert(n.select(t.length) == null);
    assert(n.rank(0.123) == -1);
  }
}

maxUnderAndMinOverTest(){
  var size = SIZE;
  var n = new OrderStatisticTree();
  for(var i=0; i<size; i++){
    n.add(i);
  }
  for(var i=1; i<size-1; i++){
//    print('$i ${n.maxUnder(i)} ${n.maxOver(i)}');
    assert( n.maxUnder(i) == i-1 );
    assert( n.minOver(i) == i+1 );
    assert( n.maxUnderEqual(i) == i );
    assert( n.minOverEqual(i) == i );
  }
}


main() {
  test('takeMin', takeMinTest);
  test('takeMax', takeMaxTest);
  test('remove', removeTest);
  test('peekAndRemove', peekAndRemoveTest);
  test('rank', rankTest);
  test('maxUnderAndMinOver', maxUnderAndMinOverTest);
}
