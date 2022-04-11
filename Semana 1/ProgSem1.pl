/**************************************************************
        Programa: segundos.pl
        Funcion: Leer segundos desde 1970.01.01
                 en Greenwich
        -------------------------------------------------------
        Tarea: A partir del numero de segundos, realiza las 
        operaciones para recuperar fecha y hora (Da la hora de Greenwich)

        Alumno: Emmanuel Arias Aguilar
***************************************************************/

main :-
    get_time(X),
    Y is truncate(X),
    write('Segundos desde 1970.01.01 en GW: '),
    write(Y),
    seg(Y,MINUTOS,SEG_REST),
    min(MINUTOS,HORAS,MIN_REST),
    hrs(HORAS,Dias,HRS_REST), nl,
    write('Fecha: '), dias(Dias,Years,_,1970), write('/'),
    write(Years), nl,
    write('Hora: '), write(HRS_REST),
    write(':'), write(MIN_REST),
    write(':'), write(SEG_REST).

/*-----------------------------------------------------------------------------------------*/   
seg(SEG,MIN,SEGUNDOSR):-

    MIN is SEG div 60,
    SEGUNDOSR is SEG mod 60.

min(MIN,HORAS,MIN_REST):-
    HORAS is MIN div 60,
    MIN_REST is MIN mod 60.

hrs(HORAS,DIAS,HORASR):-
    DIAS is HORAS div 24,
    HORASR is HORAS mod 24.   

dias(DIAS,YEARS,DIASR,ANIO_ACTUAL) :-
    ((A is ANIO_ACTUAL mod 4, A = 0),DIAS >= 366) -> DIAS2 is DIAS - 366, ANIO_ACTUAL2 is ANIO_ACTUAL + 1,
    dias(DIAS2,YEARS2,DIASR2,ANIO_ACTUAL2), YEARS is YEARS2 + 1,DIASR is DIASR2 + 1;

    ((A is ANIO_ACTUAL mod 4, A \= 0),DIAS >= 365) -> DIAS2 is DIAS - 365, ANIO_ACTUAL2 is ANIO_ACTUAL + 1,dias(DIAS2,YEARS2,DIASR2,ANIO_ACTUAL2), YEARS is YEARS2 + 1,DIASR is DIASR2 + 1;

    DIAS3 is DIAS + 1,
    YEARS is 1970, DIASR is DIAS, 
    mes(DIAS3, ANIO_ACTUAL).

mes(DIAS, ANIO_ACTUAL) :-
     % enero
    ((DIAS < 32) -> write(DIAS), write('/Enero'));
    % febrero
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<61) -> DIAS2 is DIAS - 31, write(DIAS2), write('/Febrero'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<60) -> DIAS2 is DIAS - 31, write(DIAS2), write('/Febrero'));
    % marzo 
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<92) -> DIAS2 is DIAS - 60, write(DIAS2), write('/Marzo'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<91) -> DIAS2 is DIAS - 59, write(DIAS2), write('/Marzo'));
    %abril
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<122) -> DIAS2 is DIAS - 91, write(DIAS2), write('/Abril'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<121) -> DIAS2 is DIAS - 90, write(DIAS2), write('/Abril'));
    %mayo
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<153) -> DIAS2 is DIAS - 121, write(DIAS2), write('/Mayo'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<152) -> DIAS2 is DIAS - 120, write(DIAS2), write('/Mayo'));
    %junio
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<183) -> DIAS2 is DIAS - 152, write(DIAS2), write('/Junio'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<182) -> DIAS2 is DIAS - 151, write(DIAS2), write('/Junio'));
    %julio
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<214) -> DIAS2 is DIAS - 182, write(DIAS2), write('/Julio'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<213) -> DIAS2 is DIAS - 181, write(DIAS2), write('/Julio'));
    %agosto
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<245) -> DIAS2 is DIAS - 213, write(DIAS2), write('/Agosto'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<244) -> DIAS2 is DIAS - 212, write(DIAS2), write('/Agosto'));
    %septiembre
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<275) -> DIAS2 is DIAS - 244, write(DIAS2), write('/Septiembre'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<274) -> DIAS2 is DIAS - 243, write(DIAS2), write('/Septiembre'));
    %octubre
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<306) -> DIAS2 is DIAS - 274, write(DIAS2), write('/Octubre'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<305) -> DIAS2 is DIAS - 273, write(DIAS2), write('/Octubre'));
    %noviembre
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<336) -> DIAS2 is DIAS - 305, write(DIAS2), write('/Noviembre'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<335) -> DIAS2 is DIAS - 304, write(DIAS2), write('/Noviembre'));
    %diciembre
    (((A is ANIO_ACTUAL mod 4, A = 0),DIAS<367) -> DIAS2 is DIAS - 335, write(DIAS2), write('/Diciembre'));
    (((A is ANIO_ACTUAL mod 4, A \= 0),DIAS<366) -> DIAS2 is DIAS - 334, write(DIAS2), write('/Diciembre')).
/*------------------------------------------------------------------------------*/    
