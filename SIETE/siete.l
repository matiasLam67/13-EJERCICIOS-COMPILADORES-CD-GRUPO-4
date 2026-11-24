/* Declaraciones */
%{
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
%}

/* Reglas */
%%
[01]+ {
    errno = 0;
    unsigned long long decimal = strtoull(yytext, NULL, 2);

    if(errno == ERANGE)
        printf("ERROR: numero demasiado grande\n");
    else
        printf("Binario: %s -> Decimal: %llu\n", yytext, decimal);
}

[^ \t\r\n]+ {
    printf("BINARIO NO VALIDO: %s\n", yytext);
}

[ \t\r\n]+ ;
%%

/* Codigo (main) */
int main()
{
    yylex();
    return 0;
}


