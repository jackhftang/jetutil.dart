import 'dart:math';

min3(a,b,c) => min(a, min(b,c));
mid3(a,b,c) => a < b ? max(a,min(b,c)) : max(b,min(a,c));
max3(a,b,c) => max(a, max(b,c));
min4(a,b,c,d) => min(min(a,b), min(c,d));
max4(a,b,c,d) => max(max(a,b), max(c,d));

//int avg2(a,b) => (a&b) + ((a^b)>>1);

int bsearchMin(int a, int b, test){
  // b is true and valid
  while(b-a != 1){
    int mid = (a+b)~/2;
    if(test(mid)) b = mid;
    else a = mid;
  }
  return b;
}

int bsearchMax(int a, int b, test){
  // a is true and valid
  while(b-a != 1){
    int mid = (a+b)~/2;
    if(test(mid)) a = mid;
    else b = mid;
  }
  return a;
}

/* bit */
int bitCnt(int n){
  int cnt = 0;
  while(n>0){ cnt++; n &= n-1; }
  return cnt;
}

int bitClearLeast1(int n) => n & (n-1);
int bitSetLeast0(int n) => n | (n+1);
int bitLeast0(int n) => ~n & (n+1);
int bitLeast1(int n) => n & -n;

/* arithmetic */
int sqrtFloor(int n) => bsearchMax(0,(1<<31),(i) => i*i <= n);
int sqrtCeil(int n) => bsearchMin(-1,(1<<31),(i) => n <= i*i);

int factorial(int n) => n == 0 ? 1 : n * factorial(n-1);
int binomial(int n, int r){
  if( 2 * r > n ) r = n-r;
  int ans = 1;
  for(int i=1; i<=r; i++) ans = (ans*n--)~/i;
  return ans;
}

int gcd(a,b) => b == 0 ? a : gcd(b, a%b);
List<num> extgcd(a,b){
  if(b==0) return [1,0,a];
  var t = extgcd(b,a%b);
  var x=t[0], y=t[1], g=t[2];
  return [y, x-(a~/b)*y,g];
}

int logFloor(int b, int n){
  // defined when n > 0, b > 1
  assert(n > 0);
  assert(b > 1);
  int cnt = -1, t = 1;
  while( t <= n ){ t *= b; cnt++; }
  return cnt;
}
int logCeil(int b, int n){
  // defined when n > 0, b > 1
  assert(n > 0);
  assert(b > 1);
  var cnt = 0;
  int t = 1;
  while(t < n){ t *= b; cnt++; }
  return cnt;
}

/* modulo */


// dart auto-normalize modulo
//int modNorm(int m, int x){
//  int t = x % m;
//  return t < 0 ? t + m : t;
//}

int modPow(int m, int x, int n){
  int acc = 1; x %= m;
  while(n != 0){
    if( n & 1 == 1 )  acc = acc*x%m;
    x = x*x%m;
    n >>= 1;
  }
  return acc;
}
int modInv(int m, int i){
  var arr = extgcd(m,i);
  int x = arr[1], g = arr[2]; // 0 < g && 0 <= x < m
  assert( g == 1 );     // condition for multiplicative inverse exist
  return x%m;
}


num dot(List a, List b){
  assert(a.length == b.length);
  var len = a.length, acc = 0;
  for(var i=0; i<len; i++) acc += a[i] * b[i];
  return acc;
}


double mean(List<num> x){
  assert(x.length > 0);
  var s = 0.0;
  for(var i in x) s += i;
  return s/x.length;
}

double covariance(List<num> x, List<num> y){
//  if( x.length != y.length ) throw new StateError('unequal dimension');
  assert( x.length == y.length );

  var len = x.length, s = 0.0;
  var mx = mean(x), my = mean(y);
  for(var i=0; i<len; i++) s += (x[i]-mx)*(y[i]-my);
  return s/len;
}

double variance(List<num> x){
  var mx = mean(x), s = 0.0;
  for(var i in x) s += (i-mx)*(i-mx);
  return s/x.length;
}

double standardDeviation(List<num> x){
  return sqrt(variance(x));
}

double correlation(List<num> x, List<num> y){
//  if( x.length != y.length ) throw new StateError('unequal dimension');
  assert( x.length == y.length );

  var len = x.length;
  var mx = mean(x), my = mean(y);
  var sxx = 0, syy = 0, sxy = 0;
  for(var i=0; i<len; i++){
    var a = x[i]-mx;
    var b = y[i]-my;
    sxx += a*a;
    syy += b*b;
    sxy += a*b;
  }
  // due to floating point,
  // sometimes sxy/sqrt(sxx)/sqrt(syy) is slightly out bound
  // to reduce surprise, normalize it.
  return max(-1.0, min(1.0, sxy/sqrt(sxx)/sqrt(syy)));
}

