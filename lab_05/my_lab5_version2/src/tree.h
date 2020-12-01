#ifndef TREE_H
#define TREE_H

#include "pch.h"
#include "type.h"

enum NodeType
{
    NODE_CONST, 
    NODE_VAR,
    NODE_EXPR,
    NODE_TYPE,
    NODE_STMT,
    NODE_PROG,
    NODE_BLOCK,
    NODE_OP,
    NODE_ASSIGN,
    NODE_COND,
};

struct TreeNode {
public:
    int nodeID;  // 用于作业的序号输出
    int lineno;
    NodeType nodeType;

    TreeNode* child = nullptr;
    TreeNode* sibling = nullptr;

    void addchild(TreeNode*);
    void addsibling(TreeNode*);
    
    void printNodeInfo();
    void printChildrenId();

    void printAST(); // 先输出自己 + 孩子们的id；再依次让每个孩子输出AST。
    void printSpecialInfo();

    void genNodeId();

public:
    Type* type;  // 变量、类型、表达式结点，有类型。
   
    int int_val;
    char ch_val;
    //bool b_val;
    string str_val;
    string var_name;
    int scope=-1;
    string sp="?";
public:
    static string nodeType2String (NodeType type);

public:
    TreeNode(int lineno, NodeType type);
};
struct NodeScope{
public:
	NodeScope*parent=nullptr;
	int scope;
	map<string,int> m;
	

	NodeScope(int scope){
		this->scope=scope;	
	}

	NodeScope* addScopeL(int s){
		NodeScope* node=new NodeScope(s);
		node->parent=this;
		return node;		
	}

	NodeScope* addScopeR(){
		return this->parent;		
	}

	void addVal(string val){
		NodeScope* temp=this;
		do{
			if(temp->m.count(val)){
			if(temp!=this)
			this->m.insert(pair<string,int>(val,temp->m[val]));
			return;			
			}
			temp=temp->parent;
		}while(temp!=nullptr);
		if(this->m.count(val)==0)
			this->m.insert(pair<string,int>(val,this->scope));
	}


	int findScope(string val){
		return this->m[val];
	}
};

#endif
