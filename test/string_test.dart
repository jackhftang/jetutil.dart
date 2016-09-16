import 'dart:math';
import 'package:test/test.dart';
import 'package:jetutil/src/iterable.dart';
import 'package:jetutil/src/data/String.dart';

main(){

//  test('strToInt()', (){
//    var s = "0123456789";
//    expect( strCodeUnits(s, '0'), equals(range(10)));
//  });
//
//  test('strToInt()', (){
//    var s = "abcdefghijklmnopqrstuvwxyz";
//    expect( strCodeUnits(s, 'a'), equals(range(26)));
//  });

  test('stringPeriod()', (){
    var s = '';
    var r = new Random(2);
    var len = 98403;
    for(var i=0; i<len; i++){
      s += r.nextInt(16).toRadixString(16);
    }
//    print(s.substring(0,100));
    var per = stringPeriod(s);
    assert( per == 98403 );
    s = s * ( 5*pow(10,5) ~/ len);
    per = stringPeriod(s);
//    print(s);
    assert( per == 98403 );

  });
}
