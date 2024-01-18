%{
#include <stdio.h>
#include <string.h>
#include <math.h>

int yylex();
void yyerror(const char *message);
%}
%code requires
{
    struct Var
    {
        int ival;
        char* bval;
        int result_plus;
        int result_mul;
        char* result_and;
        char* result_or;
    };
}
%union {
    struct Var var;
}
%token add sub mul divi mod greater smaller equal lbr rbr or_op and_op not_op print_num print_bool if_exp def_stmt end_of_file
%token <var> number id constant_true constant_false
%type PROGRAM STMTS STMT
%type <var> EXP EXPS PLUS_VALUE MINUS_VALUE MULTIPLY_VALUE DIVIDE_VALUE MODULUS_VALUE GREATER_VALUE SMALLER_VALUE EQUAL_VALUE 
%type <var> AND_VALUE OR_VALUE NOT_VALUE
%type <var> IF_EXP TEST_EXP THEN_EXP ELSE_EXP

%%
PROGRAM         : STMTS                             { return(0); }
STMTS           : STMT STMTS
                | STMT
                ;
STMT            : EXP
                | PRINT-STMT
                ;
PRINT-STMT      : lbr print_num EXP rbr             { printf("%d\n", $3.ival); }
                | lbr print_bool EXP rbr            { printf("%s\n", $3.bval); }
                ;
PLUS_VALUE      : lbr add EXP EXPS rbr              { $$.ival = $3.ival + $4.result_plus; }
                ;
MINUS_VALUE     : lbr sub EXP EXP rbr               { $$.ival = $3.ival - $4.ival; }
                ;
MULTIPLY_VALUE  : lbr mul EXP EXPS rbr              { $$.ival = $3.ival * $4.result_mul; }
                ;
DIVIDE_VALUE    : lbr divi EXP EXP rbr              { $$.ival = $3.ival / $4.ival; }
                ;
MODULUS_VALUE   : lbr mod EXP EXP rbr               { $$.ival = $3.ival % $4.ival; }
                ;
GREATER_VALUE   : lbr greater EXP EXP rbr           {
                                                        if ($3.ival > $4.ival) {
                                                            $$.bval = "#t";
                                                        }
                                                        else {
                                                            $$.bval = "#f";
                                                        }
                                                    }
                ;
SMALLER_VALUE   : lbr smaller EXP EXP rbr           {
                                                        if ($3.ival < $4.ival) {
                                                            $$.bval = "#t";
                                                        }
                                                        else {
                                                            $$.bval = "#f";
                                                        }
                                                    }
                ;
EQUAL_VALUE     : lbr equal EXP EXPS rbr            {
                                                        if ($3.ival == $4.ival || $3.ival == $4.result_plus || $3.ival == $4.result_mul){
                                                            $$.bval = "#t";
                                                        }
                                                        else {
                                                            $$.bval = "#f";
                                                        }
                                                    }
                ;
AND_VALUE       : lbr and_op EXP EXPS rbr           {   
                                                        if (strcmp($3.bval, $4.result_and) == 0 && strcmp($3.bval, "#t") == 0) {
                                                            $$.bval = "#t";
                                                            $$.result_and = "#t";
                                                        }
                                                        else {
                                                            $$.bval = "#f";
                                                            $$.result_and = "#f";
                                                        }
                                                    }
                ;
OR_VALUE        : lbr or_op EXP EXPS rbr            {
                                                        if (strcmp($3.bval, "#t") == 0 || strcmp($4.result_or, "#t") == 0) {
                                                            $$.bval = "#t";
                                                        }
                                                        else {
                                                            $$.bval = "#f";
                                                        }
                                                    }
                ;
NOT_VALUE       : lbr not_op EXP rbr                {
                                                        if (strcmp($3.bval, "#t") == 0) {
                                                            $$.bval = "#f";
                                                        }
                                                        else {
                                                            $$.bval = "#t";
                                                        }
                                                    }
                ;
IF_EXP          : lbr if_exp TEST_EXP THEN_EXP ELSE_EXP rbr {
                                                            if (strcmp($3.bval, "#t") == 0) {
                                                                $$.ival = $4.ival;
                                                            }
                                                            else {
                                                                $$.ival = $5.ival;
                                                            }
                                                        }
                ;
EXPS            : EXP EXPS                          {
                                                        $$.result_plus = $1.ival + $2.result_plus;
                                                        $$.result_mul = $1.ival * $2.result_mul;
                                                        if (($1.ival == $2.ival && $1.ival != 0) || 
                                                        (strcmp($1.bval, $2.result_and) == 0 && strcmp($1.bval, "#t") == 0))
                                                        {
                                                            $$.bval = "#t";
                                                            $$.result_and = "#t";
                                                        }
                                                        else if ((strcmp($1.bval, "#t") == 0 || strcmp($2.result_or, "#t") == 0)) {
                                                            $$.result_and = "#f";
                                                            $$.result_or = "#t";
                                                        }
                                                        else {
                                                            $$.bval = "#f";
                                                            $$.result_and = "#f";
                                                            $$.result_or = "#f";
                                                        }
                                                        $$.ival == $1.ival;
                                                    }
                | EXP                               { 
                                                        $$.result_plus = $1.result_plus;
                                                        $$.result_mul = $1.result_mul;
                                                        $$.bval = $1.bval;
                                                        $$.result_and = $1.bval;
                                                        $$.result_or = $1.bval;
                                                    }
                ;
TEST_EXP        : EXP                               {
                                                        $$.bval = $1.bval;
                                                    }
                ;
THEN_EXP        : EXP                               {
                                                        $$.ival = $1.ival;
                                                    }
                ;
ELSE_EXP        : EXP                               {
                                                        $$.ival = $1.ival;
                                                    }
                ;
EXP             : number                            { 
                                                        $$.ival = $1.ival;
                                                        $$.result_mul = $1.ival;
                                                        $$.result_plus = $1.ival;
                                                        $$.bval = "#t";
                                                        $$.result_and = "#t";
                                                        $$.result_or = "#t";
                                                    }
                | PLUS_VALUE                        { 
                                                        $$.result_plus = $1.ival;
                                                        $$.result_mul = $1.ival;
                                                        $$.bval = "#t";
                                                    }
                | MINUS_VALUE                       { 
                                                        $$.result_plus = $1.ival;
                                                        $$.result_mul = $1.ival;
                                                        $$.bval = "#t";
                                                    }
                | MULTIPLY_VALUE                    {
                                                        $$.result_plus = $1.ival;
                                                        $$.result_mul = $1.ival;
                                                        $$.bval = "#t";
                                                    }
                | DIVIDE_VALUE                      {
                                                        $$.result_plus = $1.ival;
                                                        $$.result_mul = $1.ival;
                                                        $$.bval = "#t";
                                                    }
                | MODULUS_VALUE                     {
                                                        $$.result_plus = $1.ival;
                                                        $$.result_mul = $1.ival;
                                                        $$.bval = "#t";
                                                    }
                | GREATER_VALUE                     {
                                                        $$.bval = $1.bval;
                                                    }
                | SMALLER_VALUE                     {
                                                        $$.bval = $1.bval;
                                                    }
                | EQUAL_VALUE                       {
                                                        $$.bval = $1.bval;
                                                    }
                | constant_true                     { }
                | constant_false                    { }
                | AND_VALUE                         {
                                                        $$.bval = $1.bval;
                                                    }
                | OR_VALUE                          {
                                                        $$.bval = $1.bval;
                                                    }
                | NOT_VALUE                         {
                                                        $$.bval = $1.bval;
                                                    }
                | IF_EXP                            {
                                                        $$.ival = $1.ival;
                                                    }
                ;
%%
void yyerror (const char *message)
{
        printf ("syntax error");
}
int main(int argc, char *argv[]) {
        yyparse();
        return(0);
}