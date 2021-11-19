%{
#include "interprete.tab.h"
#include <string.h>
// Abajo de este corchete pueden ir macros y otras cosas.
%}

%%

"-"     { return SUB; }     // Reduce  al producto de n por -1
"+"     { return ADD; }     // Reduce a la suma de n1 mas n2
"*"     { return MUL; }     // Reduce al producto de n1 por n2

"<"     { return LESSTHAN;} // Reduce a \true si n1 es menor que n2, y a \false si no
"="     { return EQUAL; }   // Reduce a \true si n1 es igual a n2, y a \false si no
"\\and"  { return AND; }    // Need to escape BACKSLASH TODO
"\\not"  { return NOT; }    // Need to escape BACKSLASH TODO
"\\if"   { return IF; }      // Need to escape BACKSLASH TODO


"."     { return CONCAT; }    // Reduce a s1 concatenado a s2
"|"     { return LEN;}      // Reduce al largo de s1


"("     { return OP; }      // 
")"     { return CP; }      //  
[0-1]   { yylval.bexpr = atoi(yytext); return BOOL; }
[0-9]+  { yylval.nexpr = atoi(yytext); return NUMBER; } // En yytext queda el puntero a donde quedamos en el texto, luego del matching anterior.
[a-zA-Z]+ { sscanf(yytext, "%s", yylval.sexpr); return  STRING; }
\n      { return EOL; } // Lo que queda en yylval.numval es llamado valor semántico. Por ejemplo, 10 produce el token NUMBER con valor 10.
[ \t]   ;
.       { printf("Error. Invalid character.\n"); } // . matchea cualquier simbolo. En este caso está al final, asi que no puede matchear + por ejemplo. Pero si puede matchear a.
%%
// Aqui dejamos vacio, ya que solo queremos usar calc.l dentro de calc.y,
// no usar Flex de forma independiente.
//(123+5) -> OP NUM_124 ADD NUM_5 (FLEX DEFINE LA SINTAXIS) ->  128(JACK PARSEA Y COMPUTA ESTA SUMA, SEMÁNTICA)
// Faltan tokens para el if, else, faltan tipos string, boleanos