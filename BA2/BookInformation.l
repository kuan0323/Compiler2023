%{

%}
year  [0-9]{4}
BigMonth  ([0][13578]|[1][0]|[1][2])
BigDay  ([0][1-9]|[1][0-9]|[2][0-9]|[3][0-1])
SmallMonth  ([0][469]|[1][1])
SmallDay  ([0][1-9]|[1][0-9]|[2][0-9]|[3][0])

%%
([A-Z][a-z]+_|ABC){1,}[A-Z][a-z]*  { printf("Book name:"); ECHO; printf("\n"); }
[_][a-z]+[_]([A-Z][a-z]+_|ABC){1,1}[A-Z][a-z]*  { }
[A-Z]+[\,][ ]([A-Z][a-z]*-|ABC){1,}[A-Z][a-z]*  { printf("Author:"); ECHO; printf("\n"); }
{year}[\/]{BigMonth}[\/]{BigDay}  { printf("Publication date:"); ECHO; printf("\n"); }
{year}[\/]{SmallMonth}[\/]{SmallDay}  { printf("Publication date:"); ECHO; printf("\n"); }
{year}[\/][0][2][\/][2][9]  { printf("Publication date:"); ECHO; printf("\n"); }
{year}[\/][0-9]{2}[\/][0-9]{2}  { }
[9][7][8][-][0-9][-][0-9]{6}[-][0-9]{2}[-][0-9]  { printf("ISBN:"); ECHO; }
. { }
%%
int main(int argc, char *argv[]) {
    yylex();
    return (0);
}