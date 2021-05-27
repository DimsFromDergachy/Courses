
import Data.Functor.Const
import Data.Functor.Identity

data Result a = Error | OK a
    deriving (Eq, Show)

instance Traversable Result where
    sequenceA Error   = pure Error
    sequenceA (OK fx) = OK <$> fx

    traverse _ Error  = pure Error
    traverse f (OK x) = OK <$> f x

fmapDefault :: Traversable t => (a -> b) -> t a -> t b
fmapDefault f = runIdentity . traverse (Identity . f)

instance Functor Result where
    fmap = fmapDefault

foldMapDefault :: (Monoid m, Traversable t) => (a -> m) -> t a -> m
foldMapDefault f = getConst . traverse (Const . f)

instance Foldable Result where
    foldMap = foldMapDefault