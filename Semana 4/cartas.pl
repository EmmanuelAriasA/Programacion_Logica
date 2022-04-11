/**********************************************************
Programa:   cartas.pl
Funcion:    Programa que generar una mano de 5 cartas 
            de la baraja inglesa e indica que juagada 
            o mano tradicional tienes

    Emmanuel Arias Aguilar
**********************************************************/

main :-
    crearJuego(Numeros, Palos),
    resMano(Numeros, Palos).
    
crearJuego(Numeros, Palos):-
    generar(5, NumerosD, Palos2),
    quick(NumerosD, Numeros2),
    Numeros = Numeros2,
    Palos = Palos2, 
    mostrarMano(Numeros, Palos).

mostrarMano(Numeros, Palos):-
    nl, write('Su mano es:'), nl,
    length(Numeros, C),
    mostrarMano2(Numeros, Palos, C).

mostrarMano2([],[],0):- !.
mostrarMano2([X | RestoN], [Y | RestoP], C):-
    C2 is C - 1, nombreCartas(X, Nombre),
    write('  '), write(Nombre), write(' de '), write(Y),
    mostrarMano2(RestoN, RestoP, C2).
    
nombreCartas(Num, Nombre):-
    (Num = 11)->
        Nombre = 'J'
    ;(Num = 12)->
        Nombre = 'Q'
    ;(Num = 13)->
        Nombre = 'K'
    ;Nombre is Num.

generar(0, [], []):- !.
generar(N, [X| RestoN], [Y| RestoP]) :-
    Z is random(52),
    X is ((Z mod 13) + 1),
    P is Z // 13,
    asigPalo(P,Y),
    N1 is N-1,
    generar(N1, RestoN, RestoP).

asigPalo(P,X) :-
    asigPalo2(P, ['Picas','Corazones','Diamantes','Treboles'], X).

asigPalo2(0,[X | _],X) :- !.
asigPalo2(P,[_ | Resto],X) :- 
    P1 is P-1, asigPalo2(P1, Resto, X).

quick([], []) :- !.
quick([X | Resto], Lista) :-
    particion(X, Resto, MenoresIg, Mayores),
    quick(MenoresIg, Aux1),
    quick(Mayores, Aux2),
    append(Aux1, [X | Aux2], Lista).

particion(_, [], [], []) :- !.
particion(X, [Y | Resto], [Y | Otros], Mayores) :-
    Y =< X, !,
    particion(X, Resto, Otros, Mayores).
particion(X, [Y | Resto], Menores, [Y | Otros]) :-
    particion(X, Resto, Menores, Otros).

resMano(Numeros, Palos) :-
    (escaleraColor(Numeros, Palos))->
        nl, write("Escalera de Color")
    ;(poker(Numeros))->
        nl, write("Poker")
    ;(fullHouse(Numeros))->
        nl, write("Full House")
    ;(color(Palos))->
        nl, write('Color')
    ;(escalera(Numeros))->
        nl, write('Escalera')
    ;(trio(Numeros))->
        nl, write('Trio')
    ;(doblePareja(Numeros))->
        nl, write('Doble Pareja')
    ;(pareja(Numeros))->
        nl, write('Pareja')
    ;nl, write('Carta Alta').

contar(_,[],0).
contar(X, [X|Resto], C):- 
    contar(X,Resto,C1), 
    C is C1+1.
contar(X,[_ |Resto],C):- 
    contar(X,Resto,C).

/********************************************************
        Algoritmos para generar Juego
*********************************************************/

escaleraColor(Numeros, Palos) :- 
    (color(Palos) , escalera(Numeros))->true;false.

poker(Numeros) :-
    list_to_set(Numeros, NumerosDis),
    length(NumerosDis, 2),
    nth0(0, NumerosDis,Aux1),
    nth0(1, NumerosDis,Aux2),
    contar(Aux1, Numeros, C1),
    contar(Aux2, Numeros, C2),
    ((C1 = 4, C2 = 1) ; (C1 = 1, C2 = 4))-> true;false.

fullHouse(Numeros) :-
    list_to_set(Numeros, NumerosDis),
    length(NumerosDis, 2),
    nth0(0, NumerosDis,Aux1),
    nth0(1, NumerosDis,Aux2),
    contar(Aux1, Numeros, C1),
    contar(Aux2, Numeros, C2),
    ((C1 = 3, C2 = 2) ; (C1 = 2, C2 = 3))-> true;false.

color(Palos) :-
    list_to_set(Palos, PalosDis),
    length(PalosDis,1).

escalera([X | Resto]) :-
    length(Resto, N),
    N2 is N+1,
    escalera2(N2, Resto, X).

escalera2(1, [], _) :- !.
escalera2(N, [X | Resto], NumAnt) :-
    Aux is NumAnt + 1,
    (X = Aux) ->
        N2 is N-1,
        escalera2(N2, Resto, X);false. 

trio(Numeros) :-
    list_to_set(Numeros, NumerosDis),
    length(NumerosDis, 3),
    nth0(0, NumerosDis,Aux1),
    nth0(1, NumerosDis,Aux2),
    nth0(2, NumerosDis,Aux3),
    contar(Aux1, Numeros, C1),
    contar(Aux2, Numeros, C2),
    contar(Aux3, Numeros, C3),
    (C1 = 3 ; C2 = 3 ; C3 = 3)-> true;false.

doblePareja(Numeros):-
    list_to_set(Numeros, NumerosDis),
    length(NumerosDis, 3),
    nth0(0, NumerosDis,Aux1),
    nth0(1, NumerosDis,Aux2),
    nth0(2, NumerosDis,Aux3),
    contar(Aux1, Numeros, C1),
    contar(Aux2, Numeros, C2),
    contar(Aux3, Numeros, C3),
    ((C1 = 2, C2 = 2, C3 = 1) ; (C1 = 2, C2 = 1, C3 = 2) ; (C1 = 1, C2 = 2, C3 = 2))-> true
    ;false.

pareja(Numeros):-
    list_to_set(Numeros, NumerosDis),
    length(NumerosDis, 4),
    nth0(0, NumerosDis,Aux1),
    nth0(1, NumerosDis,Aux2),
    nth0(2, NumerosDis,Aux3),
    nth0(3, NumerosDis,Aux4),
    contar(Aux1, Numeros, C1),
    contar(Aux2, Numeros, C2),
    contar(Aux3, Numeros, C3),
    contar(Aux4, Numeros, C4),
    (C1 = 2 ; C2 = 2 ; C3 = 2 ; C4 = 2)-> true;false.