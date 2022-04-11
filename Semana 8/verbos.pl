/*******************************************************
    Programa:   verbos.pl
    Funcion:    Predicados para conjugacion de verbos
    ---------------------------------------------------
    Ejercicio:  Programa para conjugar verbos en presente,
                el programa va aprendiendo de verbos
                regulares e irregulares.
*******************************************************/

main:-
    write('Introduce un verbo: '), read(V),
    busquedaR(V).

busquedaR(V):-
    open('regulares.txt', read, Str),
    lec_verbo(V, Str, 0),
    close(Str).

lec_verbo(V, Str, Flag):-
    read(Str, [Verbo,Yo,Tu,El,Nos,Ust,Ell]), [Verbo,Yo,Tu,El,Nos,Ust,Ell] \= at_end_of_file, !,
    verifica(V, [Verbo,Yo,Tu,El,Nos,Ust,Ell], Str, Flag).
lec_verbo(V, _, Flag):- (Flag = 0) -> busquedaI(V); conjugar(V).

verifica(V,[Verbo,Yo,Tu,El,Nos,Ust,Ell], Str, Flag):-
    (V = Verbo) ->  texto(Flag), nl,
    formato([Verbo,Yo,Tu,El,Nos,Ust,Ell]), !; lec_verbo(V, Str, Flag).

busquedaI(V):-
    open('irregulares.txt', read, Str1),
    lec_verbo(V, Str1, 1),
    close(Str1).

texto(Flag):-
    (Flag = 0) -> write('-----------------regular-----------------');
    write('---------------irregular-----------------').

formato([Verbo,Yo,Tu,El,Nos,Ust,Ell]):-
    write('VERBO:   '), write(Verbo),nl,
    write('Yo:      '), write(Yo),nl,
    write('Tu:      '), write(Tu),nl,
    write('Ella/El: '), write(El),nl,
    write('Nosotros:'), write(Nos), nl,
    write('Ustedes: '), write(Ust),nl,
    write('Ellos:   '), write(Ell),nl,
    write('----------------------------'),nl.

conjugar(V):-
    write('Verbo conjugado\n'),
    write('----------------------------'),nl,
    string_chars(V, Lista),

    remover_ultimo(Lista, Aux),
    longitud(Aux, U),
    recorrer(U, Aux, Ter),

    remover_ultimo(Aux, Aux2),
    atom_chars(Cadena, Aux2),
    casos(V, Ter, Cadena).

casos(V, Ter, Cadena):-
    (Ter = 'a') -> terminacionAR(V, Cadena);
    (Ter = 'e') -> terminacionER(V, Cadena);
    (Ter = 'i') -> terminacionIR(V, Cadena).

terminacionAR(V, Cadena):-
    atom_concat(Cadena, 'o', Yo),
    atom_concat(Cadena, 'as', Tu),
    atom_concat(Cadena, 'a', El),
    atom_concat(Cadena, 'amos', Nos),
    atom_concat(Cadena, 'an', Ust),
    atom_concat(Cadena, 'an', Ell),
    formato([V,Yo,Tu,El,Nos,Ust,Ell]),
    pregunta([V,Yo,Tu,El,Nos,Ust,Ell]).

terminacionER(V, Cadena):-
    atom_concat(Cadena, 'o', Yo),
    atom_concat(Cadena, 'es', Tu),
    atom_concat(Cadena, 'e', El),
    atom_concat(Cadena, 'emos', Nos),
    atom_concat(Cadena, 'en', Ust),
    atom_concat(Cadena, 'en', Ell),
    formato([V,Yo,Tu,El,Nos,Ust,Ell]),
    pregunta([V,Yo,Tu,El,Nos,Ust,Ell]).

terminacionIR(V, Cadena):-
    atom_concat(Cadena, 'o', Yo),
    atom_concat(Cadena, 'es', Tu),
    atom_concat(Cadena, 'e', El),
    atom_concat(Cadena, 'imos', Nos),
    atom_concat(Cadena, 'en', Ust),
    atom_concat(Cadena, 'en', Ell),
    formato([V,Yo,Tu,El,Nos,Ust,Ell]),
    pregunta([V,Yo,Tu,El,Nos,Ust,Ell]).

pregunta([V,Yo,Tu,El,Nos,Ust,Ell]):-
    write('Se hizo bien la conjugación? '), read(R),
    R = 'y' -> escribirR([V,Yo,Tu,El,Nos,Ust,Ell]); 
    write('Introduce la conjugacion correcta: '), read(Conjugacion), escribirI(Conjugacion).

escribirR(Lista) :-
    open('regulares.txt', append, Str),
    nl(Str),
    write(Str, Lista), write(Str, '.'),
    close(Str).

escribirI(Conjugacion) :-
    open('irregulares.txt', append, Str),
    nl(Str),
    write(Str, Conjugacion), write(Str, '.'),
    close(Str).

longitud([], 0):-!.
longitud([ _ | Resto], X) :- 
    longitud(Resto,Y),
    X is Y+1.

recorrer(1, [X |_], X):- !.
recorrer(M, [_| Resto], X):-
    M1 is M-1, recorrer(M1, Resto, X).

remover_ultimo([_], []).
remover_ultimo([X|Xs], [X|Ultimo]) :- 
    remover_ultimo(Xs, Ultimo).