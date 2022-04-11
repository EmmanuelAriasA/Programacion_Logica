import turtle as t
 
def sanjiaoxing(san):
    """
         Pase las coordenadas de tres puntos y dibuje un triángulo
    """
    t.penup()
    t.goto(san[0])
    t.pendown()
    t.goto(san[1])
    t.goto(san[2])
    t.goto(san[0])
 
def get_mid(a, b):
    """
         Calcule las coordenadas del punto medio devolviendo 2 puntos
    """
    x = (a[0] + b[0]) / 2
    y = (a[1] + b[1]) / 2
    return [x, y]
 
def draw_san(size, i):
    """
         Dibujar la función del triángulo de Sierpinski
         : tamaño del parámetro: lista de coordenadas de tres puntos
         : parámetro i: tiempos de recursión
    """
         # Dibujar triángulo
    sanjiaoxing(size)
    if i > 0:
                 # Dibuja un pequeño triángulo a la izquierda
        size2 = [size[0], get_mid(size[0], size[1]), get_mid(size[0], size[2])]
        draw_san(size2, i - 1)
 
                 # Dibuja el triángulo superior
        size3 = [get_mid(size[0], size[2]), get_mid(size[1], size[2]), size[2]]
        draw_san(size3, i - 1)
        
                 # Dibuja un pequeño triángulo a la derecha
        size4 = [get_mid(size[0], size[1]), size[1], get_mid(size[1], size[2])]
        draw_san(size4, i - 1)
 
def main():
    """
         Función principal
    """
         # Imprime el título gráfico
    t.penup()
    t.left(90)
    t.forward(350)
    t.pendown()
    #t.write ("triángulo de Sierpinski", falso, alinear = "centro", font = (" ", 20, "normal"))
    t.speed(5)
 
         # Coordenadas triangulares iniciales
    points = [[-200, 0], [200, 0], [0, 300]]
         # Recursión 5 veces
    count = 5
         # Llamada dibujar la función del triángulo de Sierpinski
    draw_san(points, count)
 
    t.exitonclick()
 
 
if __name__ == '__main__':
    main()