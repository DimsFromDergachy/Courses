
instance Functor ((->) e) where
    fmap :: (a -> b) -> (e -> a) -> (e -> b)
    fmap = (.)

instance Applicative ((->) e) where
    pure :: a -> (e -> a)
    pure = const
    (<*>) :: (e -> a -> b) -> (e -> a) -> (e -> b)
    f <*> g = \e -> f e (g e) -- 'S' combinator

-- Laws:
--  1. pure id <*> v === v
--      const id <*> f ==> const id <*> f ==> \e -> (const id) e (f e) ==> \e -> f e ==> f
--          as '''const id x === x'''
--  2. pure f <*> pure x === pure (f x)
--      
--  3. cont <*> pure x === pure ($ x) <*> cont
--  4. pure (.) <*> u <*> v <*> cont === u <*> (v <*> cont)
