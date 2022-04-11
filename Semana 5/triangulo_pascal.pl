/*******************************************************
    Programa:   triangulo_pascal.pl
    Funcion 1: Triangulo de pascal con listas
    Funcion 2: Triangulo de Pascal con combinaciones
                C(n,r) = n! / r! / (n-r)!
    Funcion 3: Imprimir el triangulo de pascal de la
                forma siguiente: valor impar = *,
                valor par = espacio
    Funcion 4: Imprimir el triangulo de Sierpinski
                usando automatas celulares.

    Emmanuel Arias Aguilar
*******************************************************/

main:-
    write('Numero de iteracion '), read(Iteracion), nl,
    write('Funcion 1: '), nl,
    imprimir(1,Iteracion),
    write('---------------------------------------------------------'),nl,
    write('Funcion 2: '), nl,
    imprimir2(1,Iteracion),
    write('---------------------------------------------------------'),nl,
    write('Funcion 3: '), nl,
    imprimir3(1, Iteracion),
    write('---------------------------------------------------------'),nl,
    write('Funcion 4: '), nl,
    Inicio = [1,0,0,0,0,0,0,0,0], formato(Inicio), nl, longitud(Inicio, L),
    imprimir4(2, Iteracion,Inicio, L).

/****************************************************************
                 Triangulo de pascal con listas
****************************************************************/

imprimir(Cont,R):- Cont > R, !.
imprimir(Cont, R):-
    lista_P(Cont,Ren), write(Ren), nl,
    Cont1 is Cont+1,
    imprimir(Cont1, R).
    
sumar([X,Y],[Z]) :- Z is X + Y.
sumar([X,Y|L], Z):- 
    H is X + Y,
    sumar([Y|L],L2),
    Z = [H|L2].

lista_P(1,[1]) :- ! .
lista_P(2,[1,1]) :- !.
lista_P(N, L) :- 
    Ant is N - 1,
    lista_P(Ant,L2),
    sumar(L2,R),
    append([1|R],[1],L), !.

/**************************************************************
            Triangulo de Pascal con combinaciones: 
            C(n,r) = n! / r! / (n-r)!
**************************************************************/

imprimir2(Cont, R):- Cont > R, !.
imprimir2(Cont, R):-
    N is Cont-1,
    combinaciones(Cont,N,0),nl,
    Cont1 is Cont+1,
    imprimir2(Cont1, R).

combinaciones(Cont,_,Cont):- !.
combinaciones(Cont,N,R):-
    calcular(N,R),
    R1 is R+1, N1 is Cont-1,
    combinaciones(Cont,N1,R1).

calcular(N,R):-
    factorial(N, Num),
    factorial(R, Den1),
    Aux is N-R,
    factorial(Aux, Den2),
    Den is Den1*Den2,
    Result is Num/Den,
    write(Result), write(' ').

factorial(0, 1) :- !.
factorial(N, F) :-
    N1 is N-1,
    factorial(N1,F1),
    F is N*F1.

/*************************************************************************
                Imprimir el triangulo de pascal de la
                forma siguiente: valor impar = *,
                valor par = espacio
*************************************************************************/

imprimir3(Cont, R):- Cont > R, !.
imprimir3(Cont, R):-
    N is Cont-1,
    combinaciones2(Cont,N,0),nl,
    Cont1 is Cont+1,
    imprimir3(Cont1, R).

combinaciones2(Cont,_,Cont):- !.
combinaciones2(Cont,N,R):-
    calcular2(N,R),
    R1 is R+1, N1 is Cont-1,
    combinaciones2(Cont,N1,R1).

calcular2(N,R):-
    factorial(N, Num),
    factorial(R, Den1),
    Aux is N-R,
    factorial(Aux, Den2),
    Den is Den1*Den2,
    Result is Num/Den,
    Rest is Result mod 2,
    (Rest = 0) -> write(' '); write('*').

/*************************************************************************
                Imprimir el triangulo de Sierpinski
                usando automatas celulares.
*************************************************************************/

imprimir4(Cont, R, _, _):- Cont > R, !.
imprimir4(Cont, R, Inicio, L):-
    append([1], [], Lista),
    automata(Inicio,L,1,Lista,Cont,R).

automata(_, L,Cont,Result,ContP,R):- Cont >= L, inversa(Result, Otro), obtenerL(Otro, ContP, R, L), !.
automata(Inicio,L,Cont,Lista,ContP,R):-
    recorrer(Cont, Inicio, V1),
    Aux is Cont+1,
    recorrer(Aux, Inicio, V2),
    operacion(V1,V2,Lista,Result),
    Cont1 is Cont+1,
    automata(Inicio,L,Cont1,Result,ContP,R).

obtenerL(Lista, Cont, R, L):- 
    formato(Lista), nl,
    Cont1 is Cont+1,
    imprimir4(Cont1, R, Lista, L).

formato([]):-!.
formato([X|Resto]):-
    formato(X),
    formato(Resto).

formato(X):-
    (X = 0) -> write(' '); write('*').

longitud([], 0):-!.
longitud([ _ | Resto], X) :- 
    longitud(Resto,Y),
    X is Y+1.

recorrer(1, [X |_], X):- !.
recorrer(M, [_| Resto], X):-
    M1 is M-1, recorrer(M1, Resto, X).

inversa([],[]) :- !.
inversa([X | Resto], Lista) :-
    inversa(Resto, Otra),
    concatenar(Otra,[X],Lista).

concatenar([],Lista,Lista) :- !.
concatenar([X | Resto],Lista,[X | Otra]) :-
    concatenar(Resto,Lista,Otra).

operacion(V1,V2,Lista,R):-
    ((V1 = 0, V2 = 0) -> append([0], Lista, R));
    ((V1 = 0, V2 = 1) -> append([1], Lista, R));
    ((V1 = 1, V2 = 0) -> append([1], Lista, R));
    ((V1 = 1, V2 = 1) -> append([0], Lista, R)).