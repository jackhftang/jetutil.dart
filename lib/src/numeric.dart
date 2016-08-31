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

/* arithmetic */
int sqrtFloor(int n) => bsearchMax(0,(1<<31),(i) => i*i <= n);
int sqrtCeil(int n) => bsearchMin(-1,(1<<31),(i) => n <= i*i);

int factorial(int n) => n == 0 ? 1 : n * factorial(n-1);

int gcd(a,b) => b == 0 ? a : gcd(b, a%b);
List<num> extgcd(a,b){
  if(b==0) return [1,0,a];
  var t = extgcd(b,a%b);
  var x=t[0], y=t[1], g=t[2];
  return [y, x-(a~/b)*y,g];
}

int logFloor(int b, int n){
  // defined when n > 0, b > 1
  int cnt = -1, t = 1;
  while( t <= n ){ t *= b; cnt++; }
  return cnt;
}
int logCeil(int b, int n){
  // defined when n > 0, b > 1
  var cnt = 0;
  int t = 1;
  while(t < n){ t *= b; cnt++; }
  return cnt;
}

int modpow(int m, int x, int n){
  int acc = 1; x %= m;
  while(n != 0){
    if( n & 1 == 1 )  acc = acc*x%m;
    x = x*x%m;
    n >>= 1;
  }
  return acc;
}
int modinv(int m, int i){
  var arr = extgcd(m,i);
  int x = arr[1], g = arr[2]; // 0 < g && 0 <= x < m
  return (g.sign * x)%m;
}