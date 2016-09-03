import 'dart:math';
import 'package:test/test.dart';
import 'package:jetutil/src/data/Matrix.dart';


main() {
  test('matmul(a,b) 1', () {
    var a = [
      [1,2],
      [3,4]
    ];
    var a2 = matMul(a,a);
    expect(a2, equals([
      [7,10],
      [15, 22]
    ]));
  });

  test('matmul(a,b) 2', () {
    var a = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ];
    var b = [
      [9,8,7],
      [6,5,4],
      [3,2,1]
    ];
    var a2 = matMul(a,b);
    expect(a2, equals([
      [30,24,18],
      [84,69,54],
      [138, 114, 90]
    ]));
  });

  test('matPow(a,n) 1', (){
    var a = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ];
    var b = matPow(a, 3);
    expect(b, equals([
      [468, 576, 684],
      [1062, 1305, 1548],
      [1656, 2034, 2412]
    ]));
  });

  test('matPow(a,n) 1', (){
    var a = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ];
    var b = matPow(a, 10);
    expect(b, equals([
      [132476037840, 162775103256, 193074168672],
      [300005963406, 368621393481, 437236823556],
      [467535888972, 574467683706, 681399478440]
    ]));
  });

  test('matModPow(a,n) 1', (){
    var a = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ];
    var b = matModPow(pow(10,6), a, 10);
    expect(b, equals([
      [037840, 103256, 168672],
      [963406, 393481, 823556],
      [888972, 683706, 478440]
    ]));
  });
}
