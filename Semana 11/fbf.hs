main = do
    putStrLn "Expresion a evaluar: "
    expreEval <- getLine
    if ( evalarExpre expreEval 0 (length expreEval - 1) ) then do
            putStrLn "Es una FBF"
        else putStrLn "No es una FBF"

esVariable expreEval = and [ expreEval >= 'a', expreEval <= 'z' ]
esOperador :: Char -> Bool
esOperador expreEval = or [ expreEval == '*', expreEval == '/', expreEval == '+', expreEval == '-' ]
evalarExpre expre a b
    | a == b = esVariable (expre !! a)
    | a > b = False
    | (expre !! (a+1) ) == '-' = and [
        (expre !! a) == '(',
        (expre !! b) == ')',
        evalarExpre expre (a+2) (b-1)
    ]
    |otherwise = and [
        (expre !! a) == '(',
        (expre !! b) == ')',
        (posOp expre ( a + 1 ) ( b - 1 ) 0 ) /= -1,
        evalarExpre expre ( a + 1 ) ( (posOp expre ( a + 1 ) ( b - 1 ) 0 ) - 1),
        evalarExpre expre ( (posOp expre ( a + 1 ) ( b - 1 ) 0) + 1 ) ( b - 1 )
    ]
posOp expre inf sup prof
    | or [inf > sup, prof < 0] = -1
    | and [esOperador (expre !! inf), prof == 0] = inf
    | ( expre !! inf ) == '(' = posOp expre ( inf + 1 ) sup ( prof + 1 )
    | ( expre !! inf ) == ')' = posOp expre ( inf + 1 ) sup ( prof - 1 )
    | otherwise = posOp expre ( inf + 1 ) sup prof