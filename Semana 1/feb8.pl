% feb8.pl - Algunos predicados para Calendario

esBisiesto(A):-
    R is A mod 400, R = 0, !.
esBisiesto(A):-
    R is A mod 4, R = 0, !,
    R1 is A mod 100, R1 \= 0.

nombreMes(1, enero) :- !.
nombreMes(2, febrero) :- !.
nombreMes(12, diciembre).

nombreMes2(M,X):-
    nombreMes3(M, [ene,feb,mar,abr,may,jun], X).

nombreMes3(1, [X | _], X):- !.
nombreMes3(M, [_ | Resto], X):-
    M1 is M-1, nombreMes3(M1, Resto,X).