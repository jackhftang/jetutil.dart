import 'dart:math';
import 'package:test/test.dart';
import 'package:jetutil/src/data/List.dart';

main(){
  test('listCompare(a,b) 1', (){
    var a = [1,2,4];
    var b = [1,3,4];
    expect( listCompare(a,b), equals(-1));
  });
  test('listCompare(a,b) 2', (){
    var a = [1,3,4];
    var b = [1,2,4];
    expect( listCompare(a,b), equals(1));
  });
  test('listCompare(a,b) 3', (){
    var a = [1,2];
    var b = [1,2];
    expect( listCompare(a,b), equals(0));
  });
}