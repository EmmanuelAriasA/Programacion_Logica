/**************************************************************
        Programa: segundos.pl
        Funcion: Leer segundos desde 1970.01.01
                 en Greenwich
        -------------------------------------------------------
        Tarea: A partir del numero de segundos, realiza las 
        operaciones para recuperar fecha y hora

        DIA
            86400 s
        SEMANA
            604800 s

        MES 
        28  2419200 s
        29  2505600 s
        30  2592000 s
        31  2678400 s
        AÑO
        NORMAL = 31536000 s 365 dias
        BISIESTO = 31622400 s 366 dias

        
***************************************************************/

main :-
    get_time(X),
    Y is truncate(X),
    write('Segundos desde 1970.01.01 en GW: '),
    write(Y), nl,
    stamp_date_time(X, FechaHora, 21600),
    write(FechaHora), nl,
    write('Fecha: '),fecha(Y),
    write('Hora: '), hora(Y), nl.

fecha(X):-
        YEAR is (X // 31536000), write(YEAR),nl,
        BISIESTO is (YEAR // 4), write(BISIESTO), nl,
        NO_BISIESTO is YEAR - BISIESTO.

hora(X):-
    RES is X mod 86400,
    HOURS is (RES // 3600) - 6,
    MINUTES is truncate((RES mod 3600) div 60),
    SECONDS is truncate((RES mod 3600) mod 60),

    write(HOURS), write(':'), write(MINUTES), write(':'),
    write(SECONDS), write('.').
