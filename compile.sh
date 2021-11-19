bison -d interprete.y
flex interprete.l 
cc -o interprete interprete.tab.c lex.yy.c -lfl