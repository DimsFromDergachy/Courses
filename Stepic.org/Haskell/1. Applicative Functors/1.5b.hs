{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE InstanceSigs #-}

infixr 9 |.|
newtype (|.|) f g a = Cmps { getCmps :: f (g a) }
    deriving (Eq, Show)

instance (Functor f, Functor g) => Functor (f |.| g) where
    fmap h = Cmps . (fmap . fmap) h . getCmps

instance (Applicative f, Applicative g) => Applicative (f |.| g) where
    pure :: a -> (f |.| g) a
    pure = Cmps . pure . pure
    (<*>) :: (f |.| g) (a -> b) -> (f |.| g) a -> (f |.| g) b
    (Cmps h) <*> (Cmps x) = Cmps $ fmap (<*>) h <*> x
    -- fmap                 ::      (a -> b)  -> f a     -> f b
    -- (<*>)                ::    g (a -> b)  -> g a     -> g b
    -- fmap (<*>)           :: f (g (a -> b)  -> g a)    -> f (g a)
    -- fmap (<*>)           :: f (g (a -> b)) -> f (g a) -> f (g b)
    -- h                    :: f (g (a -> b))
    -- fmap (<*>) h         ::                   f (g a) -> f (g b)
    -- x                    ::                   f (g a)
    -- fmap (<*>) h <*> x   ::                              f (g b)

unCmps3 :: Functor f => (f |.| g |.| h) a -> f (g (h a))
unCmps3 (Cmps f) = fmap getCmps f

unCmps4 :: (Functor f2, Functor f1) => (f2 |.| f1 |.| g |.| h) a -> f2 (f1 (g (h a)))
unCmps4 (Cmps f) = fmap unCmps3 f