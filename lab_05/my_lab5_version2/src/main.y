%{
    #include "common.h"
    #define YYSTYPE TreeNode *  
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
    extern map<pair<string,int>,int>m;
%}

%token COMMA SEMI LP RP LFP RFP
%token IF ELSE MAIN FOR WHILE BREAK
%token INT CHAR VOID CONST BOOL STRING INTEGER
%token ID NUM RETURN CONTINUE 
%token PLUS MINUS MUL DIV REMI DPLUS DMINUS
%token LT LE GT GE EQ NEQ ASSIGN AND OR NOT POINT ADDASS SUBASS MULASS DIVASS 
%token REMASS SP
%token SCANF PRINT

%left COMMA
%right  ASSIGN
%left EQ NEQ
%left ASS ADDASS SUBASS MULASS DIVASS REMASS
%left LT LE GT GE
%left PLUS MINUS
%left   MUL DIV REMI
%right   DPLUS DMINUS
%left LP RP LSP RSP LFP RFP
%right  ELSE

%%

program
: VOID MAIN LP RP LFP statements RFP 
{root = new TreeNode(0, NODE_PROG); root->addchild($6);};

statements
:  statement {$$=$1;}
|  statements statement {$$=$1; $$->addsibling($2);}
;

statement
: LFP SEMI {$$=new TreeNode(lineno,NODE_STMT);$$->sp="skip";}
| decl SEMI{$$=$1;}
| assign SEMI
{$$=new TreeNode(lineno,NODE_STMT);$$->sp="assign";$$->addchild($1);}
| LFP statements RFP{$$=new TreeNode($2->lineno,NODE_BLOCK);$$->addchild($2);}
| WHILE LP cond RP statement
  {$$=new TreeNode($3->lineno,NODE_STMT);$$->sp="while";
    $$->addchild($3);$$->addchild($5);
  }
| IF LP cond RP statement
  {
	$$=new TreeNode($3->lineno,NODE_STMT);$$->sp="if";
	$$->addchild($3);$$->addchild($5);
  }
| FOR LP statement cond SEMI for RP statement
  {
	$$=new TreeNode($3->lineno,NODE_STMT);$$->sp="for";
	$$->addchild($3);
	$$->addchild($4);
	$$->addchild($6);
	$$->addchild($8);
  }
| RETURN expr SEMI
  {
	$$ = new TreeNode(lineno, NODE_STMT); 
	$$->sp = "return";
	$$->addchild($2);
  }
| RETURN SEMI {$$ = new TreeNode(lineno, NODE_STMT); $$->sp = "return";}
| PRINT LP ids RP SEMI
  {
	$$ = new TreeNode(lineno, NODE_STMT); 
	$$->sp = "print";
	$$->addchild($3);
  }
| SCANF LP ids RP SEMI
  {
	$$ = new TreeNode(lineno, NODE_STMT); 
	$$->sp = "scanf";
	$$->addchild($3);
  }
;

ids:
   ids COMMA expr{$$=$1;$$->addsibling($3);}
| expr {$$=$1;}
| ids COMMA SP expr{$$=$1;$$->addsibling($4);}
;

for:
   assign {$$=new TreeNode(lineno,NODE_STMT);$$->sp="for+";
	   $$->addchild($1);}
;


decl
: type assigns{ 
	$$ = new TreeNode(lineno, NODE_STMT); $$->sp="decl_val"; 
	$$->addchild($1);$$->addchild($2); 
	} 
| CONST type assigns{ 
	$$ = new TreeNode(lineno, NODE_STMT); $$->sp="decl_const"; 
	$$->addchild($2);$$->addchild($3);  
   }
;

assigns:
      assigns COMMA assign{$$=$1;$$->addsibling($3);}
| assigns COMMA ID{$$=$1;$$->addsibling($3);}
| assign{$$=$1;}
| ID{$$=$1;}
;

assign:
      ID ASSIGN expr
	{
	 TreeNode* node=new TreeNode(lineno,NODE_ASSIGN);
	 node->sp="ass";
	 $1->type=$3->type;
	$1->ch_val=$3->ch_val;
	$1->int_val=$3->int_val;
	$1->str_val=$3->str_val;
	m[make_pair($1->var_name,$1->scope)]=$1->int_val;
	node->addchild($1);node->addchild($3);
	$$=node;
	}
| ID ADDASS expr
  {
	TreeNode* node=new TreeNode(lineno,NODE_ASSIGN);
	node->sp="addass";
	$1->type=$3->type;
	$1->int_val+=$3->int_val;
	m[make_pair($1->var_name,$1->scope)]=$1->int_val;
	node->addchild($1);node->addchild($3);
	$$=node;
  }
| ID SUBASS expr
  {
	TreeNode* node = new TreeNode(lineno, NODE_ASSIGN);
	node->sp="subass";
	$1->type=$3->type;
	$1->int_val-=$3->int_val;
	m[make_pair($1->var_name,$1->scope)]=$1->int_val;
	node->addchild($1);node->addchild($3);
	$$=node;
  }
| ID MULASS expr
  {
	TreeNode* node = new TreeNode(lineno, NODE_ASSIGN);
	node->sp="mulass";
	$1->type=$3->type;
	$1->int_val*=$3->int_val;
	m[make_pair($1->var_name,$1->scope)]=$1->int_val;
	node->addchild($1);node->addchild($3);
	$$=node;
  }
| ID DIVASS expr
  {
	TreeNode* node = new TreeNode(lineno, NODE_ASSIGN);
	node->sp="divass";
	$1->type=$3->type;
	$1->int_val/=$3->int_val;
	m[make_pair($1->var_name,$1->scope)]=$1->int_val;
	node->addchild($1);node->addchild($3);
	$$=node;
  }
| ID REMASS expr
  {
	TreeNode* node = new TreeNode(lineno, NODE_ASSIGN);
	node->sp="remass";
	$1->type=$3->type;
	$1->int_val%=$3->int_val;
	m[make_pair($1->var_name,$1->scope)]=$1->int_val;
	node->addchild($1);node->addchild($3);
	$$=node;
  }
| ID DPLUS
 {
	TreeNode* node = new TreeNode(lineno, NODE_ASSIGN);
	node->sp="Dplus";
	$1->type=TYPE_INT;
	$1->int_val++;
	m[make_pair($1->var_name,$1->scope)]=$1->int_val;
	node->addchild($1);
	$$=node;
 }
| ID DMINUS
 {
	TreeNode* node = new TreeNode(lineno, NODE_ASSIGN);
	node->sp="Dminus";
	$1->type=TYPE_INT;
	$1->int_val++;
	m[make_pair($1->var_name,$1->scope)]=$1->int_val;
	node->addchild($1);
	$$=node;
 }
;
  
expr
: ID {
    $$ = $1;
}
| INTEGER {
    $$ = $1;
}
| CHAR {
    $$ = $1;
}
| STRING {
    $$ = $1;
}
| expr PLUS expr
  {
	$$ = new TreeNode(lineno, NODE_EXPR); 
	$$->type = TYPE_INT;$$->sp="plus";
	$$->int_val=$1->int_val+$3->int_val;
	$$->addchild($1);$$->addchild($3);
  }
| expr MINUS expr
  {
	$$ = new TreeNode(lineno, NODE_EXPR); 
	$$->type = TYPE_INT;$$->sp="minus";
	$$->int_val=$1->int_val-$3->int_val;
	$$->addchild($1);$$->addchild($3);
  }
|  expr MUL expr 
   {
	$$ = new TreeNode(lineno, NODE_EXPR); 
	$$->type = TYPE_INT;$$->sp="mul";
	$$->int_val=$1->int_val*$3->int_val;
	$$->addchild($1);$$->addchild($3);
   }
| expr DIV expr
  {
	$$ = new TreeNode(lineno, NODE_EXPR); 
	$$->type = TYPE_INT;$$->sp="div";
	$$->int_val=$1->int_val/$3->int_val;
	$$->addchild($1);$$->addchild($3);
  }
| expr REMI expr
  {
	$$ = new TreeNode(lineno, NODE_EXPR); 
	$$->type = TYPE_INT;$$->sp="rem";
	$$->int_val=$1->int_val%$3->int_val;
	$$->addchild($1);$$->addchild($3);
  } 
| LP expr RP{$$=$2;}
;
cond:
    condand OR condand
   {
	$$=new TreeNode(lineno,NODE_COND);
	$$->sp="or";
	$$->addchild($1);
	$$->addchild($3);
   }
| condand{$$=$1;}
;
condand:
       condno AND condno
	{
	   $$=new TreeNode(lineno, NODE_COND);
	$$->sp="and";
	$$->addchild($1);
	$$->addchild($3);	
	}
| condno{$$=$1;}
;
condno:
      NOT condition
	{
	  $$=new TreeNode(lineno, NODE_COND);
	$$->sp="no";
	$$->addchild($2);
	}
| condition {$$=$1;}
;
condition:
	 expr GT expr {
	$$=new TreeNode(lineno, NODE_COND);
	$$->sp="gt";
	$$->addchild($1);$$->addchild($3);
	}
| expr GE expr {
	$$=new TreeNode(lineno, NODE_COND);
	$$->sp="ge";
	$$->addchild($1);$$->addchild($3);
	}
| expr LT expr {
	$$=new TreeNode(lineno, NODE_COND);
	$$->sp="lt";
	$$->addchild($1);$$->addchild($3);
	}
| expr LE expr {
	$$=new TreeNode(lineno, NODE_COND);
	$$->sp="le";
	$$->addchild($1);$$->addchild($3);
	}
| expr EQ expr {
	$$=new TreeNode(lineno, NODE_COND);
	$$->sp="eq";
	$$->addchild($1);$$->addchild($3);}
| expr NEQ expr {
	$$=new TreeNode(lineno, NODE_COND);
	$$->sp="neq";
	$$->addchild($1);$$->addchild($3);
	}
| LP cond RP {$$=$1;}
;
type:
INT {$$ = new TreeNode(lineno, NODE_TYPE); 
	$$->type = TYPE_INT;$$->sp="int";} 
| CHAR {$$ = new TreeNode(lineno, NODE_TYPE); 
	$$->type = TYPE_CHAR;$$->sp="char";}
| BOOL {$$ = new TreeNode(lineno, NODE_TYPE);
	 $$->type = TYPE_BOOL;$$->sp="bool";}
| STRING {$$ = new TreeNode(lineno, NODE_TYPE); 
	$$->type = TYPE_STRING;$$->sp="string";}
;

%%

int yyerror(char const* message)
{
  cout << message << " at line " << lineno << endl;
  return -1;
}
