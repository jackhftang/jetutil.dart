//import 'dart:io';

class Vararg extends Function {
  var func;

  Vararg(dynamic this.func(List));

  call() => func([]);

  noSuchMethod(Invocation invocation) {
    final arguments = invocation.positionalArguments;
    return func(arguments);
  }
}

// usage example
//var log = new Vararg((List list){
//  stdout.write( list.first );
//  for(var i=1; i<list.length; i++){
//    stdout.write( ' ' );
//    stdout.write( list[i] );
//  }
//  stdout.write( '\n' );
//});


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

// todo: difference with map reduce?
//classifyFold(Iterable xs, classify, init,  fold){
//  var m = {};
//  for(var x in xs){
//    var c = classify(x);
//    m[c] = fold( m[c] ?? init, x);
//  }
//}
