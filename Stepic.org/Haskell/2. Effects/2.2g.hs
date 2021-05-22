
data Tree a = Nil | Branch (Tree a) a (Tree a)
    deriving (Eq, Show)

instance Functor Tree where
    fmap f  Nil                  = Nil
    fmap f (Branch left x right) = Branch (f <$> left) (f x) (f <$> right)

instance Applicative Tree where
    pure x = Branch (pure x) x (pure x)

    Branch fl fx fr <*> Branch l x r = Branch (fl <*> l) (fx x) (fr <*> r)
    _               <*> _            = Nil

instance Foldable Tree where
    foldr f z  Nil                  = z
    foldr f z (Branch left x right) = x `f` foldr f (foldr f z right) left

instance Traversable Tree where
    -- sequenceA :: Applicative f => Tree (f a) -> f (Tree a)
    sequenceA  Nil                  = pure Nil
    sequenceA (Branch left x right) = Branch <$> sequenceA left <*> x <*> sequenceA right

    -- traverse :: Applicative f => (a -> f b) -> Tree a -> f (Tree b)
    traverse _  Nil                  = pure Nil
    traverse f (Branch left x right) = Branch <$> traverse f left <*> f x <*> traverse f right
