import Text.Printf

main = do
  putStr $ "x\t"
  imprimirColumna 0 0.09

imprimirColumna :: Float -> Float -> IO ()
imprimirColumna i f = do
  if i < f
    then do
      putStr $ (printf "%1.2f" i) ++ "\t"
      imprimirColumna (i + 0.01) f
    else do
      putStr $ "\n0.0\t"
      tablaCompleta 0 0 0.01 4 1000 0

tablaCompleta a b i t n cont
  | b == t = do
      putStr $ ""
  | otherwise = do
      let base = (b - a) / n
          resultado = suma a base 0 n
      putStr $ (printf "%1.4f" resultado) ++ "\t"
      condicion a b i t n cont

condicion a b i t n cont
  | (cont + i) <= 0.09 = do
      tablaCompleta a (b + i) i t n (cont + i)
  | otherwise = do
      putStr $ "\n"
      let r = round2dp (b + 0.01)
      putStr $ (show r) ++ "\t"
      tablaCompleta a r i t n 0

suma a b i n
  | i == n = 0
  | otherwise = area
  where
    area = b * y + area1
    area1 = suma a b (i + 1) n
    y = (y1 + y2) / 2
    y1 = f x1
    y2 = f x2
    x2 = x1 + b
    x1 = a + i * b

f x = (exp (-x * x / 2)) / (sqrt (2 * pi))

round2dp :: Double -> Double
round2dp x = fromIntegral (round $ x * 1e2) / 1e2