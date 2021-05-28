{-# OPTIONS_GHC -Wno-deferred-type-errors #-}

import Prelude hiding (sequenceA, traverse)

class (Functor t, Foldable t) => Traversable t where
    sequenceA :: Applicative f => t (f a) -> f (t a)
    traverse :: Monoid m => (a -> m) -> t a -> m

    sequence :: Monad m => t (m a) -> m (t a)
    sequence = sequenceA

    mapM :: Monad m => (a -> m b) -> t a -> m (t b)
    mapM = traverse