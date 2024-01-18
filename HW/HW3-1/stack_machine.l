%{
#include "stack_machine.tab.h"
%}

%%
\n        {}
[ \t]+	  { /* do nothing */ }
"add"     {return add;}
"sub"	  {return sub;}
"mul"     {return mul;}
"mod"     {return mod;}
"inc"	  {return inc;}
"dec"	  {return dec;}
"load"    {return load;}
[0-9]+	  { yylval.ival= atoi(yytext);return(number); }
.	      { return(yytext[0]); }
<<EOF>>   {return end_of_file; }
%%