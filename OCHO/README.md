# Ejercicio 8. Conversión de hexadecimal a decimal

## Descripción del ejercicio

Reconoce tokens en base 16, convierte su valor a base diez y reporta cadenas que no cumplen la expresión regular. El análisis léxico distingue el formato antes de efectuar la conversión numérica.

## Código fuente (`ocho.l`)

```lex
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
```

## Explicación del código

Flex lee la especificación del archivo `.l` y genera `lex.yy.c`, que contiene el analizador en C. GCC compila ese archivo y enlaza la biblioteca de Flex mediante `-lfl`, que proporciona el comportamiento de fin de entrada necesario en estos programas. El primer delimitador `%%` abre la sección de reglas y el segundo la cierra. El bloque `%{ ... %}` contiene declaraciones de C copiadas al código generado. La función `main()` llama a `yylex()`, que consume la entrada estándar hasta el fin del archivo; `return 0` indica que el programa terminó normalmente.

Flex selecciona la regla que consume más caracteres. Si dos reglas consumen la misma cantidad, aplica la que aparece primero en la especificación. Esta propiedad permite distinguir patrones válidos de cadenas inválidas cuando ambas reglas podrían coincidir.

La biblioteca `stdio.h` permite imprimir, `stdlib.h` declara `strtoull` y `errno.h` proporciona `errno` y `ERANGE` para detectar errores de rango.

`0[xX]` exige el prefijo `0x` o `0X`. `[0-9a-fA-F]+` exige al menos un dígito hexadecimal, admitiendo letras de A a F en ambos casos. El operador `+` exige una o más repeticiones. El texto reconocido queda disponible en `yytext`. Antes de convertir, `errno = 0` elimina indicadores de errores anteriores. La función `strtoull(yytext, NULL, 16)` interpreta la cadena en base 16 y devuelve un entero sin signo de tipo `unsigned long long`. El argumento `NULL` indica que no se requiere guardar la posición donde finaliza la conversión; la expresión regular ya comprueba el formato del token.

Si `errno == ERANGE`, el valor excede el rango representable y se imprime un mensaje de error. En caso contrario, `%s` muestra el lexema original y `%llu` imprime el resultado decimal. La regla general `[^ \t\r\n]+` captura cadenas inválidas completas; por coincidencia más larga evita aceptar solamente un prefijo de una cadena incorrecta. Cuando las dos reglas coinciden con la cadena completa, prevalece la regla válida por estar primero. Los espacios y saltos de línea se ignoran mediante `[ \t\r\n]+`.

## Archivo de entrada (`entrada.txt`)

```text
0x0
0xA
0xFF
0x1A3F
0X10
0xABC
0x1G
123
```

## Compilación y ejecución

Desde la carpeta `OCHO`, se ejecutan los comandos:

```bash
flex ocho.l && gcc lex.yy.c -o a.out -lfl && ./a.out < entrada.txt | tee salida.txt
```

El operador `&&` permite continuar solo si el comando anterior finaliza correctamente. La redirección `< entrada.txt` proporciona al analizador los datos de prueba sin introducirlos manualmente. `tee salida.txt` muestra el resultado en la terminal y lo guarda en el archivo de salida. `ls -l` permite comprobar la presencia del código fuente, los archivos de entrada y salida, el C generado y el ejecutable.

## Archivo de salida (`salida.txt`)

```text
Hexadecimal: 0x0 -> Decimal: 0
Hexadecimal: 0xA -> Decimal: 10
Hexadecimal: 0xFF -> Decimal: 255
Hexadecimal: 0x1A3F -> Decimal: 6719
Hexadecimal: 0X10 -> Decimal: 16
Hexadecimal: 0xABC -> Decimal: 2748
HEXADECIMAL NO VALIDO: 0x1G
HEXADECIMAL NO VALIDO: 123
```

## Interpretación de los resultados

| Entrada | Resultado | Interpretación |
|---|---:|---|
| `0x0` | 0 | Conversión válida |
| `0xA` | 10 | Conversión válida |
| `0xFF` | 255 | Conversión válida |
| `0x1A3F` | 6719 | Conversión válida |
| `0X10` | 16 | Conversión válida |
| `0xABC` | 2748 | Conversión válida |
| `0x1G` | — | Token inválido |
| `123` | — | Token inválido |

El valor de `0x1A3F` se obtiene como 1 × 4096 + 10 × 256 + 3 × 16 + 15 = 6719. `0xABC` equivale a 10 × 256 + 11 × 16 + 12 = 2748. `0x1G` contiene un carácter no permitido y `123` carece del prefijo obligatorio.

La salida observada contiene seis conversiones correctas y dos rechazos. Las pruebas verifican el formato y la conversión de los valores pequeños proporcionados; no ejercitan la rama de desbordamiento.

## Evidencias de ejecución

![Código fuente del analizador.](codigo.png)

*Figura 1. Código fuente del analizador.*

![Compilación, entrada y resultados de la ejecución en Ubuntu.](ejecucion.png)

*Figura 2. Compilación, entrada y resultados de la ejecución en Ubuntu.*

Referencia técnica: [Manual de Flex](https://westes.github.io/flex/manual/).
