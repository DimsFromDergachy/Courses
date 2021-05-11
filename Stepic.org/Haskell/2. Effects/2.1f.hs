{-# LANGUAGE TypeOperators #-}

infixr 9 |.|
newtype (|.|) f g a = Cmps { getCmps :: f (g a) }
    deriving (Eq, Show) 

instance (Foldable f, Foldable g) => Foldable ((|.|) f g) where
    foldMap f xss = foldMap (foldMap f) $ getCmps xss
