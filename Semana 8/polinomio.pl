/*******************************************************
    Programa:   polinomio.pl
    Funcion:    Programa para validar polinomios en X con
                coeficientes enteros.
                Polinomio: '20x7-13x12+x-71'.
                Bien escrito.
*******************************************************/

main:-
    write('Ingresa el polinomio: '), read(P),
    polinomio(P).

polinomio(P):-
    string_chars(P, Lista),
    revisaPolinomio(Lista, _),
    write('todo bien').

% Automata
revisaPolinomio([], 2):-!.
revisaPolinomio([], 3):-!.
revisaPolinomio(['-'| Resto], 0):-
    !, revisaPolinomio(Resto,1).
revisaPolinomio(['x'|Resto], 1):-
    !, revisaPolinomio(Resto,3).
revisaPolinomio([X|Resto],1):-
    esDigito(X), !,
    revisaPolinomio(Resto,2).
revisaPolinomio([X | Resto], 0):-
    esDigito(X), !,
    revisaPolinomio(Resto,2).
revisaPolinomio([X | Resto], 2):-
    esDigito(X), !,
    revisaPolinomio(Resto,2).
revisaPolinomio(['x' | Resto], 2):-
    !, revisaPolinomio(Resto,3).
revisaPolinomio(['+' | Resto],2):-
    !, revisaPolinomio(Resto,4).
revisaPolinomio(['-' | Resto],2):-
    !, revisaPolinomio(Resto,4).
revisaPolinomio(['-'| Resto], 3):-
    !, revisaPolinomio(Resto,1).
revisaPolinomio([X|Resto], 3):-
    esDigito(X), !,
    revisaPolinomio(Resto,2).
revisaPolinomio(['+',Resto], 3):-
    !, revisaPolinomio(Resto,4).
revisaPolinomio([X|Resto],4):-
    esDigito(X), !,
    revisaPolinomio(Resto,2).
revisaPolinomio(['x'|Resto],4):-
    !, revisaPolinomio(Resto,3).

esDigito(X):-
    char_code(X,Y), Y >= 48, Y =< 57.