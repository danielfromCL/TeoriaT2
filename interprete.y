// Librerias auxiliares
%{
#include <stdio.h>

%}

// Tipos
%union {
int nexpr;
char* sexp;
int bexpr;

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


// Tipos
%type <nexpr> NUMBER    // El valor semántico de un NUMBER es un valor numérico.
%type <nexpr> numexp    // El valor al que reducimos una expresión numerica es un valor numérico.
%type <sexpr> STRING    // El valor semántico de un STRING es un string.
%type <sexpr> strexp    // El valor al que reducimos una expresión literal es un string.
%type <bexpr> NUMBER    // El valor semántico de un NUMBER es un valor numérico.
%type <bexpr> bexp      // El valor al que reducimos una expresión boleana es un valor numerico.


// Gramatica (reglas) y codigo a ejecutar.
%%
// Se utilizan los $i para obtener el valor de la expresion en la posición i.
input: // Aqui hay una regla vacia. Junto con la siguiente permiten implementar el ciclo del REPL.
 | input numexp EOL { printf("= %d\n", $2); }
 ;
numexp: NUMBER // Si no se especifica nada $$ = $1. OJO, todo esto trabaja de manera recursiva.
 | OP numexp ADD numexp  CP { $$ = $2 + $4; } // $$ valor semántico del primer numexp.
 | OP numexp MUL numexp  CP { $$ = $2 * $4; }
 | OP numexp SUB numexp  CP { $$ = $2 - $4; }
 | LEN strexp LEN { $$ = strlen($2); }
 ;
 bexp: NUMBER
   OP nexpr LESSTHAN nexpr CP { $$ = ($2 < $4) ? 1 : 0; }
   OP nexpr EQUAL nexpr CP {$$ = ($2 == $4) ? 1 : 0; }
   OP bexp AND bexp CP  {$$ = (($2 == 1) && ($4 == 1)) ? 1: 0; }
   OP NOT bexp CP {$$ = ($3 == 1) ? 0 : 1; }
   OP IF bexp nexpr nexpr {$$ = ($3 == 1) ? $4 : $5; }
 ;
 sexpr: STRING //
   OP IF bexp strexp strexp CP {$$ = ($3 == 1) ? $4 : $5; }
   OP sexpr CONCAT strexp CP { $$ = strcat($2, $4)}
 ;

%% 

// Codigo principal que llama a yyparse().
int main(int argc, char **argv) {
  yyparse();
  return 0;
}

// Codigo para mensajes de error.
int yyerror(char *s) {
  fprintf(stderr, "error: %s\n", s);
  return 0;
}