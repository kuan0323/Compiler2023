%option noyywrap
%{
    #include "stack_machine.tab.h"
%}
%%
[ \t]+  { /* do nothing */ }
"+"  { return add; }
"-"  { return sub; }
"*"  { return mul; }
"\/"  { return divi; }
[-]?[0-9]+  { yylval.ival = atoi(yytext); return number; }
.       { /* do nothing */ }
\n   {return end_of_file; }
%%