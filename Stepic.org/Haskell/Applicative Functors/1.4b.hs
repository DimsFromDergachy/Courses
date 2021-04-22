
-- Alternative == Monoid for Applicative

class Applicative f => Alternative f where
    empty :: f a
    (<|>) :: f a -> f a -> f a

infixl 3 <|>

--  Laws:
--  Monoid laws:
--      1. Zero element
--          empty <|> x === x
--          x <|> empty === x
--      2. Associative
--          (a <|> b) <|> c === a <|> (b <|> c)
--  Applicative laws:
--      1. Right distributivity of <*>
--          (f <|> g) <*> a === (f <*> a) <|> (g <*> a)
--      2. Right absorption of <*>
--          empty <*> a === empty
--      3. Left distributivity of fmap
--          f <$> (a <|> b) === (f <$> a) <|> (f <$> b)
--      4. Left absorption of fmap
--          f <$> empty === empty


instance Alternative [] where
    empty = []
    (<|>) = (++)

instance Alternative Maybe where
    empty = Nothing
    Nothing <|> r = r
    l       <|> _ = l