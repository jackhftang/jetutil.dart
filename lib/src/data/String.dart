
// useful with map s.map(toCodeUnit('a')).toList();
//Function toCodeUnit([String n = '\0']) => (String s) => s.codeUnitAt(0) - n.codeUnitAt(0);

// convenient method for s.codeUnits.map( (n) => n - ref.codeUnitAt(0) ).toList();
//List strCodeUnits(String s, String ref){
//  var n = ref.codeUnitAt(0);
//  return new List.generate(s.length, (i) => s[i].codeUnitAt(0) - n );
//}

int codeUnit(String s) => s.codeUnitAt(0);

int stringPeriod(String s){
  // native method, O(s.length^2)
  // could be done in O(s.length)
  int len = s.length;

  bool isPeriod(int l){
    int rep = len ~/ l;
    for(var i=1; i<rep; i++){
      for(var j=0; j<l; j++){
        if( s[i*l+j] != s[j] ) return false;
      }
    }
    return true;
  }

  for(int i=1; i<=(len+1)/2; i++){
    if( len % i == 0 && isPeriod(i) ) return i;
  }

  return len;
}

Function kmp(String pat){
  // failure[i] = the length of longest prefix-suffix of pat.substring(0,i)
  var failure = new List(pat.length);
  var p = failure[0] = 0;             // current prefix length
  for(var i=1; i<pat.length; i++){
    if( pat[i] == pat[p] ) p++;
    else p = pat[i] == pat[0] ? 1 : 0;
    failure[i] = p;
  }

  return (String str, [i=0]){
    // find the next match index starting from i
    int l=0;
    while(true){
      if( l == failure.length ) return i;
      if( i+l >= str.length ) return -1;

      if( str[i+l] == pat[l] ) l++;
      else if( l == 0 ) i++;      // no match at all
      else {
        int k = failure[l-1];     // get longest prefix-suffix
        i += l-k; l = k;
      }
    }
  };
}
