/*******************************************************
    Programa:   NumRoma.pl
    Funcion:    Elabora un programa en Prolog que te 
                pida un valor de N, por ejemplo 20, y
                que genera N numeor al azar entre 1 y
                3999, imprime cada valor como número
                arábigo y numero romano. 

    Emmanuel Arias Aguilar
*******************************************************/

main :-
    write("Digitar Numero a convertir: "), read(N),
    generarRandom(0,N).


generarRandom(N,N):- !.
generarRandom(C,N):- 
    random_between(1, 3999, R),
    write(R), write(': '),
    converRoma(R,[1000,900,500,400,100,90,50,40,10,9,5,4,1],['M','CM','D','CD','C','XC','L','XL','X','IX','V','IV','I']),nl,
    C1 is C + 1,
    generarRandom(C1, N).


converRoma(0,_,_) :- !.
converRoma(N,[X | Resto1],[Y | Resto2]) :-
    N >= X,!,
    write(Y),
    N1 is N-X,
    converRoma(N1,[X | Resto1],[Y | Resto2]).
converRoma(N,[_ | Resto1],[_ | Resto2]) :-
    converRoma(N,Resto1,Resto2).
