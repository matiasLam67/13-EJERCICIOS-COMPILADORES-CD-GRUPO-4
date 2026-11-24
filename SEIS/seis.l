/* Declaraciones */
%{
#include <stdio.h>
%}

/* Reglas */
%%
[a-zA-Z0-9_]+([.-][a-zA-Z0-9_]+)*@[a-zA-Z0-9]+([.-][a-zA-Z0-9]+)*\.[a-zA-Z]{2,} {
    printf("CORREO VALIDO: %s\n", yytext);
}

[^ \t\r\n]+ {
    printf("CORREO NO VALIDO: %s\n", yytext);
}

[ \t\r\n]+ ;
%%

/* Codigo (main) */
int main()
{
    yylex();
    return 0;
}


