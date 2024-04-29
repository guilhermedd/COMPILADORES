%option noyywrap

%{
#define YYSTYPE double
#include "expr.tab.h"
#include <stdlib.h>
%}


delim	[ \t]
ws	{delim}+
digito	[0-9]
num	{digito}+(\.{digito}*(E[+-]?{digito}+)?)?

%%
{ws}	{}
"+"	{return TADD;}
"-"	{return TSUB;}
"*"	{return TMUL;}
"/"	{return TDIV;}
"("	{return TAPAR;}
")"	{return TFPAR;}
"<=" {return TMENI;}
">=" {return TMAII;}
"<" {return TMEN;}
">" {return TMAI;}
"==" {return TIGL;}
"!=" {return TDIF;}
"&&" {return TCONJ;}
"||" {return TDISJ;}
"!" {return TNEG;}
\n	{return TFIM;}
{num}	{yylval=atof(yytext); return TNUM;}
