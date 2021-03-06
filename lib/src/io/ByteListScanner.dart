class ByteListScanner {
  static const int EOF = -1;
  static const int NEW_LINE = 10;
  static const int SPACE = 32;
  static const int MINUS = 45;
  static const int DOT = 46;
  static const int ZERO = 48;
  static const int NINE = 57;
  static const int A = 65;
  static const int Z = 90;
  static const int a = 97;
  static const int z = 122;
  static final isDigit  = (int n) => ZERO <= n && n <= NINE;
  static final isUpperLetter = (int n) => A <= n && n <= Z;
  static final isLowerLetter = (int n) => a <= n && n <= z;
  static final isLetter = (int n) => isLowerLetter(n) ||  isUpperLetter(n);

  int ix = 0;
  List<int> content;

  ByteListScanner(this.content);

  int nextByte(){
    return ix >= content.length ? EOF : content[ix++];
  }

  int peekByte(){
    return ix >= content.length ? EOF : content[ix];
  }

  void _next(){ ix++; }

  String nextChar(){
    return new String.fromCharCode(nextByte());
  }

  String nextWord([accept]){
    StringBuffer buf = new StringBuffer();
    if(accept == null) accept = (c) => c != NEW_LINE && c != SPACE;
    int c;
    while( !accept(c=peekByte()) && c != EOF) _next();
    while( accept(c=peekByte()) && c != EOF){ buf.writeCharCode(c); _next(); }
    return buf.toString();
  }

  String nextLine(){
    StringBuffer buf = new StringBuffer();
    var accept = (c) => c != NEW_LINE;
    int c;
    while( !accept(c=peekByte()) && c != EOF) _next();
    while( accept(c=peekByte()) && c != EOF){ buf.writeCharCode(c); _next(); }
    return buf.toString();
  }

  int nextInt([int base=10]){
    // only support base 2 to 10
    int integer(int n){
      int c = peekByte();
      while( isDigit(c) ){
        n = base*n+c-ZERO;
        _next();
        c = peekByte();
      }
      return n;
    }
    for(int c = nextByte(); c != EOF; c = nextByte() ){
      if( isDigit(c) ) return integer(c-ZERO);
      else if ( c == MINUS && isDigit(c = nextByte()) ) return -integer(c-ZERO);
    }
    return 0;
  }

  double nextDouble(){
    double decimal(double f){
      double b = 1.0;
      for(int c = peekByte(); isDigit(c); c = peekByte() ){
        b /= 10.0; f += b*(nextByte()-ZERO);
      }
      return f;
    }
    double integer(int n){
      int c = peekByte();
      while(isDigit(c)){
        n = 10*n+c-ZERO;
        _next();
        c = peekByte();
      }
      if( c == DOT ){ nextByte(); return decimal(0.0) + n; }
      return 0.0 + n;
    }
    for(int c=nextByte(); c >=0; c=nextByte() ){
      if( isDigit(c) ) return integer(c-ZERO);
      else if( c == MINUS && isDigit(c = nextByte())) return -integer(c-ZERO);
    }
    return 0.0;
  }

  bool get isEOF => ix >= content.length;
  bool get isNotEOF => ix < content.length;
}