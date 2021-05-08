import Prelude hiding ((<*>))

infixl 4 <*>

class Functor f => Apply f where
    (<*>) :: f (a -> b) -> f a -> f b

instance Apply [] where
    fs <*> as = [f a | f <- fs, a <- as] -- apply each other
    fs <*> as = zipWith ($) fs as        -- zip alternative
