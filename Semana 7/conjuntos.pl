/*******************************************************
    Programa: conjuntos.pl
    Funcion: Validar enteros sin signo

    <enteroSin> ::= <digito> | 
                    <digito><enteroSin>
    ----------------------------------------------
    Lenguaje: Conjunto de letras minusculas
    Ejemplo: {a, b, c, b, a} -> {a, b, c}
    <conjunto> ::= '{<listaLetras>}'
    <listaLetras> ::= nula | <listaNoVacia>
    <listaNoVacia> ::= <letra> |
                       <letra>,<listaNoVacia>
    <letra> ::= a | b | c | ... | z

    Ejercicio: Ingresa dos conjuntos validados,
    simplificarlos, y calcula union, intersección,
    diferencias, complementos.

    Emmanuel Arias Aguilar
*******************************************************/

main :- 
    write('Conjunto A|: '), read(A),
    conjunto(A), extraer(A, 1, ListaA),
    write('Conjunto B'), read(B),nl,
    conjunto(B), extraer(B, 1, ListaB),
    operaciones(ListaA, ListaB).

operaciones(Lista1, Lista2):-
    write('A simplificardo: '), simplificar(Lista1, S1), write(S1), nl,
    write('B simplificardo: '), simplificar(Lista2, S2), write(S2), nl,
    write('A union B: '), union(Lista1, Lista2, U), write(U), nl,
    write('A interseccion B:'), interseccion(Lista1, Lista2,1,I), write(I), nl,
    complemento(Lista1,1,CompA), complemento(Lista2,1,CompB),
    write('A - B: '), interseccion(Lista1,CompB,1,AmenosB), write(AmenosB), nl,
    write('B - A: '), interseccion(CompA,Lista2,1,BmenosA), write(BmenosA), nl,
    write('A\': '), write(CompA),nl,
    write('B\':'), write(CompB).
    
conjunto(Conjunto):-
    string_chars(Conjunto, Lista1),
    revisaConjunto(Lista1, _).
    
/*******************************************************
                        Automata
********************************************************/
revisaConjunto([], 2):- !.
revisaConjunto(['{' | Resto],0):-
    !, revisaConjunto(Resto, 1).
revisaConjunto(['}' | Resto],1):-
    !, revisaConjunto(Resto,2).
revisaConjunto([X | Resto],1):-
    letra(X),!,
    revisaConjunto(Resto,3).
revisaConjunto(['}' | Resto],3):-
    !, revisaConjunto(Resto,2).
revisaConjunto([',' | Resto],3):-
    !, revisaConjunto(Resto,4).
revisaConjunto([X|Resto], 4):-
    letra(X), !,
    revisaConjunto(Resto,3).

letra(X) :-
    char_code(X, Y), Y >= 97, Y =< 122.

extraer(_, I, []):- I>26,!.
extraer(A,I,[X|Resto]):-
    Cod is 96+I,
    char_code(X,Cod),
    string_chars(A,ConjA),
    pertenece(X,ConjA),!,
    I1 is I+1,
    extraer(A,I1,Resto).
extraer(A,I,Lista):-
    I1 is I+1,
    extraer(A,I1,Lista).

simplificar(Lista, R):-
    list_to_set(Lista, S),
    quick(S,R).

union(Lista1, Lista2, U):-
    concatenar(Lista1, Lista2, C),
    simplificar(C, U).

interseccion(_,_,27,[]):-!.
interseccion(A,B,I,[X| Resto]):-
    Y is 96+I,
    char_code(X,Y),
    pertenece(X,A),pertenece(X,B), !,
    I1 is I+1,
    interseccion(A,B,I1,Resto).
interseccion(A,B,I,Lista):-
    I1 is I+1,
    interseccion(A,B,I1,Lista).

complemento(_,27,[]):-!.
complemento(A,I,[X| Resto]):-
    Y is 96+I,
    char_code(X,Y),
    not(pertenece(X,A)),!,
    I1 is I+1,
    complemento(A,I1,Resto).
complemento(A,I,Lista):-
    I1 is I+1,
    complemento(A,I1,Lista).

quick([], []):-!.
quick([X | Resto], Lista):-
    particion(X,Resto,MenoresIg,Mayores),
    quick(MenoresIg,Aux1),
    quick(Mayores,Aux2),
    append(Aux1,[X|Aux2], Lista).

particion(_, [], [], []):-!.
particion(X, [Y| Resto], [Y|Otros], Mayores):-
    char_code(Y, Z),
    char_code(X, Z1),
    Z =< Z1, !,
    particion(X,Resto,Otros,Mayores).
particion(X, [Y| Resto], Menores, [Y|Otros]):-
    particion(X,Resto,Menores,Otros).

concatenar([], Lista, Lista):-!.
concatenar([X | Resto], Lista, [X| Otra]):-
    concatenar(Resto, Lista, Otra).

pertenece(X,[X|_]):-!.
pertenece(X,[_| Resto]):-pertenece(X,Resto).