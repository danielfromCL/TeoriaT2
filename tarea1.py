ER = open("regegxp.src", "r")
texto = open('text.src', "r")

#recorremos hasta llegar a un ")" sin \
#volvemos hasta que encontremos un "(", vemos si tiene un "\" antes
#si tiene -> seguimos hasta encontra otro "("
#no tiene -> sabemos que lo que esta entre ese ( y el ) es una expresion

