{------------------------------------------------------------------
    Programa:   factoresPrimos.hs
    Funcion:    Dado n entero mayor a 1, determinar sus factores
                primos

    Teorema fundamental de la aritmetica: Todo entero mayor a 1
    puede expresarse como producto de numeros primos

    100 = 2X2X5X5
    128 = 2^7
    29 = 29

    Emmanuel Arias Aguilar
------------------------------------------------------------------}

main = do
    putStrLn "n: "
    entrada <- getLine 
    let
        n = read entrada :: Int
        r = esPrimo n
    validarPrimo r n

esPrimo n = (length [x | x <- [1..n], mod n x == 0]) == 2

validarPrimo True n = putStrLn $ "Factores primos: 1x" ++ (show n)
validarPrimo False n = busquedaFactores n 2

busquedaFactores n factor 
    | n >= factor = do
        condicion n factor
    | otherwise = do
        putStrLn $ "1"

condicion n factor
    | mod n factor == 0 = do 
        putStr $ "" ++ (show factor) ++ " x "
        busquedaFactores (n `div` factor) factor
    | otherwise = do
        busquedaFactores n (factor + 1)