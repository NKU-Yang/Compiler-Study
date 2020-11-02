#include<iostream>
using namespace std;

int main()//Fibonacci function
{
     int a,b,i,n,t;
     a=0;
     b=1;
     i=1;
     cin>>n;
     cout<<a<<endl;
     cout<<b<<endl;
     while(i<n)
     {
	     t=b;
	     b=a+b;
	     cout<<b<<endl;
	     a=t;
	     i=i+1;
     }
     cout<<"new a is"<< a <<endl;
     cout<<"new b is"<< b <<endl;
     return 0;
}

