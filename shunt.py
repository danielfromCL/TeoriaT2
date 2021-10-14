def shunt(infix):
    # Curly braces = dictionary
    # *, +, and ? are repetition operators. They take precedence over concatenation and alternation operators
    # * = Zero or more
    # + = One or more
    # ? = Zero or one
    # . = Concatenation
    # | =  Alternation
    specials = {'*': 2, '.': 1, '|': 0}

    pofix = ""
    stack = ""

    # Loop through the string one character at a time
    for c in infix:
        # print(c)
        # print(stack)
        if c == ' ':
            continue 
        elif c == '(':
            stack = stack + c
        elif c == ')':
            while stack[-1] != '(':
                pofix, stack = pofix + stack[-1], stack[:-1]
            # Remove '(' from stack
            stack = stack[:-1]
        elif c in specials:
            while stack and specials.get(c, 0) <= specials.get(stack[-1], 0):
                pofix, stack = pofix + stack[-1], stack[:-1]
            stack = stack + c
        else:
            pofix = pofix + c

    while stack:
        pofix, stack = pofix + stack[-1], stack[:-1]
        
    return pofix

print(shunt("a.b.c*"))
print("------------------")
print(shunt("((a . b) . c) *"))
print(shunt("(\( | \))"))