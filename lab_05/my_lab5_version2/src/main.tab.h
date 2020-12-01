/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SRC_MAIN_TAB_H_INCLUDED
# define YY_YY_SRC_MAIN_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    COMMA = 258,
    SEMI = 259,
    LP = 260,
    RP = 261,
    LFP = 262,
    RFP = 263,
    IF = 264,
    ELSE = 265,
    MAIN = 266,
    FOR = 267,
    WHILE = 268,
    BREAK = 269,
    INT = 270,
    CHAR = 271,
    VOID = 272,
    CONST = 273,
    BOOL = 274,
    STRING = 275,
    INTEGER = 276,
    ID = 277,
    NUM = 278,
    RETURN = 279,
    CONTINUE = 280,
    PLUS = 281,
    MINUS = 282,
    MUL = 283,
    DIV = 284,
    REMI = 285,
    DPLUS = 286,
    DMINUS = 287,
    LT = 288,
    LE = 289,
    GT = 290,
    GE = 291,
    EQ = 292,
    NEQ = 293,
    ASSIGN = 294,
    AND = 295,
    OR = 296,
    NOT = 297,
    POINT = 298,
    ADDASS = 299,
    SUBASS = 300,
    MULASS = 301,
    DIVASS = 302,
    REMASS = 303,
    SP = 304,
    SCANF = 305,
    PRINT = 306,
    ASS = 307,
    LSP = 308,
    RSP = 309
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SRC_MAIN_TAB_H_INCLUDED  */
