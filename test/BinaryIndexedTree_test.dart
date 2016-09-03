import 'dart:math';
import 'package:test/test.dart';
import 'package:jetutil/src/data/BinaryIndexedTree.dart';

main(){
  test('BinaryIndexedTree()', (){
    var rand = new Random();
    var len = 100;
    var bit = new BinaryIndexedTree2D(len);
    var mat = new List.generate(len, (i) => new List.filled(len, 0));
    for(var i=0; i<len; i++) for(var j=0; j<len; j++){
      var v = i + j * len;
      bit.add(i+1,j+1, v);
      mat[i][j] = v;
    }

    int q = 5000;
    while( q-- > 0){
      var s = rand.nextInt(len);
      var t = rand.nextInt(len);
      var sum = 0;
      for(var i=0; i<=s; i++){
        for(var j=0; j<=t; j++){
          sum += mat[i][j];
        }
      }
      var bsum = bit.sum(s+1, t+1);
//    print('$s $t $sum $bsum');
      expect(sum, equals(bsum));
    }
//  print(bit.mat);
  });
}