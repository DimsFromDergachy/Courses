
data OddC a = Un a | Bi a a (OddC a)
    deriving (Eq, Show)

instance Functor OddC where
    fmap f (Un x)        = Un $ f x
    fmap f (Bi x y rest) = Bi (f x) (f y) (fmap f rest)

instance Foldable OddC where
    foldr f z (Un x)        = f x z
    foldr f z (Bi x y rest) = x `f` (y `f` foldr f z rest)

instance Traversable OddC where
    sequenceA (Un fx)         = Un <$> fx
    sequenceA (Bi fx fy rest) = Bi <$> fx <*> fy <*> sequenceA rest

    traverse f (Un x)        = Un <$> f x
    traverse f (Bi x y rest) = Bi <$> f x <*> f y <*> traverse f rest