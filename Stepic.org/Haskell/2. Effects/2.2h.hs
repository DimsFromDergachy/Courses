{-# LANGUAGE TypeOperators #-}

infixr 9 |.|
newtype (|.|) f g a = Cmps { getCmps :: f (g a) }  deriving (Eq,Show) 

instance (Functor f, Functor g) => Functor (f |.| g) where
    -- fmap :: (a -> b) -> (f |.| g a) -> (f |.| g b)
    fmap h = Cmps . (fmap . fmap) h . getCmps

instance (Foldable f, Foldable g) => Foldable ((|.|) f g) where
    -- foldMap :: Monoid m => (a -> m) -> (f |.| g a) -> m
    foldMap f xss = foldMap (foldMap f) $ getCmps xss

instance (Traversable t1, Traversable t2) => Traversable ((|.|) t1 t2) where
    -- sequenceA :: Applicative f => ((|.|) t1 t2 (f a)) -> f ((|.|) t1 t2 a)
    sequenceA x = Cmps <$> _ (getCmps x)


