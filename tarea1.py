ER = open("regegxp.src", "r")
texto = open('text.src', "r")

#recorremos hasta llegar a un ")" sin \
#volvemos hasta que encontremos un "(", vemos si tiene un "\" antes
#si tiene -> seguimos hasta encontrar otro "("
#no tiene -> sabemos que lo que esta entre ese ( y el ) es una expresion


# leo dde hay ()
# a* -> operacion = 1 -> antes del * se repite cuantas veces quiera
# leo el texto -> a -> a -> a -> a hasta que lea algo que no esta en * -> salio de la operacion = 1 
# a | b -> operacion = 2
# a . b -> operacon = 3

def interprete(expresion, txt):
    if simbolo:
        #hace algo
    else: #es una operacion
        #hace otra cosa
        return

ER.close()
texto.close()