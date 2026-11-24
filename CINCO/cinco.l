/* Declaraciones */
%{
#include <stdio.h>

int frecuencia[10] = {0};
%}

/* Reglas */
/* Conteo de frecuencia de cada digito */
%%
[0-9]       { frecuencia[yytext[0]-'0']++; }
.|\n        { /* Ignorar otros caracteres */ }
%%

/* Codigo (main) */
int main()
{
    yylex();

    printf("==========FRECUENCIA DE DIGITOS==========\n");
    printf("Digito\tFrecuencia\n");

    for(int i=0; i<10; i++)
    {
        printf("%d\t%d\n", i, frecuencia[i]);
    }

    printf("=========================================\n");

    return 0;
}

