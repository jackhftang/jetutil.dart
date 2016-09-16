import 'dart:math';
import 'package:test/test.dart';
import 'package:jetutil/src/numeric.dart';


main(){
//  print('~0 = ${~0}');

  test('bitClearLeast1', (){
    // 0 -> 0
    expect(bitClearLeast1(0), equals(0));
    // 1 -> 0
    expect(bitClearLeast1(1), equals(0));
    // 11 -> 10
    expect(bitClearLeast1(3), equals(2));
    // 110 -> 100
    expect(bitClearLeast1(6), equals(4));
    // -1 -> -2
    expect(bitClearLeast1(-1), equals(-2));
  });

  test('bitSetLeast0', (){
    // 0 -> 1
    expect(bitSetLeast0(0), equals(1));
    // 011 -> 111
    expect(bitSetLeast0(3), equals(7));
    // 101 -> 111
    expect(bitSetLeast0(5), equals(7));
    // 110 -> 111
    expect(bitSetLeast0(6), equals(7));
    // -1 -> -1
    expect(bitSetLeast0(-1), equals(-1));
  });


  test('bitLeast0', (){
    // 0 -> 1
    expect(bitLeast0(0), equals(1));
    // 10 -> 1
    expect(bitLeast0(2), equals(1));
    // 101 -> 10
    expect(bitLeast0(5), equals(2));
    // -1 -> 0
    expect(bitLeast0(-1), equals(0));
  });

  test('bitLeast1', (){
    // 0 -> 0 !!
    expect(bitLeast1(0), equals(0));
    // 1 -> 1
    expect(bitLeast1(0), equals(0));
    // 11 -> 1
    expect(bitLeast1(3), equals(1));
    // 110 -> 10
    expect(bitLeast1(6), equals(2));
  });

}