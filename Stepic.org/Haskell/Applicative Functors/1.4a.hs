{-# LANGUAGE LambdaCase #-}

import Data.Char (digitToInt, isDigit)

-- Evolution of parsers:
type ParserA a = String -> a
type ParserB a = String -> (a, String)
type ParserC a = String -> Maybe (a, String)
type ParserD a = String -> Either String (a, String)
type ParserE a = String -> [(a, String)]
-- ...

newtype Parser a = Parser { apply :: String -> [(a, String)]}

instance Functor Parser where
    fmap f p = Parser $ \s -> [(f a, s') | (a, s') <- apply p s]

instance Applicative Parser where
    pure x = Parser $ \s -> [(x, s)]
    pf <*> px = Parser $ \s -> do
        (f, s')  <- apply pf s
        (x, s'') <- apply px s'
        return (f x, s'')

parse :: Parser a -> String -> a
parse p = fst . head . apply p

fail :: Parser ()
fail = Parser $ const []

anyChar :: Parser Char
anyChar = Parser $ \case
    [] -> []
    (x:xs) -> [(x, xs)]

eof :: Parser ()
eof = Parser $ \case
    [] -> [((), "")]
    _  -> []

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser $ \case
    [] -> []
    (x:xs) -> [(x, xs) | p x]

char :: Char -> Parser Char
char c = satisfy (== c)

digit :: Parser Int
digit = digitToInt <$> satisfy isDigit

sequenceP :: [Parser a] -> Parser [a]
sequenceP = foldr f (pure [])
  where
    f p ps = (:) <$> p <*> ps

string :: String -> Parser String
string = sequenceP . map char

count :: Int -> Parser a -> Parser [a]
count n = sequenceP . replicate n

many :: Parser a -> Parser [a]
many = undefined