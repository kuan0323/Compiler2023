/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_MINI_LISP_TAB_H_INCLUDED
# define YY_YY_MINI_LISP_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 10 "Mini_LISP.y"

    struct Var
    {
        int ival;
        char* bval;
        int result_plus;
        int result_mul;
        char* result_and;
        char* result_or;
    };

#line 61 "Mini_LISP.tab.h"

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    add = 258,                     /* add  */
    sub = 259,                     /* sub  */
    mul = 260,                     /* mul  */
    divi = 261,                    /* divi  */
    mod = 262,                     /* mod  */
    greater = 263,                 /* greater  */
    smaller = 264,                 /* smaller  */
    equal = 265,                   /* equal  */
    lbr = 266,                     /* lbr  */
    rbr = 267,                     /* rbr  */
    or_op = 268,                   /* or_op  */
    and_op = 269,                  /* and_op  */
    not_op = 270,                  /* not_op  */
    print_num = 271,               /* print_num  */
    print_bool = 272,              /* print_bool  */
    if_exp = 273,                  /* if_exp  */
    define = 274,                  /* define  */
    end_of_file = 275,             /* end_of_file  */
    number = 276,                  /* number  */
    id = 277,                      /* id  */
    constant_true = 278,           /* constant_true  */
    constant_false = 279           /* constant_false  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 21 "Mini_LISP.y"

    struct Var var;

#line 106 "Mini_LISP.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_MINI_LISP_TAB_H_INCLUDED  */
