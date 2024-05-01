%option noyywrap

%{
#define YYSTYPE double
#include "expr.tab.h"
#include <stdlib.h>
%}


delim	[ \t]
ws	{delim}+
digito	[0-9]
letra [a-zA-Z]
num	{digito}+(\.{digito}*(E[+-]?{digito}+)?)?
identificador {letra}({letra}|{digito})*
literal \"{identificador}\"|{digito}

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
"="  {return TATRIB;}
"!=" {return TDIF;}
"&&" {return TCONJ;}
"||" {return TDISJ;}
"!" {return TNEG;}
"{" {return TACH;}
"}" {return TFCH;}
"void"   {return TVOID;}
"," {return TVIRGULA;}
";" {return TPEV;}
"int" {return TINT;}
"string" {return TSTR;}
"float" {return TFLOAT;}
"return" {return TRETURN;}
"if" {return TIF;}
"else" {return TELSE;}
"while" {return TWHILE;}
"print" {return TPRINT;}
"read" {return TREAD;}
\n	{return TFIM;}
{num}	{yylval=atof(yytext); return TNUM;} 
{literal} {return TLITERAL;}
{identificador} {return TID;}
