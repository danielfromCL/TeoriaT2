// Librerias auxiliares
%{
#include <stdio.h>
#include <string.h>
int yylex();
void yyerror(char *s);
%}

// Tipos
%union {
int nexpr;
char* sexpr;
char* bexpr;

}

// TOKENS que genera el analizador lexico (calc.l)
%token NUMBER
%token ADD MUL SUB 
%token OP CP
%token EOL
%token STRING
%token LESSTHAN EQUAL AND NOT 
%token IF
%token CONCAT
%token LEN
%token BOOL


// Tipos
%type <nexpr> NUMBER    // El valor semántico de un NUMBER es un valor numérico.
%type <nexpr> numexp    // El valor al que reducimos una expresión numerica es un valor numérico.
%type <sexpr> STRING    // El valor semántico de un STRING es un string.
%type <sexpr> strexp    // El valor al que reducimos una expresión literal es un string.
%type <bexpr> BOOL   // El valor semántico de un NUMBER es un valor numérico.
%type <bexpr> bexp      // El valor al que reducimos una expresión boleana es un string.


// Gramatica (reglas) y codigo a ejecutar.
%%
// Se utilizan los $i para obtener el valor de la expresion en la posición i.
input: // Aqui hay una regla vacia. Junto con la siguiente permiten implementar el ciclo del REPL.
 | input numexp EOL { printf("= %d\n", $2); }
 | input strexp EOL { printf("= %s\n", $2); }
 | input bexp EOL { printf("= %s\n", $2); }
 ;
numexp: NUMBER // Si no se especifica nada $$ = $1. OJO, todo esto trabaja de manera recursiva.
 | OP numexp ADD numexp CP { $$ = $2 + $4; } // $$ valor semántico del primer numexp.
 | OP numexp MUL numexp CP { $$ = $2 * $4; }
 | OP numexp SUB numexp  CP { $$ = $2 - $4; } 
 | OP numexp CP { $$ = $2 ; }
 | LEN strexp LEN { $$ = strlen($2); }
 | LEN OP strexp CP LEN { $$ = strlen($3); } 
 | OP IF bexp numexp numexp CP {$$ = (strlen($3) == 5) ? $4 : $5; }
 ;
 bexp: BOOL
 | OP numexp LESSTHAN numexp CP { $$ = ($2 < $4) ? "\\true" : "\\false"; }
 | OP numexp EQUAL numexp CP {$$ = ($2 == $4) ? "\\true" : "\\false"; }
 | OP bexp AND bexp CP  {$$ = ((strlen($2) == 5) && (strlen($4) == 5)) ? "\\true": "\\false"; }
 | OP NOT bexp CP {$$ = (strlen($3) == 5) ? "\\false" : "\\true"; }
 | OP bexp CP { $$ = $2 ; }
   ;
 strexp: STRING //
 | OP IF bexp strexp strexp CP {$$ = (strlen($3) == 5) ? $4 : $5; }
 | OP strexp CONCAT strexp CP { $$ = strcat($2, $4);}
 | OP strexp CP { $$ = $2 ; }
 ;

%% 

// Codigo principal que llama a yyparse().
int main(int argc, char **argv) {
  yyparse();
  return 0;
}

// Codigo para mensajes de error.
void yyerror(char *s) {
  fprintf(stderr, "error: %s\n", s);
}