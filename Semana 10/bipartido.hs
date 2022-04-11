import Data.List
import Data.Maybe
import Data.Set (Set)
import Data.Set qualified as Set

main = do
  let y = digs 881

  let z = Set.fromList y
  let z1 = Set.elemAt 0 z
  let z2 = Set.elemAt 1 z

  let c1 = contar y z1
  let c2 = contar y z2

  if bipartido y
    then putStrLn (show z1 ++ " " ++ show z2 ++ " " ++ show c1 ++ " " ++ show c2)
    else print False

digs :: Integral x => x -> [x]
digs 0 = []
digs x = digs (x `div` 10) ++ [x `mod` 10]

removPrim :: [Int] -> Int -> [Int]
removPrim [] _ = []
removPrim (y : resto) x
  | y == x = removPrim resto x
  | otherwise = y : resto

bipartido :: [Int] -> Bool
bipartido y = do
  let z = Set.fromList y
  let lz = length z
  let y1 = head y
  let ys = removPrim y y1
  let l2i = fromMaybe (-1) $ elemIndex y1 ys

  lz == 2 && l2i == -1

contar :: Eq a => [a] -> a -> Int
contar [] buscar = 0
contar (x : xs) buscar
  | buscar == x = 1 + contar xs buscar
  | otherwise = contar xs buscar