from turtle import *
from numpy import random

def copoNieve(direccion, iteraciones):
    if iteraciones == 0:
        forward(direccion)
        return
    direccion /= 3.0
    copoNieve(direccion, iteraciones-1)
    left(60)
    copoNieve(direccion, iteraciones-1)
    right(120)
    copoNieve(direccion, iteraciones-1)
    left(60)
    copoNieve(direccion, iteraciones-1)

if __name__ == "__main__":
    speed(0)
    length = 300.0
    penup()

    backward(length/2.0)

    iteraciones = random.randint(1, 6)

    pendown()
    for i in range(3):
        copoNieve(length, iteraciones)
        right(120)

    mainloop()