%{
    #include <stdio.h>
    int stackNumber[10];
    int stackPointer = 0;
    void yyerror(const char *message);
%}
%union
{
    signed int ival;
}
%token  add sub mul divi end_of_file
%token  <ival>  number
%type   <ival>  EXP EXPS LINE ERRORS

%%
LINE : EXPS    { return(0); }
    ;
EXPS : EXP EXPS
     | EXP
    ;
EXP : number {          
                if(stackPointer >= 0 && stackPointer < 10)
                {
                    stackNumber[stackPointer] = $1;
                    stackPointer++;
                    int i;
                    printf("The contents of the stack are:");
                    for (i = 0; i < stackPointer; ++i) {
                        printf(" %d", stackNumber[i]);
                    }
                    printf("\n");
                } 
                else {
                    printf("Runtime Error: The push will lead to stack overflow.\n");
                    return(0);
                } 
            }
    | add   {
                if(stackPointer >= 2)
                {
                    stackNumber[stackPointer - 2] = stackNumber[stackPointer - 1] + stackNumber[stackPointer - 2];
                    $$ = stackNumber[stackPointer - 2];
                    stackPointer--;
                    int i;
                    printf("The contents of the stack are:");
                    for (i = 0; i < stackPointer; ++i) {
                        printf(" %d", stackNumber[i]);
                    }
                    printf("\n");
                }
                else {
                    printf("Runtime Error: The pop will lead to stack underflow.\n");
                    return(0);
                }
            }
    | sub   {
                if(stackPointer >= 2)
                {
                    stackNumber[stackPointer - 2] = stackNumber[stackPointer - 2] - stackNumber[stackPointer - 1];
                    $$ = stackNumber[stackPointer - 2];
                    stackPointer--;
                    int i;
                    printf("The contents of the stack are:");
                    for (i = 0; i < stackPointer; ++i) {
                        printf(" %d", stackNumber[i]);
                    }
                    printf("\n");
                }
                else {
                    printf("Runtime Error: The pop will lead to stack underflow.\n");
                    return(0);
                }
            }
    | mul   {
                if(stackPointer >= 2)
                {
                    stackNumber[stackPointer - 2] = stackNumber[stackPointer - 1] * stackNumber[stackPointer - 2];
                    $$ = stackNumber[stackPointer - 2];
                    stackPointer--;
                    int i;
                    printf("The contents of the stack are:");
                    for (i = 0; i < stackPointer; ++i) {
                        printf(" %d", stackNumber[i]);
                    }
                    printf("\n");
                }
                else {
                    printf("Runtime Error: The pop will lead to stack underflow.\n");
                    return(0);
                }   
            }
    | divi   {
                if(stackPointer >= 2)
                {
                    stackNumber[stackPointer - 2] = stackNumber[stackPointer - 2] / stackNumber[stackPointer - 1];
                    $$ = stackNumber[stackPointer - 2];
                    stackPointer--;
                    int i;
                    printf("The contents of the stack are:");
                    for (i = 0; i < stackPointer; ++i) {
                        printf(" %d", stackNumber[i]);
                    }
                    printf("\n");
                }
                else {
                    printf("Runtime Error: The pop will lead to stack underflow.\n");
                    return(0);
                }
            }
    ;
%%
void yyerror (const char *message)
{
    printf("Runtime Error: The push will lead to stack overflow.");
}
int main(int argc, char *argv[])
{
    yyparse();
    return(0);
}