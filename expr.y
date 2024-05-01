%{
#define YYSTYPE double
#include <stdio.h>
#include <stdlib.h>

int yyerror(const char *);
int yylex();

%}
%define parse.error verbose

%token TADD TMUL TSUB TDIV TAPAR TFPAR TNUM TMEN TMAI TMENI TMAII TIGL TDIF TCONJ TDISJ TNEG TID TASSIGN TFIM
%token TACH TFCH TVOID TVIRGULA TPEV TINT TSTR TFLOAT TRETURN TIF TELSE TWHILE TPRINT TREAD
%token TATRIB TLITERAL

%left TDISJ
%left TCONJ
%right TNEG

%left TADD TSUB
%left TMUL TDIV


%%
Linha :Expr TFIM {printf("Resultado:%lf\n", $1);exit(0);}
	| Rel TFIM {if ($1 != 0) printf("True\n"); else printf("False\n");exit(0);}
	| Log TFIM {if ($1 != 0) printf("True\n"); else printf("False\n");exit(0);}
	| Programa TFIM {printf("Programa!\n");exit(0);}
	| ListaFuncoes TFIM {printf("Lista Funcoes!\n");exit(0);}
	| Funcao TFIM {printf("Funcao!\n");exit(0);}
	| CmdAtrib TFIM {printf("Atribuido!\n");exit(0);}
	| Parametro TFIM {printf("Parametro!\n");exit(0);}
	| ListaParametros TFIM {printf("Lista Parametros!\n");exit(0);}
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
Programa : ListaFuncoes BlocoPrincipal
	| BlocoPrincipal
	;
ListaFuncoes : ListaFuncoes Funcao
    | Funcao
	;
Funcao : TipoRetorno TID TAPAR DeclParametros TFPAR BlocoPrincipal
	| TipoRetorno TID TAPAR TFPAR BlocoPrincipal
	;
TipoRetorno : Tipo
	| TVOID
	;
DeclParametros : DeclParametros TVIRGULA Parametro
    | Parametro
    ;
Parametro : Tipo TID
	;
BlocoPrincipal : TACH Declaracoes ListaCmd TFCH
    | TACH ListaCmd TFCH
    ;
Declaracoes : Declaracoes Declaracao
	| Declaracao
	;
Declaracao : Tipo ListaId TPEV
	;
Tipo : TINT
	| TSTR
	| TFLOAT
	;
ListaId : ListaId TVIRGULA TID
	| TID
	;
Bloco : TACH ListaCmd TFCH
	;
ListaCmd : ListaCmd Comando
	| Comando
	;
Comando : CmdSe
    | CmdEnquanto
    | CmdAtrib
    | CmdEscrita
	| CmdLeitura
	| ChamadaProc
	| Retorno
	;
Retorno : TRETURN Expr TPEV
	| TRETURN TLITERAL TPEV
	| TRETURN TPEV
	;
CmdSe : TIF TAPAR Log TFPAR Bloco
	| TIF TAPAR Log TFPAR Bloco TELSE Bloco
	;
CmdEnquanto : TWHILE TAPAR Log TFPAR Bloco
    ;
CmdAtrib : TID TATRIB Expr TPEV
	| TID TATRIB TLITERAL TPEV
	;
CmdEscrita : TPRINT TAPAR Log TFPAR TPEV
	| TPRINT TAPAR TLITERAL TFPAR TPEV
	;
CmdLeitura : TREAD TAPAR TID TFPAR TPEV
    ;
ChamadaProc : ChamadaFuncao TPEV
	;
ChamadaFuncao : TID TAPAR ListaParametros TFPAR
    | TID TAPAR TFPAR
    ;
ListaParametros : ListaParametros TVIRGULA Expr
	| ListaParametros TVIRGULA TLITERAL
	| Expr
	| TLITERAL
	;
%%

int yyerror (const char *str)
{
	fprintf(stderr, "%s\n", str);
}

