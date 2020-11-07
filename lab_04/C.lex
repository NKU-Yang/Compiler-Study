%top{
#include<math.h>
#include<string.h>
}

%{
#define VOID 1
#define CHAR 2
#define INT  3
#define SIZEOF 4
#define CONST 5
#define RETURN 6
#define CONTINUE 7
#define BREAK 8
#define WHILE 9
#define IF 10
#define ELSE 11
#define SWITCH 12
#define CASE 13
#define FOR 14
#define DO 15
#define SCANF 16
#define PRINTF 17
#define LC 35 //{
#define RC 36 //}
#define LB 37 //[
#define RB 38 //]
#define LP 39 //(
#define RP 40 //)
#define LOGRE 41//~
#define INPLUS 42//++
#define INMINUS 43//--
#define LOCRE 44//!
#define AND 45//&
#define STAR 46//*
#define DIVOP 47// /
#define COMOP 71// %
#define PLUS  48//+
#define MINUS 49//-
#define RELG 50//>
#define RELGEQ 51//>=
#define RELL 52//<
#define RELLEQ 53//<=
#define EQUOP 54//==
#define UEQUOP 55//!=
#define ANDAND 56//&&
#define OROR 57// ||
#define EQUAL 58// =
#define ASSIGNDIV 59// /=
#define ASSIGNSTAR 60 //*=
#define ASSIGNCOM 61 //%=
#define ASSIGNPLUS 62 //+=
#define ASSIGNMINUS 63 //-=
#define COMMA 64 //,
#define SHA 65 //#
#define SEMI 66//;
#define COLON 67//:
#define ID 68 //identifyer
#define NUMBER 69 //number
#define DEFAULT 70//default
%}
white [\t\n ]
digit [0-9]
letter [A-Za-z]
id ({letter}|_)({letter}|{digit}|_)*
number [1-9]{digit}*|0
commentbegin "/*"
commentelement .|\n
commentend "*/"
%x COMMENT
%%
{commentbegin} {BEGIN COMMENT; fprintf(yyout,"Begin a comment:\n");}
<COMMENT>{commentelement} {fprintf(yyout,"%s",yytext);}
<COMMENT>{commentend} {BEGIN INITIAL; fprintf(yyout,"\nthis comment End!\n");}
{white}+ ;
{id} {fprintf(yyout,"ID %d %s\n",ID,yytext);}
{number} {fprintf(yyout,"NUMBER %d %s\n",NUMBER,yytext);}
"void" {fprintf(yyout,"VOID %d %s\n",VOID,yytext);}
"char" {fprintf(yyout,"CHAR %d %s\n",CHAR,yytext);}
"int"  {fprintf(yyout,"INT %d %s\n",INT,yytext);}
"sizeof" {fprintf(yyout,"SIZEOF %d %s\n",SIZEOF,yytext);}
"const" {fprintf(yyout,"CONST %d %s\n",CONST,yytext);}
"return" {fprintf(yyout,"RETURN %d %s\n",RETURN,yytext);}
"continue" {fprintf(yyout,"CONTINUE %d %s\n",CONTINUE,yytext);}
"break" {fprintf(yyout,"BREAK %d %s\n",BREAK,yytext);}
"if" {fprintf(yyout,"IF %d %s\n",IF,yytext);}
"else" {fprintf(yyout,"ELSE %d %s\n",ELSE,yytext);}
"switch" {fprintf(yyout,"SWITCH	%d %s\n",SWITCH,yytext);}
"case" {fprintf(yyout,"CASE %d %s\n",CASE,yytext);}
"default" {fprintf(yyout,"DEFAULT %d %s\n",DEFAULT,yytext);}
"for" {fprintf(yyout,"FOR %d %s\n",FOR,yytext);}
"do" {fprintf(yyout,"DO	%d %s\n",DO,yytext);}
"while" {fprintf(yyout,"WHILE %d %s\n",WHILE,yytext);}
"scanf" {fprintf(yyout,"SCANF %d %s\n",SCANF,yytext);}
"printf" {fprintf(yyout,"PRINTF %d %s\n",PRINTF,yytext);}
"{" {fprintf(yyout,"LC %d %s\n",LC,yytext);}
"}" {fprintf(yyout,"RC %d %s\n",RC,yytext);}
"[" {fprintf(yyout,"LB %d %s\n",LB,yytext);}
"]" {fprintf(yyout,"RB %d %s\n",RB,yytext);}
"(" {fprintf(yyout,"LP %d %s\n",LP,yytext);}
")" {fprintf(yyout,"RP %d %s\n",RP,yytext);}
"~" {fprintf(yyout,"LOGRE %d %s\n",LOGRE,yytext);}
"++" {fprintf(yyout,"INPLUS %d %s\n",INPLUS,yytext);}
"--" {fprintf(yyout,"INMINUS %s %d\n",INMINUS,yytext);}
"!" {fprintf(yyout,"LOCRE %d %s\n",LOCRE,yytext);}
"*" {fprintf(yyout,"STAR %d %s\n",STAR,yytext);}
"/" {fprintf(yyout,"DIVOP %d %n\n",DIVOP,yytext);}
"%" {fprintf(yyout,"COMOP %d %s\n",COMOP,yytext);}
"+" {fprintf(yyout,"PLUS %d %s\n",PLUS,yytext);}
"-" {fprintf(yyout,"MINUS %d %s\n",MINUS,yytext);}
">" {fprintf(yyout,"RELG %d %s\n",RELG,yytext);}
"<" {fprintf(yyout,"RELL %d %s\n",RELL,yytext);}
">=" {fprintf(yyout,"RELGEQ %d %s\n",RELGEQ,yytext);}
"<=" {fprintf(yyout,"RELLEQ %d %s\n",RELLEQ,yytext);}
"==" {fprintf(yyout,"EQUOP %d %s\n",EQUOP,yytext);}
"!=" {fprintf(yyout,"UEQUOP %d %s\n",UEQUOP,yytext);}
"&&" {fprintf(yyout,"ANDAND %d %s\n",ANDAND,yytext);}
"||" {fprintf(yyout,"OROR %d %s\n",OROR,yytext);}
"=" {fprintf(yyout,"EQUAL %d %s\n",EQUAL,yytext);}
"/=" {fprintf(yyout,"ASSIGNDIV %d %s\n",ASSIGNDIV,yytext);}
"*=" {fprintf(yyout,"ASSIGNSTAR %d %s\n",ASSIGNSTAR,yytext);}
"%=" {fprintf(yyout,"ASSIGNCOM %d %s\n",ASSIGNCOM,yytext);}
"+=" {fprintf(yyout,"ASSIGNPLUS %d %s\n",ASSIGNPLUS,yytext);}
"-=" {fprintf(yyout,"ASSIGNMINUS %d %s\n",ASSIGNMINUS,yytext);}
"," {fprintf(yyout,"COMMA %d %s\n",COMMA,yytext);}
"#" {fprintf(yyout,"SHA %d %s\n",SHA,yytext);}
";" {fprintf(yyout,"SEMI %d %s\n",SEMI,yytext);}
":" {fprintf(yyout,"COLON %d %s\n",COLON,yytext);}
%%
int main()
{
  yyin=fopen("testin.c","r");
  yyout=fopen("testout.txt","w");
  yylex();
  return 0;
}






