%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#define YYSTYPE char*
char idstr[50];
char numstr[50];
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}
%token NUMBER
%token ID
%token ADD SUB MUL DIV LKO RKO
%left LKO
%left ADD SUB
%left MUL DIV
%right UMINUS
%right RKO
%%

lines : lines expr '\n'{printf("%s\n",$2);}
      | lines '\n'
      |
      ;

expr : expr ADD expr {$$=(char*)malloc(50*sizeof(char)); strcpy($$,$1);
                      strcat($$,$3);strcat($$,"+"); }
     | expr SUB expr {$$=(char*)malloc(50*sizeof(char)); strcpy($$,$1);
                      strcat($$,$3);strcat($$,"-"); }
     | expr MUL expr {$$=(char*)malloc(50*sizeof(char)); strcpy($$,$1);
                      strcat($$,$3);strcat($$,"*"); }
     | expr DIV expr {$$=(char*)malloc(50*sizeof(char)); strcpy($$,$1);
                      strcat($$,$3);strcat($$,"/"); }
     | LKO expr RKO {$$=(char*)malloc(50*sizeof(char));strcpy($$,$2);}
     | NUMBER   {$$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1);
                 strcat($$," ");}
     | ID   {$$=(char*)malloc(50*sizeof(char));
             strcpy($$,$1);strcat($$," ");}


%%


int yylex()
{
      int t;
      while(1){
          t=getchar();     
          if(t==' '||t=='\t');
          else if((t>='0'&& t<='9')){
                   int ti=0;
                  while((t>='0'&& t<='9')){
                  numstr[ti]=t;
                  t=getchar();
                  ti++;
                }
           numstr[ti]='\0';
           yylval=numstr;
           ungetc(t,stdin);
           return NUMBER;
         }
      else if((t>='a'&&t<='z')||(t>='A'&&t<='Z')||(t=='_')){
              int ti=0;
              while((t>='a'&&t<='z')||(t>='A'&&t<='Z')
                     ||(t=='_')||(t>='0'&& t<='9')){
                      idstr[ti]=t;
                      ti++;
                      t=getchar();
                  }
               idstr[ti]='\0';
               yylval=idstr;
               ungetc(t,stdin);
               return ID;
             }
       else 
          {
            switch(t)
           {
              case '+':
                   return ADD;
              case '-':
                   return SUB;
              case '*':
                   return MUL;
              case '/':
                   return DIV;
              case'(':
                   return LKO;
              case')':
                   return RKO;
              default: 
                   return t;
            }
          }
      return t;
   }
}

int main(void)
{
   yyin = stdin;
  do{
      yyparse();
    }while(!feof(yyin));
  return 0;
}
void yyerror(const char* s)
{
   fprintf(stderr,"Parse error:%s\n",s);
   exit(1);
}




