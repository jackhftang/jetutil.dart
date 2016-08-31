import 'package:test/test.dart';
import 'package:jetutil/src/iterable.dart';

main(){
  test('range(int n)', (){
    var acc = 0;
    for(var i in range(10)) acc += i;
    expect(acc, equals(45));
  });
}