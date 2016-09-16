import 'dart:math';
import 'package:test/test.dart';
import 'package:jetutil/src/iterable.dart';
import 'package:jetutil/src/numeric.dart' show binomial, factorial;

main(){
  test('range(int n)', (){
    var acc = 0;
    for(var i in range(10)) acc += i;
    expect(acc, equals(45));
  });

  test('cartesian', (){
    var len = 4;
    var lis = 'abc'.split('');
    var cnt = 0;
    cartesian(len, lis, (x){
      print(x);
      cnt++;
    });
    expect(cnt, pow(lis.length, len));
  });


  test('powerSet', (){
    var lis = 'abcdef'.split('');
    var cnt = 0;
    powerSet(lis, (x){
//      print(x);
      cnt++;
    });
    expect(cnt, pow(2,lis.length));
  });

  test('combination', (){
    var lis = 'abcdefgh'.split('');
    var len = 3;
    var cnt = 0;
    combination(len, lis, (x){
      print(x);
      cnt++;
    });
    expect(cnt, binomial(lis.length, len));
  });


  test('permutation', (){
    var s = "abcdef";
    var cnt = 0;
    permutation(s.split(''), (x){
      cnt++;
    });
    expect(cnt, factorial(s.length));
  });

}