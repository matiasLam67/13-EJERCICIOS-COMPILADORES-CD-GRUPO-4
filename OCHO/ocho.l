/* Declaraciones */
%{
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
%}

/* Reglas */
%%
0[xX][0-9a-fA-F]+ {
    errno = 0;
    unsigned long long decimal = strtoull(yytext, NULL, 16);

    if(errno == ERANGE)
        printf("ERROR: numero demasiado grande\n");
    else
        printf("Hexadecimal: %s -> Decimal: %llu\n", yytext, decimal);
}

[^ \t\r\n]+ {
    printf("HEXADECIMAL NO VALIDO: %s\n", yytext);
}

[ \t\r\n]+ ;
%%

/* Codigo (main) */
int main()
{
    yylex();
    return 0;
}

