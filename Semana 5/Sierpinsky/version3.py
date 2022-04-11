import matplotlib.pyplot as plt
import numpy as np

xs = np.array([0, 5, 10])
ys = np.array([0, 10, 0])

max_x = np.max(xs)
max_y = np.max(ys)

min_x = np.min(xs)
min_y = np.min(ys)


def recta(x1, x2, y1, y2, t): return ((y2-y1)/(x2-x1))*(t-x1)+y1


index = np.random.randint(0, 2)
px1 = xs[index]
py1 = ys[index]
px2 = xs[index+1]
py2 = ys[index+1]
temp_x = np.random.rand(1)
temp_y = np.random.rand(1)
ry = recta(px1, px2, py1, py2, temp_x)

while(temp_y >= ry):
    temp_x = np.random.rand(1)
    temp_y = np.random.rand(1)
    ry = recta(px1, px2, py1, py2, temp_x)

cx = np.append([], temp_x)
cy = np.append([], temp_y)


for i in range(3000):
    index = np.random.randint(0, 3)
    px, py = xs[index], ys[index]
    xn, yn = cx[i], cy[i]

    vxn = (px + xn)/2
    vyn = (py + yn)/2

    cx = np.append(cx, vxn)
    cy = np.append(cy, vyn)


cx = np.append(cx, xs)
cy = np.append(cy, ys)
t = np.random.randn(cx.size)
plt.scatter(cx, cy, c=t, alpha=0.5, cmap="viridis")
plt.show()
