import Prelude hiding (Traversable)

class (Functor t, Foldable t) => Traversable t where
    sequenceA :: Applicative f => t (f a) -> f (t a)
    traverse  :: Applicative f => (a -> f b) -> t a -> f (t b)

instance Traversable [] where
    sequenceA = foldr (\x y -> (:) <$> x <*> y) (pure [])
    traverse f = foldr (\x y -> (:) <$> f x <*> y) (pure [])

