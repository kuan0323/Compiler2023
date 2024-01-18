%{

%}
%%
\n { }
^[0-9]+$  { ECHO; printf(" INTERGER\n"); }
^[0-9]+"."[0-9]*$  { ECHO; printf(" FLOAT\n"); }
^[0-9]*"."[0-9]+$  { ECHO; printf(" FLOAT\n"); }
^\"[^\"]+\"$  { ECHO; printf(" STRING\n"); }
^\'[^\']+\'$  { ECHO; printf(" STRING\n"); }
^[_A-Za-z][A-Za-z0-9_]*$  { ECHO; printf(" VARIABLE\n"); }
^.+$  { }
%%
int main(int argc, char *argv[]) {
    yylex();
    return (0);
}