
import Prelude hiding (foldMap)

newtype Endo a = Endo { appEndo :: a -> a }

instance Semigroup (Endo a) where
    (Endo f) <> (Endo g) = Endo (f . g)
    
instance Monoid (Endo a) where
    mempty = Endo id
    mappend = (<>)

class Foldable t where
    foldMap :: Monoid m => (a -> m) -> t a -> m

    foldr :: (a -> b -> b) -> b -> t a -> b
    foldr f z cont = appEndo (foldMap (Endo . f) cont) z