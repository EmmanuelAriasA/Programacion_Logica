{-
    Programa: configElec.hs
        Dado un numero obtener su configuracion electronica
    Alumno: Liliana Lissette Cruz González
-}

import Text.Printf

b = ["1s", "2s", "2p", "3s", "3p", "4s", "3d", "4p", "5s", "4d", "5p", 
    "6s", "4f", "5d", "6p", "7s", "5f", "6d", "7p", "6f", "7d", "7f"]
e = [2, 2, 6, 2, 6, 2, 10, 6, 2, 10, 6, 2, 14, 10, 6, 2, 14, 10, 6, 14, 10, 14]

main = do
    putStrLn "Numero: "
    n <- getLine
    let 
        num = read n :: Int
    putStr "Configuracion electronica = "
    configE num b e 
    putStrLn "" 

configE n (x : resto) (y : resto2)
    | n == 0 = do
        putStr ""
    | (n-y) <= 0 = do
        putStr $ x ++ (show n)
        putStr " "
    | otherwise = do
        putStr $ x ++ (show y)
        putStr " "
        configE (n-y) resto resto2