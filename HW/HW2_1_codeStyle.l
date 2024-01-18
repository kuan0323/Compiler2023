%{
unsigned int tabCount = 0;

void addSpaces() {
	int i = 0;
	while (i < tabCount) {
		printf("\t");
		++i;
	}
}
%}
spaces  ^[\t]+
others  ^.
%%
{spaces}    {
	addSpaces();
}
^\{  { addSpaces(); tabCount++; ECHO; }
\{  { tabCount++; ECHO; }
^\}  { tabCount--; addSpaces(); ECHO; }
\}  { tabCount--; ECHO; }
{others}  { addSpaces(); ECHO; }
%%
int main(int argc, char *argv[]) {
	yylex();
	return(0);
}
int yywrap() {
    return 1;
}
