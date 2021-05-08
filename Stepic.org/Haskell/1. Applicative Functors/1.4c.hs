import Control.Applicative

newtype Parser a = Parser { apply :: String -> [(a, String)]}

instance Functor Parser where
    fmap f p = Parser $ \s -> [(f a, s') | (a, s') <- apply p s]

instance Applicative Parser where
    pure x = Parser $ \s -> [(x, s)]
    pf <*> px = Parser $ \s -> do
        (f, s')  <- apply pf s
        (x, s'') <- apply px s'
        return (f x, s'')

instance Alternative Parser where
    empty = Parser $ const []
    p <|> q = Parser $ \s -> apply p s <||> apply q s
      where
        [] <||> y = y
        x  <||> _ = x
