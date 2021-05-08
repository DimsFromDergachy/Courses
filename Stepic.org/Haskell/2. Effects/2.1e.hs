
import Data.Monoid (Endo(..))

newtype Dual a = Dual { getDual :: a}

instance Semigroup a => Semigroup (Dual a) where
    Dual x <> Dual y = Dual (y <> x) -- the order is reversed

instance Monoid a => Monoid (Dual a) where
    mempty = Dual mempty

--                 "Abc"  <>       "De"  <>       "Fgh"     ==>  "AbcDeFgh"
-- getDual $ (Dual "Abc") <> (Dual "De") <> (Dual "Fgh")    ==>  "FghDeAbc"

--  appEndo                    (Endo  (+5) <>         Endo  (*3)) 2  ==>  (+5) . (*3) $ 2  ==>  11
-- (appEndo . getDual) ((Dual . Endo) (+5) <> (Dual . Endo) (*3)) 2  ==>  (*3) . (+5) $ 2  ==>  21

-- foldr :: (a -> b -> b) -> b -> t a -> b
-- foldl :: (b -> a -> b) -> b -> t a -> b
--
-- foldr f z [a, b, c] = a `f` (b `f` (c `f` z))
-- foldl f z [a, b, c] = z `f` a `f` b `f` c
--                     = ((z `f` a) `f` b) `f` c

-- foldr :: (a -> b -> b) -> b -> t a -> b
-- foldl :: (b -> a -> b) -> b -> t a -> b

-- f :: (b -> a -> b)
-- flip f :: (a -> b -> b)
-- Endo :: (b -> b) -> Endo b
-- (.) :: ((b -> b) -> Endo b) -> (a -> (b -> b)) -> a -> Endo b
-- Endo . (flip f) :: a -> Endo b
-- (<>) :: Endo b -> (Endo b -> Endo b)
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- (.) :: (Endo b -> (Endo b -> Endo b)) -> (a -> Endo b) -> (a -> (Endo b -> Endo b))
-- (<>) . (Endo . flip f) :: a -> (Endo b -> Endo b)

foldlReverse :: Foldable t => (b -> a -> b) -> b -> t a -> b
foldlReverse f z cont = appEndo (foldr ((<>) . (Endo . flip f)) mempty cont) z

-- foldlReverse (++) "" ["Abc", "De", "Fgh"]
-- "FghDeAbc"

foldlForward :: Foldable t => (b -> a -> b) -> b -> t a -> b
foldlForward f z cont = (appEndo . getDual) (foldr ((<>) . (Dual . Endo . flip f)) mempty cont) z

-- foldlForward (++) "" ["Abc", "De", "Fgh"]
-- "AbcDeFgh"