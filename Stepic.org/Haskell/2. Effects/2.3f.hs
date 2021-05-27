import Control.Applicative ((<**>))
import Data.Traversable (fmapDefault, foldMapDefault)

data Tree a = Nil | Branch (Tree a) a (Tree a)
    deriving (Eq, Show)

instance Functor Tree where
    fmap _ Nil = Nil
    fmap f (Branch l x r) = Branch (f <$> l) (f x) (f <$> r)

instance Foldable Tree where
    foldMap = foldMapDefault

instance Traversable Tree where
    sequenceA Nil = pure Nil

    --  Pre-order NLR: x, left, right
    --sequenceA (Branch left x right) = x <**> (flip . Branch <$> sequenceA left <*> sequenceA right)

    --  Reverse post-order, NRL: x, right, left
    --sequenceA (Branch left x right) = x <**> (sequenceA right <**> pure (flip . Branch) <*> sequenceA left)

    --  In-order, LNR: left, x, right
    --sequenceA (Branch left x right) = Branch <$> sequenceA left <*> x <*> sequenceA right

    --  Post-order, LRN: left, right, x
    sequenceA (Branch left x right) = flip . Branch <$> sequenceA left <*> sequenceA right <*> x

    --  Reverse in-order, RNL: right, x, left
    --sequenceA (Branch left x right) = sequenceA right <**> (x <**> (Branch <$> sequenceA left))

    --  Reverse pre-order RLN: right, left, x
    --sequenceA (Branch left x right) = sequenceA right <**> pure (flip . Branch) <*> sequenceA left <*> x


