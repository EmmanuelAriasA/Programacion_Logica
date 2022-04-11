
#   Triángulo de Sierpinski
#   Seleccionar tres puntos en el plano al azar, v2, v3 y v3 (vértices). Tomar uno de ellos como base,
#   b, por ejemplo v1.
#   Repetir 10,000 (por ejemplo) veces:
#	    Seleccionar uno de los vértices al azar. Calcular el punto medio de este vertice y b, hacer este
#       punto el nuevo valor de b y graficarlo.
#
# Emmanuel Arias Aguilar

import matplotlib.pyplot as plt
import numpy as np
x = []
y = []

Ax = 2.0
Ay = 0.0
Bx = -2.0
By = 0.0
Cx = 0.0
Cy = 4.0
x.append(Ax)
y.append(Ay)
x.append(Bx)
y.append(By)
x.append(Cx)
y.append(Cy)

pX = 0.0
pY = 2.0

for i in range(0, 10000):
    x.append(pX)
    y.append(pY)

for i in range(0, 10000):
    x.append(pX)
    y.append(pY)
    C = np.random.randint(0, 3)
    if C == 0:
        pX = pX + (Ax - pX) / 2
        pY = pY + (Ay - pY) / 2
    if C == 1:
        pX = pX + (Bx - pX) / 2
        pY = pY + (By - pY) / 2
    if C == 2:
        pX = pX + (Cx - pX) / 2
        pY = pY + (Cy - pY) / 2

plt.scatter(x, y, alpha=0.5, cmap="viridis")
plt.show()
