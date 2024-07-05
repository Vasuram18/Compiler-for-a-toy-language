%{
#include <stdio.h>
#include <string.h>
#include <math.h>
int yylex();
void yyerror(char const *);
extern FILE *yyin,*yyout,*lexout;

%}

%token LESS_THAN
%token INT
%token CHAR
%token WHILE
%token IF
%token ELSE
%token RETURN
%token COMMA
%token ASSIGN
%token PLUS
%token MINUS
%token DIV
%token MUL
%token SEMI
%token LBRACE
%token RBRACE
%token LPAREN
%token RPAREN
%token LSBRAC
%token RSBRAC
%token GREATER_THAN
%token RELATIONAL_EQUALS
%token LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL
%token RELATIONAL_NOT_EQUAL
%token <num> NUM
%token <str> ID
%token <str> STRING
%left LPAREN RPAREN
%left PLUS MINUS
%left MUL DIV


%union{
    int num;
    char *str;
}
%%

programs : program
         ;

program : declaration_var               {fprintf(yyout,"\n");}
        | declaration_func              {fprintf(yyout,"\n");}
        | definition_func               {fprintf(yyout,"\n");}
        | program declaration_var       {fprintf(yyout,"\n");}
        | program declaration_func      {fprintf(yyout,"\n");}
        | program definition_func       {fprintf(yyout,"\n");}
	;

declaration_var : int identifier SEMI 
                | int identifier ASSIGN expression SEMI        {fprintf(yyout,"assignment : =\n");}
                | char identifier SEMI               
                | char identifier ASSIGN string SEMI            {fprintf(yyout,"assignment : =\n");}
                ;

declaration_func : int identifier LPAREN arguments RPAREN SEMI           {fprintf(yyout,"Function Declared\n\n");}
                 | int identifier LPAREN RPAREN SEMI                           {fprintf(yyout,"Function Declared\n\n");}
                 | char identifier LPAREN arguments RPAREN SEMI                {fprintf(yyout,"Function Declared\n\n");}
                 | char identifier LPAREN RPAREN SEMI                          {fprintf(yyout,"Function Declared\n\n");}
                 ;

definition_func : int identifier LPAREN arguments RPAREN list_func       {fprintf(yyout,"Function Defined \n\n");}
                | int identifier LPAREN RPAREN list_func                      {fprintf(yyout,"Function Defined \n\n");}
                | char identifier LPAREN arguments RPAREN list_func           {fprintf(yyout,"Function Defined \n\n");}
                | char identifier LPAREN RPAREN list_func                     {fprintf(yyout,"Function Defined \n\n");}
;

arguments : int identifier                   {fprintf(yyout,"Function Arguments Passed \n\n");}
          | int identifier COMMA arguments
          | char identifier                        {fprintf(yyout,"Function Arguments Passed \n\n");}
          | char identifier COMMA arguments
;

int : INT       {fprintf(yyout,"Datatype : int\n");}
    ;

char : CHAR     {fprintf(yyout,"Datatype : char *\n");}
     ;

list_func : LBRACE statements RBRACE
          | statement
          ;

statements : statements statement
           | statement
           ;

statement : assignment
          | function_call             {fprintf(yyout,"Function call ends \n\n");}
          | return_statement           {fprintf(yyout,"Return statement \n\n");}
          | conditional_statement             {fprintf(yyout,"If Condition Ends \n\n");}
          | loop               {fprintf(yyout,"While Loop Ends \n\n");}
          | declaration_var
;

return_statement : RETURN SEMI
                 | RETURN expression SEMI
                 ;
function_call : identifier LPAREN RPAREN SEMI
              | identifier LPAREN expression
              ;

assignment : expression ASSIGN expression SEMI
           ;

loop : WHILE LPAREN boolean_exp RPAREN list_func
     ;

conditional_statement : IF LPAREN boolean_exp RPAREN list_func
                      | IF LPAREN boolean_exp RPAREN list_func ELSE list_func
                      ;

boolean_exp : boolean_exp RELATIONAL_EQUALS boolean_exp           {fprintf(yyout,"Operator : == \n");}
            | boolean_exp RELATIONAL_NOT_EQUAL boolean_exp       {fprintf(yyout,"Operator : != \n");}
            | boolean_exp LESS_THAN_EQUAL boolean_exp         {fprintf(yyout,"Operator : <= \n");}
            | boolean_exp GREATER_THAN_EQUAL boolean_exp      {fprintf(yyout,"Operator : >= \n");}
            | boolean_exp LESS_THAN boolean_exp              {fprintf(yyout,"Operator : < \n");}
            | boolean_exp GREATER_THAN boolean_exp            {fprintf(yyout,"Operator : > \n");}
            | expression
            ;

identifier : ID      {fprintf(yyout,"identifier : %s \n", $1);}
           ;

number : NUM    {fprintf(yyout,"number_val : %d \n", $1);}
       ;

string : STRING {fprintf(yyout,"string : %s \n", $1);}
       ;

expression : LPAREN expression RPAREN
           | expression PLUS expression            {fprintf(yyout,"Operator : + \n");}
           | expression MINUS expression           {fprintf(yyout,"Operator : - \n");}
           | expression MUL expression             {fprintf(yyout,"Operator : * \n");}
           | expression DIV expression             {fprintf(yyout,"Operator : / \n");}
           | number                    
           | identifier
           ;

%%

int main()
{
    yyin=fopen("Sample1.cu","r");
    //yyin=fopen("Sample2.cu","r");
    yyout=fopen("Parser.txt","w");
    lexout=fopen("Lexer.txt","w");
    yyparse();
    return 0;
}

void yyerror(char const *s){
    printf("syntax Error\n");
}

