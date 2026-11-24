/* Declaraciones */
%{
#include <stdio.h>

int espera = 1;
int hay_elementos = 0;

void elemento(const char *tipo, const char *texto)
{
    if(!espera)
        printf("ERROR: falta una coma\n");

    printf("%s: %s\n", tipo, texto);
    espera = 0;
    hay_elementos = 1;
}
%}

/* Reglas */
%%
[a-zA-Z_][a-zA-Z0-9_]* {
    elemento("IDENTIFICADOR", yytext);
}

[+-]?[0-9]+ {
    elemento("ENTERO", yytext);
}

"," {
    if(espera)
        printf("ERROR: elemento faltante\n");
    else
        printf("SEPARADOR: ,\n");

    espera = 1;
}

[ \t\r]+ ;

\n {
    if(espera && hay_elementos)
        printf("ERROR: elemento final faltante\n");

    espera = 1;
    hay_elementos = 0;
}

[^, \t\r\n]+ {
    elemento("ERROR TOKEN INVALIDO", yytext);
}
%%

/* Codigo (main) */
int main()
{
    yylex();

    if(espera && hay_elementos)
        printf("ERROR: elemento final faltante\n");

    return 0;
}


