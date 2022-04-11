/****************************************************************
    Programa: euler.pl
    e a la x =  1 + x^2/2! + x^3/3! + ...
    ---------------------------------------------------------
    sen x = x - x^3/3! + x^5/5! - x^7/7! + ...
    cos x = 1 - x^2/2! + x^4/4! - x^6/6! + ...
    Predicacods para calcular seno y coseno con series
    Imprimir tabla para comprobar seno^2x + cos^2x = 1
    Para valores de x de 0° a 90° con incrementos de 5°

    Emmanuel Arias Aguilar
*****************************************************************/
main :-
     tablaEncabezado(0,90,5).

tablaEncabezado(X,N,Cont):-
    write('         X          |'), write('         X          |'),write('       sen(X)       |'), 
    write('       cos(X)       |'), write(' sen^2(X) + cos^2(X)'),nl,
    write('----------------------------------------------------------------------------------------------------------'),nl,
    impTabla(X,N,Cont),
    write('----------------------------------------------------------------------------------------------------------'),nl.

impTabla(X,N,_):- X > N, !.
impTabla(X,N,Cont):-
    Pi is pi,
    Grados is X*(Pi/180),
    impNum(X,20,'~0f'), write('|'), impNum(Grados,20,'~5f'), write('|'),
    calcSen(Grados, Y, 0, 50, Grados, 1),
    calcCos(Grados, Y2, 0, 50, 1, 1),
    impNum(Y,20,'~5f'), write('|'),impNum(Y2,20,'~5f'), write('|'), 
    idenTrigonometrica(Y,Y2,R),
    impNum(R,20,'~5f'),nl,    
    X2 is X+Cont,
    impTabla(X2,N,Cont).   

impNum(Num,Tam, Formato):-
    format(string(String),Formato,Num),
    string_length(String,X),
    TamE is Tam-X,
    centrar(TamE, String).

espacios(0):- !.
espacios(Espacio):-
    write(' '),
    Espacio2 is Espacio-1,
    espacios(Espacio2).

centrar(Espacio,String):-
    A is Espacio mod 2, A = 0, !,
    B is Espacio/2,
    espacios(B),write(String),espacios(B).
centrar(Espacio,String):-
    E is Espacio-1,
    A is E/2,
    B is A+1,
    espacios(A),write(String),espacios(B).

calcSen(_, 0, I, N, _, _) :- I > N, !.
calcSen(X, Y, I, N, Num, Den) :- 
    I1 is I+1, 
    Aux2 is I1*2,
    Aux1 is Aux2+1,
    Num1 is Num*X*X*(-1),
    Den1 is Den*Aux2*Aux1,
    calcSen(X,Y1,I1,N,Num1,Den1),
    Y is Num/Den + Y1.

calcCos(_, 0, I, N, _, _) :- I > N, !.
calcCos(X, Y, I, N, Num, Den) :- 
    I1 is I+1, 
    Aux2 is I1*2,
    Aux1 is Aux2-1,
    Num1 is Num*X*X*(-1),
    Den1 is Den*Aux2*Aux1,
    calcCos(X,Y1,I1,N,Num1,Den1),
    Y is Num/Den + Y1.

idenTrigonometrica(Sen, Cos, R):-
    Sen2 is Sen*Sen,
    Cos2 is Cos*Cos,
    R is Sen2 + Cos2.