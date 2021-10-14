ER = open("regegxp.src", "r")
texto = open('text.src', "r")


# class estado:
#     id = None
#     llegada = None
#     salida = None

# class afnd:
#     inicial = None
#     final = None
    
#     def __init__(self, inicial, final):
#         self.inicial = inicial
#         self.final = final


#ctrl k ctrl c 
#ctrl k ctrl u

#recorremos hasta llegar a un ")" sin \
#volvemos hasta que encontremos un "(", vemos si tiene un "\" antes
#si tiene -> seguimos hasta encontrar otro "("
#no tiene -> sabemos que lo que esta entre ese ( y el ) es una expresion


# leo dde hay ()
# a* -> operacion = 1 -> antes del * se repite cuantas veces quiera
# leo el texto -> a -> a -> a -> a hasta que lea algo que no esta en * -> salio de la operacion = 1 
# a | b -> operacion = 2
# a . b -> operacon = 3

def ERtoAFND(exp):
    for c in range(len(exp)):
        if exp[c] == "\ ".strip(" "):
            #lo siguiente es caracter
        elif exp[c] == "(":
            #abrio parentesis
        elif exp[c] == ")":
            #cerro parentesis
         

        #cada vez que veo un ( sin \ antes -> encuentro dde se cierra el ), si lo que viene antes de este ) es un * sin \ entonces es 
        #kleene desde el primer ( hasta el ) 
        #dde hay * -> devolvemos uno, hay un \? si no entonces es kleene -> ( esta dentro de kleene
        # (ab | aba)* = (((a . b) | ((a . b) . a)) *)


'''
3.1 Infix to Postfix

The Thompson construction works best with regular expression that are written in postfix notation rather than in infix notation.

        Example for infix notation: a.b.c -> The operators are between the the operands.
        Postfix notation: ab.c. -> Here the operators come after the two operands.

The advantage of the postfix notation is that brackets can be omitted if operators with lower precedence need to be applied before operators with higher precedence.

        E.g infix: a.(b|d)? -> postfix: abd|?.

The conversion from infix to postfix regular expressions is done in the infixToPostfix function. This function uses the Shunting yard algorithm.
This algorithm uses a LIFO-Stack to cache operators and special characters. All non-special characters are appended directly to an output data structure.

When a closing bracket is encountered all elements with a lower precedence than the top element on the stack are added to the output. The opening brackets are written to the stack but not appended to the output later.

A regular expression already in postfix notation is simply returned unchanged.
'''

# def interprete(expresion, txt):
#     if simbolo:
#         hace algo
#     else: #es una operacion
#         hace otra cosa
#         return

ER.close()
texto.close()