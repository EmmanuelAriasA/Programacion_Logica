import matplotlib.pyplot as plt
import numpy as np


def get_iter(c: complex, thresh: int = 4, max_steps: int = 25) -> int:
    z = c
    i = 1
    while i < max_steps and (z*z.conjugate()).real < thresh:
        z = z*z + c
        i += 1
    return i


def plotter(n, thresh, max_steps=25):
    mx = 2.48 / (n-1)
    my = 2.26 / (n-1)
    def mapper(x, y): return (mx*x - 2, my*y - 1.13)
    img = np.full((n, n), 255)
    for x in range(n):
        for y in range(n):
            it = get_iter(complex(*mapper(x, y)),
                          thresh=thresh, max_steps=max_steps)
            img[y][x] = 255 - it
    return img


n = 1000
img = plotter(n, thresh=4, max_steps=50)
plt.imshow(img, cmap="plasma")
plt.axis("off")
plt.show()
