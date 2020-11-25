%{
#include"tree.h"
#define YYSTYPE TreeNode*
int yylex();
extern int yyparse();
extern int line;
int yyerror(const char* s);
%}

%token IF MAIN FOR WHILE 
%token INT CHAR VOID 
%token ID NUM
%token PLUS MINUS TIMES OVER REMI DPLUS DMINUS
%token LT LE GT GE EQ NEQ ASSIGN AND OR NOT
%token SEMI COMMA LP RP LFP RFP 
%token INPUT PRINT

%left COMMA 
%right  ASSIGN 
%left EQ NEQ 
%left LT LE GT GE 
%left PLUS MINUS 
%left   TIMES OVER REMI 
%left   DPLUS DMINUS
%left LP RP LSP RSP LFP RFP 
%right  ELSE 

%%

start   :MAIN LP RP comp_stmt//main（）
      { 
          $$ = $4;
        ShowTree($4);//以复合语句为根节点，输入必须从main开始
        root = $4;
      }
      ;
comp_stmt :LFP  stmt_list RFP//{函数表达式}
      { 
        $$ = newStmtNode(CompK);//建立新的语句节点：复合语句。
        $$->child[0]=$2;
      }
      ;
stmt_list :stmt stmt_list   //递归
      {
        $$->sibling=$2;  //if while是兄弟节点
        $$= $1;   
      }
      |stmt           
      {
        $$ = $1 ;
      }
      ;
stmt    :var_dec     //具体表达式类型，变量声明，表达式，if，for，while、主函数   
      { 
        $$ = $1;
      }
      |exp_stmt         
      { 
        $$ = $1;
      }
      |if_stmt          
      { 
        $$ = $1;
      }
      |for_stmt
      {
        $$ = $1;
      }
      |while_stmt 
      {
        $$ = $1;
      }        
      |comp_stmt          
      { 
        $$ = $1;
      }
            |input_stmt
            {
                $$ = $1;
            }
            |print_stmt
            {
                $$ = $1;
            }
      ;     
type_spec :INT  
      {
        $$ = newExpNode(TypeK);//int
                $$->type=Integer;
      } 
      |CHAR 
      {
        $$ = newExpNode(TypeK);//char
                $$->type=Char;
      }
      |VOID 
      {
        $$ = newExpNode(TypeK);//void
                $$->type=Void;
      }
      ;
id_list   :exp COMMA id_list//具体表达式类型，变量声明，表达式，if，for，while、主函数
      {
        $$ = $1;
        $$->sibling=$3;
      }
      |exp
      ;                  
var_dec   :type_spec id_list SEMI//变量声明 int/char a=/a;
      { 
        $$ = newExpNode (VarK);//建立一个新的变量声明的节点
        $$->child[0]=$1;
        $$->child[1]=$2;
      }
      ;

if_stmt     :IF LP exp RP stmt //if(exp) stmt
                 { $$ = newStmtNode(IfK);
                   $$->child[0] = $3;
                   $$->child[1] = $5;
                 }
      
            | IF LP exp RP  stmt ELSE stmt//if (exp) stmt else stmt
                 { $$ = newStmtNode(IfK);
                   $$->child[0] = $3;
                   $$->child[1] = $5;
                   $$->child[2] = $7;
                 }
            ;
for_stmt  :FOR LP exp SEMI exp SEMI exp RP stmt//for(exp;exp;exp)
      {
        $$ = newStmtNode(ForK);
        $$->child[0] = $3;
                $$->child[1] = $5;
                $$->child[2] = $7;
                $$->child[3] = $9;
      }
      |FOR LP SEMI exp SEMI exp RP stmt//for(;exp;exp)
      {
        $$ = newStmtNode(ForK);
        $$->child[0] = NULL;
        $$->child[1] = $4;
                $$->child[2] = $6;
                $$->child[3] = $8;
      }
      |FOR LP exp SEMI SEMI exp RP stmt//for(exp;;exp)
      {
        $$ = newStmtNode(ForK);
        $$->child[0] = $3;
        $$->child[1] = NULL;
                $$->child[2] = $6;
                $$->child[3] = $8;
      }
      |FOR LP exp SEMI exp SEMI RP stmt//for(exp;exp;)
      {
        $$ = newStmtNode(ForK);
        $$->child[0] = $3;
                $$->child[1] = $5;
                $$->child[2] = $8;
                $$->child[3] = NULL;
      }
      |FOR LP SEMI SEMI exp RP stmt//for(;;exp)
      {
        $$ = newStmtNode(ForK);
        $$->child[0] = NULL;
        $$->child[1] = NULL;
        $$->child[2] = $5;
                $$->child[3] = $7;
      }
      |FOR LP SEMI exp SEMI RP stmt//for(;exp;)
      {
        $$ = newStmtNode(ForK);
        $$->child[0] = NULL;
        $$->child[1] = $4;
        $$->child[2] = NULL;
        $$->child[3] = $7;
      }
      |FOR LP exp SEMI SEMI RP stmt//for(exp;;)
      {
        $$ = newStmtNode(ForK);
        $$->child[0] = $3;
        $$->child[1] = NULL;
        $$->child[2] = NULL;
        $$->child[3] = $7;
      }
      |FOR LP SEMI SEMI RP stmt//for(;;)
      {
        $$ = newStmtNode(ForK);
        $$->child[0] = NULL;
        $$->child[1] = NULL;
        $$->child[2] = NULL;
        $$->child[3] = $6;
      }
      ;
while_stmt  :WHILE LP exp RP stmt//while(exp)
      {
        $$ = newStmtNode(WhileK);
        $$->child[0] = $3;
        $$->child[1] = $5;
      }
      ;
exp_stmt  :exp SEMI   //exp;
      {
        $$ = $1;
      }
      |SEMI
      ;
exp     :exp ASSIGN exp//exp=exp
      {
        $$ = newExpNode(OpK);
        $$->child[0]=$1;
        $$->child[1]=$3;
        $$->attr.op = ASSIGN;
      }     
      |or_exp
      {
          $$ = $1;
      }
      ;
or_exp      :or_exp OR and_exp
            {
                $$ = newExpNode(OpK);
                $$ -> attr.op =OR;
                $$ ->child[0] = $1;
                $$ -> child[1] = $3;
            }
            |and_exp
            {
                $$ = $1;
            }
            ;
and_exp     :and_exp AND exp_equ
            {
                $$ = newExpNode(OpK);
                $$ -> attr.op = AND;
                $$ -> child[0] = $1;
                $$ -> child[1] = $3;
            }
            |exp_equ
            {
                $$ = $1;
            }
            ;
exp_equ     :exp_equ EQ simple_exp//==
      { 
        $$ = newExpNode(OpK);
        $$->child[0]=$1;
        $$->child[1]=$3;
        $$->attr.op=EQ;
      }
      |exp_equ LE simple_exp//<=
      { 
        $$ = newExpNode(OpK);
        $$->child[0]=$1;
        $$->child[1]=$3;
        $$->attr.op=LE;
      }
      |exp_equ GE simple_exp//>=
      { 
        $$ = newExpNode(OpK);
        $$->child[0]=$1;
        $$->child[1]=$3;
        $$->attr.op=GE;
      }
      |exp_equ LT simple_exp//<
      { 
        $$ = newExpNode(OpK);
        $$->child[0]=$1;
        $$->child[1]=$3;
        $$->attr.op=LT;
      }
      |exp_equ GT simple_exp  //>
      { 
        $$ = newExpNode(OpK);
        $$->child[0]=$1;
        $$->child[1]=$3;
        $$->attr.op=GT;
      }
      |exp_equ NEQ simple_exp //!=
      { 
        $$ = newExpNode(OpK);
        $$->child[0]=$1;
        $$->child[1]=$3;
        $$->attr.op=NEQ;
      }
      |simple_exp
      {
        $$ = $1;
      }
      ;
simple_exp  : simple_exp PLUS term //+ - * / ++ --
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = PLUS;

                 }
            | simple_exp MINUS term
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = MINUS;

                 } 
            | simple_exp TIMES term
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = TIMES;
                 } 
            | simple_exp OVER term
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = OVER;
                 } 
            | simple_exp REMI term
                 { $$ = newExpNode(OpK);
                   $$->child[0] = $1;
                   $$->child[1] = $3;
                   $$->attr.op = REMI;
                 } 
            |simple_exp DPLUS 
      {
        $$ = newExpNode(OpK); 
        $$->child[0] = $1;
        $$->attr.op = DPLUS;

      }
      |simple_exp DMINUS 
      {
        $$ = newExpNode(OpK); 
        $$->child[0] = $1;
        $$->attr.op = DMINUS;

      }
            | term { $$ = $1; }
            ;
term    :LP exp RP        
      {
        $$ = $2;
      }
      |ID         
      {
        $$ = $1;
      }
      |NUM        
      {
        $$ = $1;
      }
      |NOT term
      {
         $$ = newExpNode(OpK);
         $$ -> attr.op = NOT;
         $$ -> child[0] =$2;
      }
      ;
input_stmt  :INPUT LP exp RP SEMI
            {
                $$ = newStmtNode(InputK);
                $$ -> child[0] = $3;
                $$ -> type =Bool;
            }
            ;
print_stmt  :PRINT LP exp RP SEMI
            {
                $$ = newStmtNode(PrintK);
                $$ -> child[0] = $3;
                $$ -> type =Bool;
            }
            ;
%%
int yyerror(const char* s)
{
   cout << s << " at line " << line << endl;
   return -1;
}