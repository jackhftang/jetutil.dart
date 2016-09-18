/// deep clone
clone(x){
  if( x is num || x is String || x is bool ) return x;
  if( x is List ) return new List.generate(x.length, (i) => clone(x[i]));
  if( x is Map ){
    var y = {};
    for(var k in x.keys) y[k] = clone(x[k]);
    return y;
  }
  throw new StateError("unsupported type");
}

// todo: use histogram?
//dynamic mode(List arr){
//  if( arr.length == 0 ) return null;
//
//  var mode, m;
//  var cntMode, cnt;
//  mode = m = arr[0];
//  cntMode = cnt = 1;
//
//  for(int i=1; i < arr.length; i++){
//    if( arr[i-1] == arr[i] ) cnt++;
//    else if( cnt > cntMode ){
//      mode = m;
//      cntMode = cnt;
//      m = arr[i];
//      cnt = 1;
//    }
//  }
//
//  return [mode, cntMode];
//}