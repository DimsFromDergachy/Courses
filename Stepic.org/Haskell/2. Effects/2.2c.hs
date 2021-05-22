data Triple a = Tr a a a
    deriving (Eq, Show)

instance Functor Triple where
    fmap f (Tr x y z) = Tr (f x) (f y) (f z)

instance Foldable Triple where
    foldr f z (Tr a b c) = a `f` (b `f` (c `f` z))
    foldl f z (Tr a b c) = z `f` a `f` b `f` c

instance Traversable Triple where
    sequenceA (Tr fa fb fc) = Tr <$> fa <*> fb <*> fc
    traverse f (Tr a b c) = Tr <$> f a <*> f b <*> f c