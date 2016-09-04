
// useful with map s.map(toCodeUnit('a')).toList();
//Function toCodeUnit([String n = '\0']) => (String s) => s.codeUnitAt(0) - n.codeUnitAt(0);

// convenient method for s.codeUnits.map( (n) => n - ref.codeUnitAt(0) ).toList();
//List strCodeUnits(String s, String ref){
//  var n = ref.codeUnitAt(0);
//  return new List.generate(s.length, (i) => s[i].codeUnitAt(0) - n );
//}

int codeUnit(String s) => s.codeUnitAt(0);