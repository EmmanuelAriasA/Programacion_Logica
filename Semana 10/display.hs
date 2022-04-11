--AUTOR: URIEL BACILIO SANCHEZ
--PROGRAMA: Programa que simula una pantalla

import Text.Printf

d1 = [1,0,1,1,0,1,1,1,1,1]
d2 = [1,0,0,0,1,1,1,0,1,1]
d3 = [1,1,1,1,1,0,0,1,1,1]
d4 = [0,0,1,1,1,1,1,0,1,1]
d5 = [1,0,1,0,0,0,1,0,1,0]
d6 = [1,1,0,1,1,1,1,1,1,1]
d7 = [1,0,1,1,0,1,1,0,1,1]

main = do
    putStrLn "Digita un numero: "
    numImp <- getLine
    putStrLn "Proporcion: "
    proporci <- getLine
    let
        n = read numImp :: Int
        e = read proporci :: Int
    impHoriz n e d1
    putStrLn ""
    itera n e d2 d3 1
    impHoriz n e d4
    putStrLn ""
    itera n e d5 d6 1
    impHoriz n e d7

impHoriz n e lista = do
    let
        dig = mod n 10
        n1 = div n 10
    if (n1 /= 0)
        then do
            impHoriz n1 e lista
            putStr " "
            imprimirH e dig lista
            putStr "  "
    else  do
        putStr " "
        imprimirH e n lista
        putStr "  "

imprimirH 0 _ _ = do
    putStr ""
imprimirH e n (x : resto)
    | (n==0) && (x==0) = do
        putStr " "
        imprimirH (e-1) 0 (x : resto)
    | (n==0) && (x==1) = do
        putStr "-"
        imprimirH (e-1) 0 (x : resto)
    | otherwise = do
        imprimirH e (n-1) resto

itera n e lista1 lista2 cont
    | cont > e = do
        putStr ""
    | otherwise = do
        impVert n lista1 lista2 e
        putStrLn ""
        itera n e lista1 lista2 (cont+1)

impVert n lista1 lista2 e = do
    let
        dig = mod n 10
        n1 = div n 10
    if (n1 /= 0)
        then do
            impVert n1 lista1 lista2 e
            imprimirV dig lista1
            imprimirH e 0 [0]
            imprimirV dig lista2
            putStr " "
    else do
        imprimirV n lista1
        imprimirH e 0 [0]
        imprimirV n lista2
        putStr " "


imprimirV n (x : resto)
    | (n==0) && (x==0) = do
        putStr " "
    | (n==0) && (x==1) = do
        putStr "/"
    | otherwise = do
        imprimirV (n-1) resto
