import 'package:test/test.dart';
import 'package:jetutil/src/iterable.dart';

main(){
  test('range(int n)', (){
    var acc = 0;
    for(var i in range(10)) acc += i;
    expect(acc, equals(45));
  });

//  cartesian(3, ['a','b','c'], (x){
//    print(x);
//  });
//
//  powerSet(['a','b','c'], (x){
//    print(x);
//  });

//  combination(2, ['a','b','c', 'd'], (x){
//    print(x);
//  });

  var s = "abcdefghijkl";
  print(s.length);
  var cnt = 0;
  permutation(s.split(''), (x){
    cnt++;
  });
  print(cnt);
}