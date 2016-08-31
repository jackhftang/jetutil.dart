import 'dart:math';
import 'numeric.dart';

// O( sqrt(n) )
bool isPrime(int n){
  if( n <= 1 ) return false;
  if( n <= 3 ) return true;
  if( n % 2 == 0 || n % 3 == 0 ) return false;
  int up = sqrtFloor(n);
  int i = 5;
  while( i <= up ){
    if( n % i == 0 || n % (i+2) == 0 ) return false;
    i += 6;
  }
  return true;
}

// return first N primes
// good when len < 10000 ~= sieveUnder(1e5)
List<int> primeList(int len){
  var lis = new List.filled(len, 0);
  if( len == 0 ) return lis;
  int i = 0;
  lis[i++] = 2;
  int t = 3;
  bool isPrime(i, t){
    for(var j=0; j<i; j++){
      if( t % lis[j] == 0 ) return false;
    }
    return true;
  }
  while( i < len ){
    if( isPrime(i,t) ) lis[i++] = t;
    t += 2;
  }
  return lis;
}

///////////////////////////////////////////////////////////


// good when n < 1e6
List<int> sieveUnder(int n){
  var sieve = new List.filled(n, true);
  for(var i=0; i < min(n,2); i++) sieve[i] = false;
  var up = sqrtFloor(n);
  for(var i=2; i<=up; i++){
    for(var j=2*i; j<n; j+=i) sieve[j] = false;
  }
  return sieve;
}

List<int> primeUnder(int n){
  var sieve = sieveUnder(n);
  var cnt = 0;
  for(var i in sieve) if(i) cnt++;
  var primes = new List.filled(cnt, 0);
  var j=0;
  for(var i=2; i<n; i++) if( sieve[i] ) primes[j++] = i;
  return primes;
}

///////////////////////////////////////////////////////////

List<int> factorizeList(List<int> primes, int n){
  var fs = [];
  var i = 0;
  while( true ){
    if( n == 1 ) return fs;
    if( i == primes.length ){
      fs.add(n);
      return fs;
    }
    int p = primes[i];
    if( n % p == 0 ){
      fs.add( p );
      n ~/= p;
    }
    else i++;
  }
}

List<List> factorizeBag(List<int> primes, int n){
  var fs = [];
  var i = 0;
  while( true ){
    if( n == 1 ) return fs;
    if( i == primes.length ){
      fs.add([n,1]);
      return fs;
    }
    int p = primes[i++];
    int cnt = 0;
    while( n % p == 0 ){
      n ~/= p;
      cnt++;
    }
    if( cnt > 0 ) fs.add([p,cnt]);
  }
}

///////////////////////////////////////////////////////////

// sum of all factors of n including 1 and n
int factorSum(List<int> primes, int n){
  var bag = factorizeBag(primes, n);
  var acc = 1;
  for(var e in bag){
    var p = e[0];
    var n = e[1];
    acc *= (pow(p,n+1)-1) ~/ (p-1);
  }
  return acc;
}