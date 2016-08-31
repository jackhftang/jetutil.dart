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