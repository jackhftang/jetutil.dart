/* List */
void swap(List lis, int i, int j){
  var t = lis[i];
  lis[i] = lis[j];
  lis[j] = t;
}

List<int> indicesOf(List list, e){
  var ixs = [];
  for(var ix = list.indexOf(e); ix != -1; ix = list.indexOf(e,ix) ) ixs.add(ix);
  return ixs;
}


num summation(Iterable ite){
  // return 0 if empty (unlike reduce)
  var t = 0;
  for(var i in ite) t += i;
  return t;
}
num product(Iterable ite){
  var t = 1;
  for(var i in ite) t *= i;
  return t;
}


