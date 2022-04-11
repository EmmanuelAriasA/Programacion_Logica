/**********************************************************
                Programa:   Calendario.pl
                Funcion: Generar un calendario.
        Emmanuel Arias Aguilar
**********************************************************/

main :-
    write('Anio: '),read(Anio),nl,
    write('----------------------'),nl,
    formarCalendario(0,Anio), nl.

formarCalendario(12,_):- !.
formarCalendario(N,Anio):-
    X1 is N+1, sacarMes(X1),
    diainicial(0,X1,Anio,_,D),formatoDias(D,X1,Anio),nl,
    write('----------------------'),nl,
    formarCalendario(X1,Anio).

sacarMes(1) :- write(' Enero'),nl, !.
sacarMes(2) :- write(' Febrero'),nl, !.
sacarMes(3) :- write(' Marzo'),nl, !.
sacarMes(4) :- write(' Abril'),nl, !.
sacarMes(5) :- write(' Mayo'),nl, !.
sacarMes(6) :- write(' Junio'),nl, !.
sacarMes(7) :- write(' Julio'),nl, !.
sacarMes(8) :- write(' Agosto'),nl, !.
sacarMes(9) :- write(' Septiembre'),nl, !.
sacarMes(10) :- write(' Octubre'),nl, !.
sacarMes(11) :- write(' Noviembre'),nl, !.
sacarMes(12) :- write(' Diciembre'),nl, !.

/*-----------------------------------------------------------------------------------
                    Algoritmo para calcular dias x mes
------------------------------------------------------------------------------------*/

formatoDias(Salto,Mes, Anio) :-
    write('  D  L  M  M  J  V  S'), nl,
    saltoXdia(Salto),calcularDias(Mes,Anio,Salto).

calcularDias(Mes,A,Salto) :-
    (Mes is 1 ; Mes is 3; Mes is 5; Mes is 7 ; Mes is 8 ; Mes is 10 ; Mes is 12) -> diaXdia(0,31,Salto) ;
    (Mes is 4 ; Mes is 6; Mes is 9; Mes is 11) -> diaXdia(0, 30,Salto) ;
    (esBisiesto(A) , Mes is 2) -> diaXdia(0,29,Salto) ; diaXdia(0,28,Salto).

diaXdia(Max,Max,_):- !.
diaXdia(Cont,Max,Salto) :-
    Cont1 is Cont + 1, formato(Cont1),
    (6 is Salto -> nl, Salto1 is 0 ;  Salto1 is Salto + 1),
    diaXdia(Cont1,Max,Salto1).

formato(N) :-
    (N < 10) -> (write('  '),write(N)) ; (write(' '),write(N)).

saltoXdia(Salto) :-
    Salto is 0 -> write('');
    Salto is 1 -> write('   ');
    Salto is 2 -> write('      ');
    Salto is 3 -> write('         ');
    Salto is 4 -> write('            ');
    Salto is 5 -> write('               ');
    Salto is 6 -> write('                  ').
    
/*-----------------------------------------------------------------------------------
                    Algoritmo para calcular dia que inicia un año
------------------------------------------------------------------------------------*/
diainicial(N,M,A,K,D) :-
    calcularm(M,A,M1),
    constantes(A,K),
    Entre4 is A div 4,
    D is (N+M1+A+Entre4+K) mod 7.

constantes(A,K):-
    (A < 2000) -> K is 0 ;
    (A < 2100) -> K is 6 ;
    (A < 2200) -> K is 4 ;
    (A < 2300) -> K is 2 .

calcularm(Valor,Anio,M) :-
    esBisiesto(Anio) -> calcularmb(Valor,M) ;  calcularmnb(Valor,M).
calcularmb(Valor,M) :- 
    (Valor is 1) -> M is 6 ;
    (Valor is 2) -> M is 2 ;
    (Valor is 3) -> M is 3 ;
    (Valor is 4) -> M is 6 ;
    (Valor is 5) -> M is 1 ;
    (Valor is 6) -> M is 4 ;
    (Valor is 7) -> M is 6 ;
    (Valor is 8) -> M is 2 ;
    (Valor is 9) -> M is 5 ;
    (Valor is 10) -> M is 0 ;
    (Valor is 11) -> M is 3 ;
    (Valor is 12) -> M is 5 .
calcularmnb(Valor,M) :- 
    (Valor is 1) -> M is 0 ;
    (Valor is 2) -> M is 3 ;
    (Valor is 3) -> M is 3 ;
    (Valor is 4) -> M is 6 ;
    (Valor is 5) -> M is 1 ;
    (Valor is 6) -> M is 4 ;
    (Valor is 7) -> M is 6 ;
    (Valor is 8) -> M is 2 ;
    (Valor is 9) -> M is 5 ;
    (Valor is 10) -> M is 0 ;
    (Valor is 11) -> M is 3 ;
    (Valor is 12) -> M is 5 .

/*-----------------------------------------------------------------------------------
                    Algoritmo para calcular años bisiestos
------------------------------------------------------------------------------------*/

esBisiesto(Anio) :-
    R is Anio mod 400, R = 0, !.
esBisiesto(Anio) :-
    R is Anio mod 4, R = 0, !,
    R1 is Anio mod 100, R1 \= 0.