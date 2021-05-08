import Prelude hiding (Functor, Maybe (..), Either (..))

-- Types:
newtype Identity a = Identity a
data Maybe a = Nothing | Just a
--data [] a = [] | a : [] a -- not valid syntax
data Either a b = Left a | Right b
--data (,) a b = (,) a b -- not valid syntax
data Tree a = Leaf | Branch (Tree a) a (Tree a)

-- Functors:
class Functor f where
    fmap :: (a -> b) -> f a -> f b

instance Functor Identity where
    fmap f (Identity x) = Identity $ f x

instance Functor Maybe where
    fmap _ Nothing = Nothing
    fmap f (Just x) = Just $ f x

instance Functor [] where
    fmap = map

instance Functor (Either e) where
    -- fmap :: (a -> b) -> Either e a -> Either e b
    fmap _ (Left x) = Left x
    fmap f (Right x) = Right $ f x

instance Functor ((,) s) where
    -- fmap :: (a -> b) -> (s, a) -> (s, b)
    fmap f (x, y) = (x, f y)

instance Functor ((->) e) where
    -- fmap :: (a -> b) -> (e -> a) -> (e -> b)
    fmap = (.)

instance Functor Tree where
    fmap _ Leaf = Leaf
    fmap f (Branch l x r) = Branch (Main.fmap f l) (f x) (Main.fmap f r)

-- Task:
newtype Arr2 e1 e2 a = Arr2 {getArr2 :: e1 -> e2 -> a}
newtype Arr3 e1 e2 e3 a = Arr3 {getArr3 :: e1 -> e2 -> e3 -> a}

instance Functor (Arr2 e1 e2) where
  -- fmap :: (a -> b) -> (Arr2 e1 e2 a) -> (Arr2 e1 e2 b)
  -- fmap :: (a -> b) -> (e1 -> e2 -> a) -> (e1 -> e2 -> b)
  fmap f (Arr2 g) = Arr2 (\e1 e2 -> f (g e1 e2))

instance Functor (Arr3 e1 e2 e3) where
  -- fmap :: (a -> b) -> (Arr3 e1 e2 e3 a) -> (Arr3 e1 e2 e3 b)
  -- fmap :: (a -> b) -> (e1 -> e2 -> e3 -> a) -> (e1 -> e2 -> e3 -> b)
  fmap f (Arr3 g) = Arr3 (\e1 e2 e3 -> f (g e1 e2 e3))

-- Laws:
-- 1. fmap id cont === cont
-- 2. fmap f (fmap g cont) === fmap (f . g) cont

-- Laws for Either
-- 1a. fmap id (Left x) ==> Left x
-- 1b. fmap id (Right y) ==> Right (id y) ==> Right y
-- 2a. fmap f (fmap g (Left x)) ==> fmap f (Left x) ==> Left x
-- 2a. fmap (f . g) (Left x) ==> Left x
-- 2b. fmap f (fmap g (Right x)) ==> fmap f (Right g x) ==> Right (f (g x))
-- 2b. fmap (f . g) (Right x)) ==> Right ((f . g) x) ==> Right (f (g x))

-- Laws for ((->) e)
-- 1a. fmap id (e ->) ==> id . (e ->) ==> id (e ->) ==> (e ->)
-- 2a. fmap f (fmap g (e ->)) ==> fmap f (g . (e ->)) ==> f . (g . (e ->))
--      ==> f . g . (e ->)
-- 2b. fmap (f . g) (e ->) ==> (f . g) . (e ->) ==> f . g . (e ->)

-- Laws for []
-- 1a. fmap id [] ==> map id [] ==> []
-- 1b. fmap id xs === xs
-- 1b. fmap id (x:xs) ==> map id (x:xs) ==> (id x) : map id xs ==> x : fmap id xs ==>
--      ==> x : xs
-- 2a. fmap f (fmap g []) ==> map f (map g []) => map f [] => []
-- 2a. fmap (f . g) [] ==> map (f . g) [] ==> []
-- 2b. fmap f (fmap g xs) === fmap (f . g) xs
-- 2b. fmap f (fmap g (x:xs)) ==> map f (map g (x:xs)) ==> map f (g x : map g xs) ==>
--      ==> f (g x) : map f (map g xs) ==> (f . g) x : fmap f (fmap g xs) ==>
--      ==> (f . g) x : fmap (f . g) xs ==> (f . g) x : map (f . g) xs ==>
--      ==> map (f . g) (x:xs) ==> fmap (f . g) (x:xs)
