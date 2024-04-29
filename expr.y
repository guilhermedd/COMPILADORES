%{
#define YYSTYPE double
#include <stdio.h>
#include <stdlib.h>

int yyerror(const char *);
int yylex();

%}
%define parse.error verbose

%token TADD TMUL TSUB TDIV TAPAR TFPAR TNUM TMEN TMAI TMENI TMAII TIGL TDIF TCONJ TDISJ TNEG TID TASSIGN TFIM

%left TDISJ
%left TCONJ
%right TNEG

%left TADD TSUB
%left TMUL TDIV


%%
Linha :Expr TFIM {printf("Resultado:%lf\n", $1);exit(0);}
	| Rel TFIM {if ($1 != 0) printf("True\n"); else printf("False\n");exit(0);}
	| Log TFIM {if ($1 != 0) printf("True\n"); else printf("False\n");exit(0);}
	;
Expr: Expr TADD Termo {$$ = $1 + $3;}
	| Expr TSUB Termo {$$ = $1 - $3;}
	| Termo
	;
Termo: Termo TMUL Fator {$$ = $1 * $3;}
	| Termo TDIV Fator {$$ = $1 / $3;}
	| Fator
	;
Fator: TNUM
	| TAPAR Expr TFPAR {$$ = $2;}
	;
Rel : Expr TMENI Expr {$$ = $1 <= $3;}
	| Expr TMAII Expr {$$ = $1 >= $3;}
	| Expr TMEN Expr {$$ = $1 < $3;}
	| Expr TMAI Expr {$$ = $1 > $3;}
	| Expr TIGL Expr {$$ = $1 == $3;}
	| Expr TDIF Expr {$$ = $1 != $3;}
	;
Log : Log TCONJ Log {$$ = $1 && $3;}
	| Log TDISJ Log {$$ = $1 || $3;}
	| TNEG Log {$$ = !$2;}
	| TAPAR Log TFPAR {$$ = $2;}
	| Rel
	;
%%

int yyerror (const char *str)
{
	fprintf(stderr, "%s\n", str);
}

