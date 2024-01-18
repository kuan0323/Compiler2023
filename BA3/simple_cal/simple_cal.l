%{
#include "simple_cal.tab.h"
%}

%%
\r        {}
\n        {}
[ \t]+	  { /* do nothing */ }
"+"     { return add; }
"-"	  { return sub; }
"*"     { return mul; }
"\/"     { return divi; }
[0-9]*[.]?[0-9]*	  { yylval.fval= atof(yytext); return(number); }
.	      { return(yytext[0]); }
<<EOF>>   {return end_of_file; }
%%