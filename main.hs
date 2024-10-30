--
-- EPITECH PROJECT, 2021
-- B-FUN-300-PAR-3-1-pushswapchecker-francois.zhao
-- File description:
-- main
--

import System.Environment
import System.Exit

swap :: [a] -> [a]
swap [] = []
swap (x:y:xs) = y:x:xs
              
putFirst :: [a] -> [a] -> [a]
putFirst [] _ = []
putFirst (x:xs) list2 = x:list2

rmFirst :: [a] -> [a]
rmFirst [] = []
rmFirst (x:xs) = xs

rotateLeft :: [a] -> [a]
rotateLeft [] = []
rotateLeft (x:xs) = xs ++ [x]

rotateRight :: [a] -> [a]
rotateRight [] = []
rotateRight list = last list : take (length list - 1) list

isSorted :: Ord a => [a] -> [a] -> Bool
isSorted [] [] = True
isSorted [x] [] = True
isSorted (x:y:xs) list2 = x <= y && isSorted (y:xs) list2 && null list2

pushswapChecker2 :: [String] -> [String] -> [String] -> Bool
pushswapChecker2 str@(x:xs) list1 list2 = case x of
    "ra" -> pushswapChecker xs (rotateLeft list1) list2 
    "rb" -> pushswapChecker xs list1 (rotateLeft list2) 
    "rr" -> pushswapChecker xs (rotateLeft list1) (rotateLeft list2)
    "rra" -> pushswapChecker xs (rotateRight list1) list2 
    "rrb" -> pushswapChecker xs list1 (rotateRight list2) 
    "rrr" -> pushswapChecker xs (rotateRight list1) (rotateRight list2)

pushswapChecker :: [String] -> [String] -> [String] -> Bool
pushswapChecker [] [] [] = False
pushswapChecker [] [] _ = False
pushswapChecker [] list1 [] = isSorted list1 []
pushswapChecker _ [] [] = False
pushswapChecker [] _ _ = False
pushswapChecker _ [] _ = False
pushswapChecker str@(x:xs) list1 list2 = case x of
    "sa" -> pushswapChecker xs (swap list1) list2
    "sb" -> pushswapChecker xs list1 (swap list2)
    "sc" -> pushswapChecker xs (swap list1) (swap list2)
    "pa" -> pushswapChecker xs (putFirst list2 list1) (rmFirst list2)
    "pb" -> pushswapChecker xs (rmFirst list1) (putFirst list1 list2)
    _ -> pushswapChecker2 str list1 list2

splitBy :: Char -> String -> [String]
splitBy del "" = [];
splitBy del string = foldr f [""] string
  where f :: Char -> [String] -> [String]
        f char str@(x:xs)
          | char == del = "":str
          | otherwise = (char:x):xs

printKO :: Bool -> IO ()
printKO result 
    | result = putStrLn "OK"
    | otherwise = putStrLn "KO"

checkCommands :: [String] -> Bool
checkCommands [] = True
checkCommands (x:xs)
    | x /= "sa" && x /= "sb" && x /= "sc" && x /= "pa" && x /= "pb" 
    && x /= "ra" && x /= "rb" && x /= "rr" && x /= "rra" 
    && x /= "rrb" && x /= "rrr" = False
    | otherwise = checkCommands xs

checkInput :: [String] -> Bool
checkInput [] = True
checkInput (x:xs)
    | x /= "0" && x /= "1" && x /= "2" && x /= "3" && x /= "4"
    && x /= "5" && x /= "6" && x /= "7" && x /= "8" 
    && x /= "9" = False
    | otherwise = checkInput xs

main :: IO ()
main = do 
        args <- getArgs
        str <- getLine
        let commands = splitBy ' ' str
        if not (checkCommands commands) || not (checkInput args)
            then putStrLn "KO" >> exitWith (ExitFailure 84)
            else printKO (pushswapChecker commands args [])
        return ()


