
-- a - fantom parameter
newtype Const c a = Const { getConst :: c }
    deriving (Eq, Show)

instance Functor (Const c) where
    fmap _ (Const x) = Const x

instance Foldable (Const c) where
    foldr _ z _ = z
    foldMap _ _ = mempty

instance Monoid c => Applicative (Const c) where
    pure _ = Const mempty
    (Const c1) <*> (Const c2) = Const (c1 <> c2)

instance Traversable (Const c) where
    sequenceA  (Const x) = pure (Const x)
    traverse _ (Const x) = pure (Const x)

