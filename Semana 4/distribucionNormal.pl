/****************************************************
    Programa:   area.pl
    Funcion:    Calculo de integrales definidas.
    -----------------------------------------------
    Ejercicio:  Elabora un programa en Prolog
                para imprimir la tabla de la
                distribución normal estandar

        Emmanuel Arias Aguilar
*****************************************************/
main:-
    N is 1000,
    write('________________________________________________________________________________________'),nl,
    write('x'), write('\t'),
    columna(0, 0.09),nl,
    write('________________________________________________________________________________________'),nl,
    completar(0, 0, 0.01, 4, N, 0),
     write('________________________________________________________________________________________').
    
f(X, Y):- Y is exp(-X*X/2) /sqrt(2*pi).

suma(_, _, N, N, 0) :- !.
suma(A, Base, I, N, Area):- 
    I1 is I +1,
    suma(A, Base, I1, N, Area1),
    X1 is A + I*Base, X2 is  X1 + Base,
    f(X1, Y1), f(X2, Y2), Y is (Y1 + Y2)/2,
    Area is Base*Y + Area1.

columna(F, F):-write(F),!.
columna(I, F):-
    I < F, !,
    write(' '), format('~2f',I), write('\t'),
    I1 is I+0.01,
    columna(I1,F).

completar(_, B, _, B, _, _):- !.
completar(A, B, I, T, N, CONT):-
    B \= T, !,
    Base is (B-A)/N,
    suma(A, Base, 0, N, Area),
    fila(CONT, B),
    format('~4f', Area), write('\t'),
    B1 is B+I, CONT1 is CONT+I,
    (CONT1 =< 0.09) -> completar(A,B1,I,T,N,CONT1);
    B2 is B+0.01, round(B2, Y, 2),nl, completar(A,Y,I,T,N,0).

fila(CONT, B):-
    (CONT = 0) -> format('~1f',B),write('|'), write('\t'); write('|').

round(X,Y,D) :- Z is X * 10^D, round(Z, ZA), Y is ZA / 10^D.