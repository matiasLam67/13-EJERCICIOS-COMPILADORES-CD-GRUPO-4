/* Declaraciones */
%{
#include <stdio.h>
%}

/* Definiciones regulares */
DIGITO      [0-9]
LETRA       [a-zA-Z_]

/* Reglas */
/* Reconocimiento de palabras reservadas, identificadores y enteros */
%%
"if"|"else"|"while"|"int"   { printf("TOKEN: PALABRA_RESERVADA | LEXEMA: %s\n", yytext); }
{LETRA}({LETRA}|{DIGITO})*  { printf("TOKEN: IDENTIFICADOR     | LEXEMA: %s\n", yytext); }
{DIGITO}+                   { printf("TOKEN: NUMERO_ENTERO     | LEXEMA: %s\n", yytext); }
[ \t\n\r]+                  { /* Ignorar espacios en blanco */ }
.                           { printf("TOKEN: DESCONOCIDO       | LEXEMA: %s\n", yytext); }
%%

/* Codigo (main) */
int main()
{
    printf("==========ANALISIS LEXICO DE TOKENS==========\n");
    yylex();
    printf("=============================================\n");
    return 0;
}
