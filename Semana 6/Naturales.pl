/*******************************************************
    Programa:   Naturales.pl
    Función:    Implementación de numeros 
                naturales con los postulados de Peana

    1)  0 es un numero natural
    2)  Si n es un numero natural, si(n) tambien lo es
    3)  0 no es sucesor de nungun natural.
    4)  Si n y m son naturales y s(n) = s(m), entonces
        n = m
    5)  Si 0 pertenece a A, y dado un natural n su sucesor
        tambien pertenece a A, entonces todos los naturales
        pertenecen a A.
*******************************************************/

main:-
    representa(3,N1),
    representa(2,N2),
    factorial(N2, F), write(F),nl,
    corresponde(F, R1), write(R1),nl,nl,
    potencia(N1,N2,P),write(P),nl,
    corresponde(P,R2), write(R2),nl,nl,
    ackerman(N1,N2,A), write(A),nl,
    corresponde(A,R3), write(R3).

natural(0) :- !.
natural(s(X)) :- natural(X).

representa(0, 0) :- !.
representa(N, s(X)) :-
    N1 is N - 1,
    representa(N1, X).

corresponde(0, 0) :- !.
corresponde(s(X), N) :-
    corresponde(X, N1),
    N is N1 + 1.

suma(0, X, X) :- !.
suma(s(X), Y, s(Z)) :-
    suma(X, Y, Z).

resta(X, Y, R):-
    corresponde(X,N1),
    corresponde(Y,N2),
    OP is N1 - N2,
    representa(OP, R).

multiplica(0, _, 0) :- !.
multiplica(s(X), Y, Z) :-
    multiplica(X, Y, W),
    suma(Y, W, Z).

factorial(0, s(0)) :- !.
factorial(s(X), F) :-
    resta(s(X),s(0), Z),
    factorial(Z, F1),
    multiplica(s(X),F1,F).

potencia(_,0,s(0)) :- !.
potencia(s(X),s(Y),P):-
    resta(s(Y),s(0), R),
    potencia(s(X),R,P1),
    multiplica(s(X),P1,P).

ackerman(0,0,s(0)):- !.
ackerman(0,s(Y),R):- !, suma(s(Y), s(0), R).
ackerman(s(X),0,R):- !,
    resta(s(X),s(0),Z),
    ackerman(Z,s(0),R).
ackerman(s(X),s(Y),R):- !,
    resta(s(X),s(0),A),
    resta(s(Y),s(0),B),
    ackerman(s(X),B,R1), ackerman(A,R1,R).