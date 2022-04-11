#include <winbgim.h>

#include <stdlib.h>

#include <math.h>
void waitForLeftMouseClick();

int main()
{
    int i, m, n, R, G, B, x, y, c, div, primero = 1;
    float a, aa, b, bb, ca, cb, iteraciones, moverx = 0, movery;
    initwindow(1200, 1600);
    outtextxy(100, 150, "Programa diseñado por Hombre Federico Joel 4° Año 1° divicion Computacion");
    outtextxy(300, 300, "Haga CLICK para comenzar");
    c = 1;
    do
    {
        clearmouseclick(WM_LBUTTONDOWN);
        const int DELAY = 50;
        while (!ismouseclick(WM_LBUTTONDOWN))
            delay(DELAY);
        getmouseclick(WM_LBUTTONDOWN, x, y);
        c = c * 2;
        div = (300 * (c));

        if (x > 400)
            moverx = (moverx + (-(x - 400)));
        else
            moverx = (moverx + (400 - x));
        if (y > 300)
            movery = (movery + (-(y - 300)));
        else
            movery = (movery + (300 - y));

        for (m = 0; m < 1200; m++)
        {
            for (n = 0; n < 1600; n++)
            {
                i = 0;
                iteraciones = 300;

                ca = (float)(m - (400 + moverx)) / div;
                cb = (float)(n - (300 + movery)) / div;
                a = b = primero = 0;

                while ((i < iteraciones) && (sqrt(a * a + b * b) <= 2))
                {
                    aa = a * a - b * b + ca;
                    bb = 2 * a * b + cb;
                    a = aa;
                    b = bb;
                    i++;
                }
                R = i;
                G = i + 30;
                B = 0;
                if (i == 300)
                    putpixel(m, n, BLACK);
                else
                    putpixel(m, n, COLOR(R, G, B));
            }
        }

    } while (!kbhit());

    outtextxy(300, 300, "Programa terminado");
    closegraph();
}