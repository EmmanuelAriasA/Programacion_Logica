% Programa: bipartite.pl
% Función: Encontrar un número bipartito que sea
%          múltiplo de un número n.
% Solución en prolog del problema 1051. 
% https://onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=245&page=show_problem&problem=3492

:- use_module(library(lists)).

main :- 
    read(NUM), NUM >= 1, NUM =< 99999,
    buscar_bipartito(NUM, NUM, 1, M, N, S, T),
    format('~d: ~d ~d ~d ~d', 
            [NUM, M, S, N, T]),
    nl.
    
buscar_bipartito(Base, NUM, Factor, M, N, S, T) :-
    lista_digitos(NUM, Digitos),
    digitos_unicos(Digitos, Unicos, Cant),
    es_bipartito(Digitos, Unicos, Cant, TM, TN, TS, TT) ->
    M is TM, N is TN, S is TS, T is TT; 
    (Factor1 is Factor + 1, NUM1 is Base*Factor1,
    buscar_bipartito(Base, NUM1, Factor1, M1, N1, S1, T1), 
    M is M1, N is N1, S is S1, T is T1). 

dividir(Indice, Izquierda, Derecha, Lista) :-
    length(Izquierda, Indice),
    append(Izquierda, Derecha, Lista).

contar_consecutivos(_, [], 0) :- !.
contar_consecutivos(D, [D1 | Digitos], Veces) :-
    D \= D1 -> Veces is 0 ;
    contar_consecutivos(D, Digitos, Veces1),
    Veces is Veces1 + 1.

es_bipartito(Digitos, [S,T|[]], Cant, M, N, S, T) :-
    S \= 0, Cant = 2, 
    nth0(Indice, Digitos, T),
    dividir(Indice, Izq, Der, Digitos),
    contar_consecutivos(S, Izq, M),
    contar_consecutivos(T, Der, N),
    Suma is M + N, length(Digitos, Total),
    Suma = Total.

digitos_unicos(Digitos, [S|T], Cant) :-
    list_to_set(Digitos, [S|T]), length([S|T], Cant).

lista_digitos(NUM, Digitos) :-
    NUM < 10 -> append([], [NUM], Digitos) ;
    (divmod(NUM, 10, NUM1, D),
    lista_digitos(NUM1, Digitos1),
    append(Digitos1, [D], Digitos)).