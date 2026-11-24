/* Declaraciones */
%{
#include <stdio.h>

/* Contadores globales de cada categoria */
int mayusculas = 0;
int minusculas = 0;
int digitos = 0;
int espacios = 0;
%}

/* Reglas */
/* Clasificacion previa a la formacion de tokens */
%%
[A-Z]       { mayusculas++; /* Letras mayusculas */ }
[a-z]       { minusculas++; /* Letras minusculas */ }
[0-9]       { digitos++;    /* Digitos numericos */ }
[ \t\n\r]   { espacios++;   /* Espacios en blanco, tabulaciones y saltos */ }
.           { /* Omision de signos de puntuacion y caracteres especiales */ }
%%

/* Codigo (main) */
int main()
{
    yylex();

    printf("==========RESUMEN DE CLASIFICACION==========\n");
    printf("Letras mayusculas: %d\n", mayusculas);
    printf("Letras minusculas: %d\n", minusculas);
    printf("Digitos: %d\n", digitos);
    printf("Espacios en blanco: %d\n", espacios);

    return 0;
}
