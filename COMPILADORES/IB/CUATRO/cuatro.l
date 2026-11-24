%{
    #include<stdlib.h>
%}
%%
[0-9]+                  printf("NUMERO \n");
[a-zA-Z][a-zA-Z0-9]*    printf("IDENTIFICADOR \n");

[+-]?[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?    printf("Numero Real \n");
%%
