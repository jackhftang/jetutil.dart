


// 1-base
// specifically for online summation query
class BinaryIndexedTree {
  List<int> arr;

  BinaryIndexedTree(int len){
    // max-index is len, 1-base
    arr = new List.filled(len+1, 0);
  }

  // 1-based
  void add(int i, int x){
    int len = arr.length;
    if(i == 0) return;
    while( i < len ){
      arr[i] = arr[i] + x;
      i += i & -i;
    }
  }

  // 1-based, sum[1,i] inclusive
  int sum(int i){
    int acc = 0;
    while(i > 0){
      acc += arr[i];
      i -= i & -i;
    }
    return acc;
  }

}


class BinaryIndexedTree2D {
  List<List<int>> mat;

  BinaryIndexedTree2D(int len){
    mat = new List.generate(len+1, (i) => new List.filled(len+1, 0) );
  }

  // 1-based
  void add(int i, int J, int x){
    if( i == 0 || J == 0 ) return;
    int len = mat.length;
    while( i < len ){
      int j = J;
      while( j < len ){
        mat[i][j] += x;
        j += j & -j;
      }
      i += i & -i;
    }
  }

  // 1-based, sum[1..i][1..J] inclusive
  int sum(int i, int J){
    // [i,j] inclusive
    if( i == 0 || J == 0 ) return 0;
    int acc = 0;
    while( i > 0 ){
      int j = J;
      while( j > 0 ){
        acc += mat[i][j];
        j -= j & -j;
      }
      i -= i & -i;
    }
    return acc;
  }
}

