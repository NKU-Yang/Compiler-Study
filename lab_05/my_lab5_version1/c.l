%{
#include"pch.h"
#include"c.tab.h"
#include"tree.h"
#define YYSTYPE TreeNode*
char* Id=new char[10];
int getid(char* text,int len);
int compute(char* str,int len);
int getNUM(char *text,int len);
char hashl[1000][10];

extern int line;
%}
digit [0-9]
num [1-9]{digit}*|0
newline [\n]+
letter [A-Za-z]
id ({letter}|_)({letter}|{digit}|_)*
white [\t\n]*
%%
"if"			{return IF;}
"else"			{return ELSE;}
"for"			{return FOR;}
"while"			{return WHILE;}
"void"			{return VOID;}
"int"			{return INT;}
"char"			{return CHAR;}
"input"         {return INPUT;}
"print"         {return PRINT;}
"main"			{return MAIN;}
"+"				{return PLUS;}	
"-"				{return MINUS;}
"*"				{return TIMES;}
"/"				{return OVER;}
"%"				{return REMI;}
"++"			{return DPLUS;}
"--"			{return DMINUS;}
">="			{return GE;}
"<="			{return LE;}
">"				{return GT;}
"<"				{return	LT;}
"!="			{return NEQ;}
"&&"            {return AND;}
"||"            {return OR;}
"!"             {return NOT;}
"=="			{return EQ;}
"="				{return ASSIGN;}
","				{return COMMA;}
";"				{return SEMI;}		
"("				{return LP;} 
")"				{return RP;} 
"["			    {return LSP;} 
"]"		        {return RSP;} 
"{"		        {return LFP;} 
"}"			    {return RFP;}
{white}			{/*do nothing*/}
{id} {
TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));//ID节点
                    for (int i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
                    t->sibling = NULL;
                    t->nodekind = ExpK;
                    t->kind = IdK;
                    t->lineno = line++;
                    t->type = Void;
                    t->attr.name=hashl[getid(yytext,yyleng)];
		yylval = t;
		return ID;
}
{num} {
TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));//number节点
                    for (int i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
                    t->sibling = NULL;
                    t->nodekind = ExpK;
                    t->kind = ConstK;
                    t->lineno = line++;
                    t->type = Void;
	            t->attr.val=getNUM(yytext,yyleng);	
	            yylval =t;	
		    return NUM;
}
%%
int getid(char*text,int len)
{
	int i=0;
	for(i;i<len;i++)
        {
		Id[i]=*text;
		text++;
	}
        Id[i]='\0';
        int index=compute(Id,len)%1000;
        if(hashl[index][0]=='\0')//no exist then create
	{
		strcpy(hashl[index],Id);
	}
	else
	{
		while(hashl[index][0]!='\0'&&strcmp(Id,hashl[index])!=false)
		{
			index++;
		}
	}
   return index;
}
int compute(char*str,int len)
{
	int hash=0;
	for(int i=0;str[i]!='\0';i++)
	{
		hash=hash+str[i]-'a';
	}
    return hash;
}

int getNUM(char*text,int len)
{
	int value=0;
	for(int i=0;i<len;i++)
	{
		value=value*10+*text-'0';
                text++;
	}
   return value;
}

