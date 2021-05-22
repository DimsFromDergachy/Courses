import Prelude hiding (Traversable, sequenceA, traverse)

class (Functor t, Foldable t) => Traversable t where
    sequenceA :: Applicative f => t (f a) -> f (t a)
    traverse  :: Applicative f => (a -> f b) -> t a -> f (t b)

    sequenceA  = traverse id
    traverse f = sequenceA . fmap f

instance Traversable Maybe where
    sequenceA Nothing  = pure Nothing
    sequenceA (Just x) = Just <$> x

    traverse _ Nothing  = pure Nothing
    traverse f (Just x) = Just <$> f x

instance Traversable ((,) s) where
    sequenceA (s, fa) = (,) s <$> fa
    traverse f (s, a) = (,) s <$> f a