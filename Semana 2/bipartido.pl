/**********************************************************
    Programa:   bipartido.pl
    Funcion:    
**********************************************************/
:- use_module(library(lists)).

main:-
    write(': '), read(CLAVE), CLAVE>0, CLAVE=<99999,
    multiplica(CLAVE, 2, CLAVE),
    tiempo.

multiplica(CLAVE, CONT, NUM):-
    % Multiplicar el numero por un contador
    CLAVE2 is CLAVE*CONT,
    % El numero que resulte de la multiplicacion dividirlo en digitos
    LISTA = [],
    separar(CLAVE2, LISTA, CLAVE2, CONT, NUM).

separar(CLAVE, LISTA, CLAVEO, CONT, NUM):-
    % Empezar a separar los digitos
    D1 is CLAVE mod 10,
    % Concatenamos el digito a la lista 
    append([D1], LISTA, X),
    (CLAVE2 is CLAVE div 10, CLAVE2 \= 0) -> separar(CLAVE2, X, CLAVEO, CONT, NUM); D2 is CLAVE mod 10, verificar(LISTA, D2, CLAVEO, CONT, NUM).

verificar(LISTA, S, _, CONT, NUM):-
    % Unimos la lista
    append([S], LISTA, X),
    % Usamos el list_to_set para poner en una lista los digitos SIN repetir
    list_to_set(X, LISTA2),
    % Obtenemos la longitud de la lista
    longitud(LISTA2, LON),
    % Checamos la longitud de LISTA2
    (LON = 2) -> contar(S, X, M),
    % Sacar T y N
    ultimo(T, X), contar(T,X,N), 
    % Imprimir
    write(': '), write(M), write(' '), write(S), write(' '),
    write(N), write(' '), write(T);
    CONT2 is CONT+1, multiplica(NUM, CONT2, NUM).

longitud([], 0):-!.
longitud([ _ | Resto], X) :- 
    longitud(Resto,Y),
    X is Y+1.

contar(_,[],0).
contar(X,[X|L],C):- !,contar(X,L,C1), C is C1+1.
contar(X,[_|L],C):- contar(X,L,C).

ultimo(X, [X]).
ultimo(X, [_|L]):- ultimo(X,L).

tiempo:-
   _ is cputime.