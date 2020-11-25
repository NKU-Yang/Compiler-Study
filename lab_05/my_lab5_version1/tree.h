#include"pch.h"
typedef enum {StmtK,ExpK} NodeKind;
typedef enum {IfK,WhileK,ForK,CompK, InputK, PrintK} StmtKind;
typedef enum {OpK,ConstK,IdK,TypeK,VarK,AssignK} ExpKind;
typedef enum {Void,Integer,Char,Bool} ExpType;
#define MAXCHILDREN 4
int line=0;
int Num=0;
struct TreeNode
   { 
	struct TreeNode* child[MAXCHILDREN];
     struct TreeNode* sibling;
     int lineno;
     int nodekind;
     int kind;
     union{ int op;
             int val;
           char *name; }attr;
     int value;
     int type; /* maybe for type checking in the future*/
     //int tempid;
   } ;
TreeNode * newStmtNode(int kind)
{ 
  TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
  int i;
  if (t==NULL)
   printf("Out of memory error at line %d\n",line);
  else {
    for (i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
    t->sibling = NULL;
    t->nodekind = StmtK;
    t->kind = kind;
    t->lineno = line++;
  }
  return t;  
}
TreeNode * newExpNode(int kind)
{
  TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
  int i;
  if (t==NULL)
    printf("Out of memory error at line %d\n",line);
  else {
    for (i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
    t->sibling = NULL;
    t->nodekind = ExpK;
    t->kind = kind;
    t->lineno = line++;
    t->type = Void;
  }
  return t;
}
TreeNode* root;
void ShowTree(TreeNode *p);
void ShowNode(TreeNode *p);

void ShowTree(TreeNode *p)
{
	TreeNode* temp;
	temp=(TreeNode*)malloc(sizeof(TreeNode));
	for(int i=0;i<MAXCHILDREN;i++)
	{
		if(p->child[i]!=NULL)
		{
			ShowTree(p->child[i]);
		}
	}
    ShowNode(p);
    temp=p->sibling;
    if(temp!=NULL){
    	ShowTree(temp);
    }
    return;
}

void ShowNode(TreeNode *p)
{
	p->lineno=Num++;
	TreeNode* temp;
	temp=(TreeNode*)malloc(sizeof(TreeNode));
	printf("%d:",p->lineno);
	switch(p->nodekind)
	{
		case StmtK:
		{
			char *names[7] = {"If_statement,",  "While_statement,", "For_statement," , "Compound_statement,","Input_statement,","Print_statement," };
			printf("%s\t\t\t",names[p->kind]);
			break;
		}
		case ExpK:
		{
			char *names[5] = {"Expr," , "Const Declaration,", "ID Declaration,","Type Specifier,", "Var Declaration," };
			char *types[3] = {"Void","Integer ","Char"};
			printf("%s\t", names[ p->kind ]);
			switch(p->kind)
			{
				case OpK:
				{
					switch(p->attr.op)
					{
						   case 267://PLUS
					       {
					           printf("\top:+\t\t");
					           break;
					       }
					       case 268://MINUS
					       {
					           printf("\top:-\t\t");
					           break;
					       }
					       case 269://TIMES
					       {
					           printf("\top:*\t\t");
					           break;
					       }
					       case 270://OVER
					       {
					           printf("\top:/\t\t");
					           break;
					       }
					       case 271://REMI
					       {
					           printf("\top:%\t\t");
					           break;
					       }
					       case 272://DPLUS
					       {
					           printf("\t\top:++\t\t");
					           break;
					       }
					       case 273://DMINUS
					       {
					           printf("\t\top:--\t\t");
					           break;
					       }
					       case 274://LT
					       {
					           printf("\t\top:<\t\t");
					           break;
					       }
					       case 275://LE
					       {
					           printf("\t\top:<=\t\t");
					           break;
					       }
					       case 276://GT
					       {
					           printf("\t\top:>\t\t");
					           break;
					       }
					       case 277://GE
					       {
					           printf("\t\top:>=\t\t");
					           break;
					       }	
					       case 278://EQ
					       {
					           printf("\t\top:==\t\t");
					           break;
					       }
					       case 283://NOT
					       {
					           printf("\t\top:!=\t\t");
					           break;
					       }
					       case 282://OR
					       {
					           printf("\t\top:||\t\t");
					           break;
					       }
					       case 281://AND
					       {
					           printf("\t\top:&&\t\t");
					           break;
					       }
					       case 280://ASSIGN
					       {
					           printf("\top:=\t\t");
					       }  	
					}
					break;
				}
			case ConstK:
			{
				printf("values: %d\t",p->attr.val);
						break;
			}
			case IdK:
			{
				printf("symbol: %s\t",p->attr.name);
						break;
			}
			case TypeK:
			{
				printf("%s\t", types[ p->type ]);
						break;
			}
			case VarK:
			{
				printf("\t\t");
					break;
			}
			}
			break;
		}
	}
    
    printf("children:");
    for(int i=0;i<MAXCHILDREN;i++)
    {
    	if(p->child[i]!=NULL)
    	{
    		printf("%d ",p->child[i]->lineno);
    		temp=p->child[i]->sibling;
    		while(temp!=NULL)
    		{
    			printf("%d ",temp->lineno);
    			temp=temp->sibling;
    		}
    	}
    }   
printf("\n");
return;
}
