%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
int lineno=1;
int scope=0;
NodeScope* stree=new NodeScope(0);
map<pair<string,int>,int> m;
%}
BLOCKCOMMENT \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
LINECOMMENT \/\/[^\n]*
EOL	(\r\n|\r|\n)
WHILTESPACE [[:blank:]]

INTEGER [0-9]+

CHAR \'.?\'
STRING \".+\"

ID [[:alpha:]_][[:alpha:][:digit:]_]*
%%

{BLOCKCOMMENT}  /* do nothing */
{LINECOMMENT}  /* do nothing */


"int" {return INT;}
"bool" {return BOOL;}
"char" {return CHAR;}
"string" {return STRING;}
"if"	{return IF;}
"else"	{return ELSE;}
"for"	{return FOR;}
"while"	{return WHILE;}
"break" {return BREAK;}
"const" {return CONST;}
"void"	{return VOID;}
"scanf"  {return SCANF;}
"print"  {return PRINT;}
"main"	{return MAIN;}

"+"			{return PLUS;}	
"-"			{return MINUS;}
"*"			{return MUL;}
"/"			{return DIV;}
"%"			{return REMI;}
"++"			{return DPLUS;}
"--"			{return DMINUS;}
"+=" 			{return ADDASS;}
"-=" 			{return SUBASS;}
"*=" 			{return MULASS;}
"/=" 			{return DIVASS;}
"%=" 			{return REMASS;}
">="			{return GE;}

"<="			{return LE;}
">"			{return GT;}
"<"			{return	LT;}
"!="			{return NEQ;}
"&&"                    {return AND;}
"||"                    {return OR;}
"!"                     {return NOT;}
"&" 			{return SP;}
"=="			{return EQ;}
"="			{return ASSIGN;}

","			{return COMMA;}
";"			{return SEMI;}	
"."			{return POINT;}	
"("			{return LP;} 
")"			{return RP;} 
"["			{return LSP;} 
"]"		        {return RSP;} 
"{"		        {return LFP;} 
"}"			{return RFP;}


{INTEGER} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = atoi(yytext);
    yylval = node;
    return INTEGER;
}

{CHAR} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_CHAR;
    node->int_val = yytext[1];
    yylval = node;
    return CHAR;
}
{STRING} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_STRING;
    node->str_val = yytext;
    yylval = node;
    return STRING;
}

{ID} {
    stree->addVal(string(yytext));
    TreeNode* node = new TreeNode(lineno, NODE_VAR);
    node->var_name = string(yytext);
    node->scope=stree->findScope(string(yytext));
	node->type = TYPE_INT;
if(m.count(make_pair(string(yytext),node->scope)))
		node->int_val=m[make_pair(string(yytext),node->scope)];
	else
		m.insert(make_pair(make_pair(string(yytext),node->scope),0));
    yylval = node;
    return ID;
}

{WHILTESPACE} /* do nothing */

{EOL} lineno++;

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}
%%
