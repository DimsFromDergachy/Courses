
import Prelude hiding (Foldable, foldl, foldr)

class Foldable t where
    foldr :: (a -> b -> b) -> b -> t a -> b
    foldl :: (b -> a -> b) -> b -> t a -> b

instance Foldable Maybe where
    foldr f z (Just x) = f x z
    foldr _ z _        = z
    foldl f z (Just x) = f z x
    foldl _ z _        = z

instance Foldable (Either s) where
    foldr f z (Right x) = f x z
    foldr _ z _         = z
    foldl f z (Right x) = f z x
    foldl _ z _         = z

instance Foldable ((,) s) where
    foldr f z (_, x) = f x z
    foldl f z (_, x) = f z x

data Triple a = Tr a a a
    deriving (Eq, Show)

instance Foldable Triple where
  foldr f z (Tr a b c) = a `f` (b `f` (c `f` z))
  foldl f z (Tr a b c) = z `f` a `f` b `f` c
