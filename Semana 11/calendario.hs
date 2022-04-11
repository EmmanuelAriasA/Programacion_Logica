nomMes = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"] :: [String]
semana =["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"] :: [String]
meses  =[31,28,31,30,31,30,31,31,30,31,30,31] ::[Int]
mesesB =[31,29,31,30,31,30,31,31,30,31,30,31] ::[Int]

main = do
    putStr $ "Digitar el Año: "
    a <- getLine
    putStr $ "Dia de inicio (1-7): "
    d <- getLine
    let
        year = read a ::Int
        dia = read d ::Int
    if (valBiciesto year && (dia>=7 || dia<=1))
        then do
            imprime mesesB dia nomMes
         else do
             imprime meses dia nomMes

valBiciesto n=((mod n 400)==0)

imprime [] _ _=do
    putStrLn ""
imprime (x:resto) dia (y:resto2)= do
    let
        division = mod x 4        ::Int
        compara  = division + dia ::Int
    putStrLn $ y
    putStrLn $ "Dom Lun Mar Mie Jue Vie Sab"
    estructura dia
    imprime2 x 1 dia
    putStrLn $ ""
    if(compara > 7)
        then do
            let
                dia2 = compara-7 :: Int
            imprime resto dia2 resto2
        else if(compara < 7)
            then do
                imprime resto compara resto2
        else if(compara == 7)
            then do
                imprime resto 7 resto2
        else do
            putStr ""

imprime2 mes cont dia = do
    if(cont <= mes && dia<=6)
        then do
            acomoda cont
            imprime2 mes (cont+1) (dia+1)
        else if(cont <= mes)
            then do
                acomoda cont
                putStrLn $ ""
                imprime2 mes (cont+1) 1
        else do
            putStrLn $ ""

acomoda n =do
    if(n >= 10)
        then do
            putStr $ (show n)++"  "
        else do
            putStr $ (show n)++"   "

estructura lim =do
    if(lim == 1)
        then do
            putStr ""
    else if(lim == 2)
        then do
            putStr "    "
    else if(lim == 3)
        then do
            putStr "        "
    else if(lim == 4)
        then do
            putStr "            "
    else if(lim == 5)
        then do
            putStr "                "
    else if(lim == 6)
        then do
            putStr "                    "
        else do
            putStr "                        "
