%option noyywrap
%{
    #include "Mini_LISP.tab.h"
%}
%%
\n              { }
[ \r\t]+        { }
"+"             { return add; }
"-"             { return sub; }
"*"             { return mul; }
"\/"            { return divi; }
"mod"           { return mod; }
">"             { return greater; }
"<"             { return smaller; }
"="             { return equal; }
"\("            { return lbr; }
"\)"            { return rbr; }
"#t"            { yylval.var.bval = "#t"; return constant_true; }
"#f"            { yylval.var.bval = "#f"; return constant_false; }
"or"            { return or_op; }
"and"           { return and_op; }
"not"           { return not_op; }
"if"            { return if_exp; }
"define"        { return define; }
"print-num"     { return print_num; }
"print-bool"    { return print_bool; }
[A-Za-z][A-Za-z0-9-]* { return id; }
0|[-]?[1-9][0-9]*  { yylval.var.ival = atoi(yytext); return number; }
.               { /* do nothing */ }
<<EOF>>         {return end_of_file; }
%%