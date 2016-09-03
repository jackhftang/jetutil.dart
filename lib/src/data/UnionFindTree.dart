// disjoint class
class UnionFindTree {
  List arr;

  UnionFindTree(int len){
    arr = new List.generate(len, (x)=>x);
  }

  int find(int x){
    int p = arr[x];
    if(p == x) return x;
    return arr[x] = find(p);
  }

  void unite(int x, int y){
    int px = find(x), py = find(y);
    arr[px] = py;
  }

  bool same(int x, int y){
    return find(x) == find(y);
  }
}