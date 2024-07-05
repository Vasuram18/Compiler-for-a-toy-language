%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "cucu.tab.h"
FILE *lexout;
%}


%%

"int"                   {fprintf (lexout,"TYPE : int\n"); return INT;}
"char *"                {fprintf (lexout,"TYPE : char*\n"); return CHAR;}
"while"                 {fprintf (lexout,"WHILE : while\n"); return WHILE;}
"if"                    {fprintf (lexout,"IF : if\n"); return IF;}
"else"                  {fprintf (lexout,"ELSE : else\n"); return ELSE;}
"return"                {fprintf (lexout, "RETURN : return\n"); return RETURN;}
[a-zA-Z_][a-zA-Z0-9_]*  {fprintf (lexout,"ID : %s\n", yytext); yylval.str=strdup(yytext); return ID;}
\"[^"]*\"               {fprintf (lexout, "STRING : %s\n", yytext); yylval.str=strdup(yytext); return STRING;}
[0-9]+                  {fprintf (lexout,"NUM : %d\n", yylval.num=atoi(yytext)); return NUM;}
","                     {fprintf (lexout,"COMMA : ,\n"); return COMMA;}
"="                     {fprintf (lexout,"ASSIGN : =\n"); return ASSIGN;}
"+"                     {fprintf (lexout,"PLUS : +\n"); return PLUS;}
"-"                     {fprintf (lexout,"MINUS : +\n"); return MINUS;}
"/"                     {fprintf (lexout,"DIV : /\n"); return DIV;}
"*"                     {fprintf (lexout,"MUL : *\n"); return MUL;}
";"                     {fprintf (lexout,"SEMI : ;\n"); return SEMI;}
"{"                     {fprintf (lexout,"LBRACE: {\n"); return LBRACE;}
"}"                     {fprintf (lexout,"RBRACE : }\n"); return RBRACE;}
"("                     {fprintf (lexout,"LPAREN : (\n"); return LPAREN;}
")"                     {fprintf (lexout,"RPAREN : )\n"); return RPAREN;}
"["                     {fprintf (lexout,"LSBRAC : [\n"); return LSBRAC;}
"]"                     {fprintf (lexout,"RSBRAC : ]\n"); return RSBRAC;}
">"                     {fprintf (lexout,"GREATER_THAN : >\n"); return GREATER_THAN;}
"<"                     {fprintf (lexout,"LESS_THAN : <\n"); return LESS_THAN;}
"=="                    {fprintf (lexout,"RELATIONAL_EQUALS : ==\n"); return RELATIONAL_EQUALS;}
"<="                    {fprintf (lexout,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL;}
">="                    {fprintf (lexout,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL;}
"!="                    {fprintf (lexout,"RELATIONAL_NOT_EQUAL : !=\n"); return RELATIONAL_NOT_EQUAL;}
\/\*(.|\n)*\*\/         ;
[ \t\n]+                ;

%%

int yywrap(){
    return 1;
}


