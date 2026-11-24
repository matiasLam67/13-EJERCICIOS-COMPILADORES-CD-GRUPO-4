/* Declaraciones */
%{
#include <stdio.h>
%}

/* Reglas */
/* Normalizacion lexica: conversion de mayusculas a minusculas */
%%
[A-Z]       { printf("%c", yytext[0] + 32); /* Desplazamiento ASCII a minuscula */ }
.|\n        { printf("%s", yytext);         /* Dejar el resto de caracteres igual */ }
%%

/* Codigo (main) */
int main()
{
    yylex();
    return 0;
}
