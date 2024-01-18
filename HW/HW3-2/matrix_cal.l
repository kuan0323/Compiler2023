%option noyywrap
%{
    #include "matrix_cal.tab.h"
    int errorIndex = 0;
%}
%%
\n      { /* do nothing */ }
[ \t]+  { errorIndex += yyleng; }
"+"|"-" { errorIndex += yyleng; yylval.loc = errorIndex; return ADDSUB; }
"*"     { errorIndex += yyleng; yylval.loc = errorIndex; return MUL; }
","     { errorIndex += yyleng; return COMMA; }
"["     { errorIndex += yyleng; return LSBC; }
"]"     { errorIndex += yyleng; return RSBC; }
"("     { errorIndex += yyleng; return LBC; }
")"     { errorIndex += yyleng; return RBC; }
"^T"    { errorIndex += yyleng; return TP; }
[0-9]+  { errorIndex += yyleng; yylval.ival = atoi(yytext); return NUM; }
.       { /* do nothing */ }
%%