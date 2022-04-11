/*******************************************************
    Programa:   polinomio.pl
    Funcion:    Programa para validar polinomios en X con
                coeficientes enteros.
                Polinomio: '20x7-13x12+x-71'.
                Bien escrito.
*******************************************************/

main:-
    signos(vomito),
    signos(dolorGenital),
    signos(verrugas),
    signos(pielAmarilla),
    signos(ardorEstomacal),
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/    

irritacion = ardor
    prueba(anginas,[dolorCabeza,dolorEstomago]),
    prueba(covid,[fiebre,tosSeca,cansancio]),
    prueba(infeccionEstomacal,[fiebre,nausea,dolorEstomago]),
    prueba(conjuntivitis,[ojoRojo,inflamacionParpados,irritacionOjo,lagrimeoConstante]),
    prueba(anemia,[cansancio,pielPalida,debilidad,dolorPecho]),
    prueba(gastritis,[dolorEstomago,ardorEstomacal,nausea,vomito]),
    prueba(diabetes,[cansancio,visionBorrosa,aumentoSed,enciasRojas,hormigueo]),
    prueba(influenza,[fiebre,escalofrios,tos,dolorGarganta,dolorMuscular,dolorCabeza,cansancio,congestionNasal]),
    prueba(leucemia,[cansancio,debilidad,pielPalida,formacionMoretones,perdidaPeso,fiebre,dolorHuesos,dificultadRespiratoria]),
    prueba(hepatitis,[cansancio,pielAmarilla, fiebre, nausea, vomito]),
    prueba(ets,[dolorGenital, verrugas, fiebre, dolorEstomago]),
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
    borrarDatos([tos,estornudos,fiebre,nausea,dolorCabeza,dolorEstomago,tosSeca,cansancio,debilidad,pielPalida,dolorPecho,visionBorrosa,enciasRojas,hormigueo,aumentoSed,escalofrios,dolorGarganta,dolorMuscular,congestionNasal,ojoRojo,inflamacionParpados,irritacionOjo,lagrimeoConstante,perdidaPeso,dolorHuesos,dificultadRespiratoria,formacionMoretones,indigestion,vomito,ardorEstomacal, dolorGenital, verrugas, pielAmarilla]).

signos(Sin) :-
    write('Presentas el siguiente sintoma:  '), write(Sin), write(' (s/n)? '),
    read(R),
    R = 's', !,
    assert(Sin).
signos(_).

prueba(Sin,Lista) :-
    resultado(Lista,R),
    write('Positivo a '), write(Sin), write('? '),
    write(R), nl.

resultado([Sin],verdadero) :- Sin, !.
resultado([Sin | Resto],R) :-
    Sin, !, resultado(Resto,R).
resultado(_,falso).

borrarDatos([]):-!.
borrarDatos([Sin|Resto]):-
    retractall(Sin),borrarDatos(Resto).