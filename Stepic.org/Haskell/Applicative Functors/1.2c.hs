import Prelude hiding (Either(..))

data Either a b = Left a | Right b

instance Functor (Either e) where
    fmap f (Right x) = Right (f x)
    fmap _ (Left  e) = Left e

instance Monoid e => Applicative (Either e) where
    pure x = Right x
    Right f <*> Right x = Right $ f x
    Right f <*> Left  e = Left e
    Left  e <*> Right x = Left e
    Left e1 <*> Left e2 = Left $ e1 <> e2
    -- _ <*> _ = Left mempty -- Lose info!

-- Laws:
--  1. pure id <*> v === v
--      Right id <*> (Right x) = Right (id x) = Right x
--      Right id <*> (Left  e) = Left e
--  2. pure f <*> pure x === pure (f x)
--      Right f <*> Right x === Right (f x)
--  3. cont <*> pure x === pure ($ x) <*> cont
--      cont <*> Right x === Right ($ x) <*> cont
--      Right f <*> Right x ==> Right (f x)
--      Right ($ x) <*> Right f ==> Right (($ x) f) ==> Right (f x)
--      Left e <*> Right x ==> Left e
--      Right ($ x) <*> Left e ==> Left e
--  4. pure (.) <*> u <*> v <*> cont === u <*> (v <*> cont)
--      Right (.) <*> Right f <*> Right g <*> Right x ==>
--          ==> Right ((.) f g x) ==>
--          ==> Right (f (g x))
--      Right f <*> (Right g <*> Right x) ==>
--          ==> Right f <*> Right (g x) ==>
--          ==> Right (f (g x))
--
--      Right (.) <*> Left e <*> Right g <*> Right x    ==> Left e
--      Left e <*> (Right g <*> Right x)                ==> Left e
--
--      Right (.) <*> Left e1 <*> Left e2 <*> Left e3                   ==> Left (e1 <> e2 <> e3)
--      Left e1 <*> (Left e2 <*> Left e3) ==> Left (e1 <> (e2 <> e3))   ==> Left (e1 <> e2 <> e3)