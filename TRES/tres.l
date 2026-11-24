/* Declaraciones */
%{
#include <stdio.h>
%}

/* Reglas */
/* Identificacion de operadores aritmeticos y relacionales */
%%
"+"|"-"|"*"|"/"                     { printf("TIPO: OPERADOR_ARITMETICO | LEXEMA: %s\n", yytext); }
"<="|">="|"=="|"!="|"<"|">"         { printf("TIPO: OPERADOR_RELACIONAL | LEXEMA: %s\n", yytext); }
[ \t\n\r]+                          { /* Ignorar espacios en blanco */ }
.                                   { /* Omitir otros caracteres (operandos, etc.) */ }
%%

/* Codigo (main) */
int main()
{
    printf("==========RECONOCIMIENTO DE OPERADORES==========\n");
    yylex();
    printf("================================================\n");
    return 0;
}
