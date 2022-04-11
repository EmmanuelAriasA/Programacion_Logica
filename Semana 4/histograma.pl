/*****************************************************************
                    Emmanuel Arias Aguilar
*****************************************************************/

main :-
    write('Lista de enteros no negativos: '),
    read(Lista),
    write('Ancho: '), read(Ancho),
    write('Alto: '),read(Alto),

    write('Histograma Horizontal: '),nl,
    barrasEscala(Lista,Ancho,Alto),nl,
    write('Histograma Vertical: '),nl,
    barrasVertical(Lista,Ancho,Alto).

/********************************************************
            Algoritmo histograma horizontal
*********************************************************/
barras([]) :- !.
barras([X | Resto]) :-
    barra(X), barras(Resto).

barra(0) :- !, nl.
barra(N) :-
    write('*'),
    N1 is N-1,
    barra(N1).

barrasEscala([],_,_) :- !.
barrasEscala([X | Resto], Ancho, Alto) :-
    X1 is X*Alto,
    iteraBarra(X1, Ancho),
    barrasEscala(Resto,Ancho,Ancho).

iteraBarra(_,0):- !.
iteraBarra(X,Ancho) :-
    barra(X),
    Ancho1 is Ancho-1,
    iteraBarra(X, Ancho1).

/********************************************************
            Algoritmo histograma vertical
*********************************************************/
barrasVertical(Lista,Ancho,Alto):-
    max_member(Max,Lista),
    escalasBarra(Lista,Ancho,Alto,Max).

escalasBarra(_,_,_,0):- !.
escalasBarra(Lista,Ancho,Alto, Max):-
    iterarBarra(Lista, Ancho, Alto, Max),
    Max2 is Max-1,
    escalasBarra(Lista,Ancho,Alto,Max2).

iterarBarra(_, _, 0, _):- !.
iterarBarra(Lista, Ancho, N, Nivel):-
    nivel(Lista,Ancho,Nivel),
    N2 is N-1,
    iterarBarra(Lista,Ancho,N2,Nivel).

nivel([],_,_):- !, nl.
nivel([X | Resto], Ancho, Nivel):-
    (X >= Nivel)-> nivelBarra(Ancho,'*'),
    nivel(Resto, Ancho, Nivel);
    nivelBarra(Ancho,' '), nivel(Resto, Ancho,Nivel).

nivelBarra(0,_):- !, write(' ').
nivelBarra(N,Caracter):-
    write(Caracter),
    N1 is N-1,
    nivelBarra(N1,Caracter).