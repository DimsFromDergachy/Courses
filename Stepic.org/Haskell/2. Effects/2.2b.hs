import Prelude hiding (sequenceA, traverse)

class (Functor t, Foldable t) => Traversable t where
    sequenceA :: Applicative f => t (f a) -> f (t a)
    traverse  :: Applicative f => (a -> f b) -> t a -> f (t b)

    sequenceA  = traverse id
    traverse f = sequenceA . fmap f

