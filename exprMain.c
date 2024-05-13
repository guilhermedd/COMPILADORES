#include <stdio.h>
#include <stdlib.h>
#include "expr.tab.h"


extern FILE *yyin;

int main(int argc, char *argv[])
{
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    yyin = file;
    printf("Analisando o arquivo %s...\n", argv[1]);
    yyparse();

    fclose(file);
    return 0;
}