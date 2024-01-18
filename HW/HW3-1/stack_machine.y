%{
#include <stdio.h>
#include <string.h>
#include <math.h>

int yylex();
void yyerror(const char *message);
%}
%union {
int ival;
}
%token add
%token sub
%token mul
%token mod
%token load
%token inc
%token dec
%token end_of_file;
%token <ival> number
%type <ival> EXP

%%
INPUT : LINE  {return 0; }
      ;
LINE : EXP end_of_file  { printf ("%d\n", $1); }
     ; 
EXP : load number   { $$ = $2;      }
   | EXP EXP add     { $$ = $2 + $1; }
   | EXP EXP sub     { $$ = $2 - $1; }
   | EXP EXP mul     { $$ = $2 * $1; }
   | EXP EXP mod     { $$ = $2 % $1; }
   | EXP inc         { $$ = $1 + 1 ; }
   | EXP dec         { $$ = $1 - 1 ; }
   ; 
%%
void yyerror (const char *message)
{
        printf ("Invalid format\n");
}
int main(int argc, char *argv[]) {
        yyparse();
        return(0);
}