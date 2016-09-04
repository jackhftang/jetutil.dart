import 'package:test/test.dart';
import 'package:jetutil/src/algorithm/leastSquare.dart';

main() {
  check(res, truth, err, [eps = 1e-6]){
    // answer
    expect(res[0], isList);
    expect(res[0].length, equals(truth.length));
    for (var i = 0; i < truth.length; i++) {
      expect(res[0][i], inInclusiveRange(truth[i] - eps, truth[i] + eps));
    }

    // squared error
    expect(res[1], isNonNegative);
    expect(res[1], inExclusiveRange(err-eps, err+eps));
  }

  test('leastSquare(mat, vec) 1', () {
    var mat = [
      [1.0, 2.0, 2.0],
      [1.0, 3.0, 4.0],
      [1.0, 5.0, 6.0],
      [1.0, 7.0, 8.0]
    ];
    var y = [2.0, 2.0, 3.0, 4.0];
    var res = leastSquare(mat, y);

    check(res, [1,1,-0.5], 0.0);
  });


  test('leastSquaire(mat, vec) 2', (){
    var y = [2.0, 2.0, 3.0, 4.0, 3.5];
    var mat2 = [
      [1.0,2.0,2.5],
      [1.0,3.0,4.0],
      [1.0,5.0,6.0],
      [1.0,7.0,8.1],
      [1.0,4.0,7.3]
    ];
    var ans2 = leastSquare(mat2, y);
    check(ans2, [0.802855, 0.0646669, 0.327158], 0.175178);
  });

  test('leastSquaire(mat, vec) 3', (){
    var y = [2.0, 2.0];
    var mat2 = [
      [1.0,2.0,2.5],
      [1.0,3.0,4.0]
    ];
    var ans2 = leastSquare(mat2, y);
    check(ans2, [2.0,0.0,0.0], 0.0);
  });

  test('leastSquaire(mat, vec) 4', (){
    var y = [2.0, 2.0];
    var mat2 = [
      [1.0,2.0,3.0],
      [1.0,2.0,3.0]
    ];
    var ans2 = leastSquare(mat2, y);
    check(ans2, [2.0,0.0,0.0], 0.0);
  });


  test('leastSquaire(mat, vec) 5', (){
    var y = [25,61,97,133];
    var mat2 = [
      [1.0,2.0,3.0],
      [4.0,5.0,6.0],
      [7.0,8.0,9.0],
      [10.0,11.0,12.0]
    ];
    var ans2 = leastSquare(mat2, y);
    check(ans2, [-1.0,13.0,0.0], 0.0);
  });

}