%{
#include <stdio.h>
#include <string.h>
#include <math.h>

int yylex();
void yyerror(const char *message);
%}
%union {
    float fval;
}
%token add
%token sub
%token mul
%token divi
%token end_of_file;
%token <fval> number
%type <fval> EXP
%type <fval> TERM
%type <fval> FAC

%left add sub
%left mul divi

%%
INPUT : LINE  {return 0; }
      ;
LINE : EXP end_of_file  { printf ("%.3f", $1); } ; 
EXP :   EXP add TERM    { $$ = $1 + $3; }
        | EXP sub TERM  { $$ = $1 - $3; }
        | TERM
        ;

TERM    : TERM mul FAC  { $$ = $1 * $3; }
        | TERM divi FAC { $$ = $1 / $3; 
                          if ($3 == 0.000000) {
                              printf("Invalid Value");
                              return(0);
                          }
                        }
        | FAC
        ;

FAC     : number ;
%%
void yyerror (const char *message)
{
        printf ("Invalid Value");
}
int main(int argc, char *argv[]) {
        yyparse();
        return(0);
}