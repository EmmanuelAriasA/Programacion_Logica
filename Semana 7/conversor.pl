/*******************************************************
    Programa: conversor.pl
    Funcion: escribir un numero a letra.
    maximo 999,999

    Emmanuel Arias Aguilar
*******************************************************/

main:-
    write('Cantidad de numeros a generar: '), read(R),
    genera(R,0).

genera(X,X) :- !.
genera(X,Cont) :-
    random(1,999999,Num),
    write(Num),nl,
    CenM is Num mod 1000000,
    Div1 is Num div 100000,
    centenamillar(Div1,CenM),

    DecM is CenM mod  100000,
    Div2 is DecM div 10000,
    decenamillar(Div2,DecM),

    UniM is DecM mod  10000,
    Div3 is UniM div 1000,
    unidadmillar(Div3,UniM),

    Cen is UniM mod  1000,
    Div4 is Cen div 100,
    centena(Div4,Cen),

    Dec is Cen mod  100,
    Div5 is Dec div 10,
    decena(Div5,Dec),

    Uni is Dec mod  10,
    unidad(Uni,Dec),nl,

    Cont1 is Cont + 1,
    genera(X,Cont1).

centenamillar(X,Num):-
    (X is 0) -> write('') ; centena(X,Num).

decenamillar(X,Num):-
    (X is 0) -> write('') ; decena(X,Num) ;
    (0 is Num mod 10000) -> decena(X,Num), write(' mil ') ; 
    decena(X,Num), write(' mil ').

unidadmillar(X,Num):-
    (X is 1,1 is Num div 11000) -> write(' once '), !;
    (X is 1,1 is Num div 12000) -> write(' doce '), !;
    (X is 1,1 is Num div 13000) -> write(' trece '), !;
    (X is 1,1 is Num div 14000) -> write(' catorce '), !;
    (X is 1,1 is Num div 15000) -> write(' quince '), !;
    (X is 0) -> write('') ; unidad(X, Num), write(' mil '), !.

centena(X,Num):-
    (X is 0) -> write(''), !;
    (X is 1,0 is Num mod 100) -> write(' cien '), !;
    (X is 1) -> write(' ciento '), !;
    (X is 2) -> write(' doscientos '), !;
    (X is 3) -> write(' trescientos '), !;
    (X is 4) -> write(' cuatrocientos '), !;
    (X is 5) -> write(' quinientos '), !;
    (X is 6) -> write(' seiscientos '), !;
    (X is 7) -> write(' setecientos '), !;
    (X is 8) -> write(' ochocientos '), !;
    (X is 9) -> write(' novecientos '), !.

decena(X,Num):-
    (X is 0) -> write(''), !;
    (X is 1,1 is Num div 11) -> write(' once '), !;
    (X is 1,1 is Num div 12) -> write(' doce '), !;
    (X is 1,1 is Num div 13) -> write(' trece '), !;
    (X is 1,1 is Num div 14) -> write(' catorce '), !;
    (X is 1,1 is Num div 15) -> write(' quince '), !;
    (X is 1,Num > 15) -> write(' dieci'), !;
    ((X is 2,1 is Num / 20) ; (X is 2,N is Num div 20000, N > 0))-> write(' veinte '), !;
    (X is 2) -> write(' veinti'), !;
    ((X is 3,1 is Num / 30) ; (X is 3,N is Num div 30000, N > 0)) -> write(' treinta '), !;
    (X is 3) -> write(' treinta y '), !;
    ((X is 4,1 is Num / 40) ; (X is 4,N is Num div 40000, N > 0))-> write(' cuarenta '), !;
    (X is 4) -> write(' cuarenta y '), !;
    ((X is 5,1 is Num / 50) ; (X is 5,N is Num div 50000, N > 0)) -> write(' cincuenta '), !;
    (X is 5) -> write(' cincuenta y '), !;
    ((X is 6,1 is Num / 60) ; (X is 6,N is Num div 60000, N > 0)) -> write(' sesenta '), !;
    (X is 6) -> write(' sesenta y '), !;
    ((X is 7,1 is Num / 70) ; (X is 7,N is Num div 70000, N > 0)) -> write(' setenta '), !;
    (X is 7) -> write(' setenta y '), !;
    ((X is 8, 1 is Num / 80) ; (X is 8,N is Num div 80000, N > 0)) -> write(' ochenta '), !;
    (X is 8) -> write(' ochenta y '), !;
    ((X is 9, 1 is Num / 90) ; (X is 9,N is Num div 90000, N > 0)) -> write(' noventa '), !;
    (X is 9) -> write(' noventa y '), ! ;
    ((X is 1,1 is Num / 10) ; (X is 8,N is Num div 10000, N > 0)) -> write(' diez '), !.
unidad(X,Num):-
    (X is 0) -> write(''), !;
    (X is 1,1 is Num / 11) -> write(''), !;
    (X is 1) -> write('uno '), !;
    (X is 2,1 is Num / 12) -> write(''), !;
    (X is 2) -> write('dos '), !;
    (X is 3,1 is Num / 13) -> write(''), !;
    (X is 3) -> write('tres '), !;
    (X is 4,1 is Num / 14) -> write(''), !;
    (X is 4) -> write('cuatro '), !;
    (X is 5,1 is Num / 15) -> write(''), !;
    (X is 5) -> write('cinco '), !;
    (X is 6) -> write('seis '), !;
    (X is 7) -> write('siete '), !;
    (X is 8) -> write('ocho '), !;
    (X is 9) -> write('nueve '), !.
