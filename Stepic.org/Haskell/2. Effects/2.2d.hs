
data Result a = Ok a | Error String
    deriving (Eq, Show)

instance Functor Result where
    fmap f (Ok x)     = Ok $ f x
    fmap _ (Error s)  = Error s

instance Foldable Result where
    foldr f z (Ok x)    = f x z
    foldr _ z (Error s) = z

instance Traversable Result where
    sequenceA (Ok fx)   = Ok <$> fx
    sequenceA (Error s) = pure $ Error s

    traverse f (Ok x)    = Ok <$> f x
    traverse _ (Error s) = pure $ Error s