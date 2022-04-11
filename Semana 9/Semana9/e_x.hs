{-----------------------------------------------------------------------
    Programa: e_x.hs
    Funcion: Calcular e a la x con serie de Taylor

    e^x = 1 + x + x^2/2! + x^3/3! + ... + x^12/12!

    Emmanuel Arias Aguilar
------------------------------------------------------------------------}
import System.Environment
import Data.Char

main :: IO ()
main = do 
    putStr "X : "
    entrada <- getLine 
    let 
        x = read entrada :: Double 
        ex = 1 + x + opera 2 x + opera 3 x + opera 4  x + opera 5 x + opera 6 x + opera 7 x + opera 8 x + opera 9 x + opera 10 x + opera 11 x + opera 12 x :: Double
    putStrLn "resultado: "
    putStrLn (show ex)

opera :: (Floating a, Eq a) => a -> a -> a
opera n x = ((x ** n) / (factorial n))

factorial :: (Eq t, Num t) => t -> t
factorial 0 = 1
factorial n = n * (factorial (n -1))