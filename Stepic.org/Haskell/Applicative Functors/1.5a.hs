{-# LANGUAGE TypeOperators #-}

infixr 9 |.|
newtype (|.|) f g a = Cmps { getCmps :: f (g a) }
    deriving (Eq, Show)

instance (Functor f, Functor g) => Functor (f |.| g) where
    -- fmap :: (a -> b) -> (f |.| g a) -> (f |.| g b)
    fmap h = Cmps . (fmap . fmap) h . getCmps
--  fmap h (Cmps x) = Cmps $ (fmap . fmap) h x
--  fmap h (Cmps x) = Cmps $ (fmap (fmap h)) x

-- Laws:
--  1. fmap id cont === cont
--     fmap id cont === id cont
--     fmap id      === id
-----------------------------------------------------------
--     fmap id (Cmps x) ==>
--          ==> Cmps $ (fmap . fmap) id x ==>
--          ==> Cmps $ (fmap (fmap id)) x ==>
--          ==> Cmps $ fmap (fmap id) x =>
--          ==> Cmps $ fmap id x ==>
--          ==> Cmps $ id x ==>
--          ==> Cmps x
--      
--  2. fmap f (fmap g cont) === fmap (f . g) cont
--     (fmap f) . (fmap g)  === fmap (f . g)
-----------------------------------------------------------
--      fmap f $ fmap g $ (Cmps x) ==>
--          ==> fmap f $ Cmps $ (fmap . fmap) g x ==>
--          ==> Cmps $ (fmap . fmap) f $ (fmap . fmap) g x ==>
--          ==> Cmps $ (fmap (fmap f)) $ (fmap (fmap g)) x ==>
--          ==> 
--          


--  fmap h (Cmps x) = Cmps (fmap (fmap h)) x
--  

--  2.  fmap f (fmap g cont)   === fmap (f . g) cont
--      (fmap f . fmap g) cont === fmap (f . g) cont
--      fmap f . fmap g        === fmap (f . g)
--
--
--  fmap h2 (fmap h1 (Cmps x)) === fmap (h2 . h1) (Cmps x)
--    Right:
--      fmap h2 (fmap h1 (Cmps x)) ==>                  --  def fmap of Cmps
--      fmap h2 (Cmps (fmap (fmap h1)) x) ==>           --  def fmap of Cmps
--      Cmps (fmap (fmap h2)) ((fmap (fmap h1)) x) ==>  --  def 
--    Left:
--      fmap (h2 . h1) (Cmps x) ==>             -- def fmap of Cmps
--      Cmps (fmap (fmap (h2 . h1))) x ==>      -- def



newtype Cmps3 f g h a = Cmps3 { getCmps3 :: f (g (h a)) } 
  deriving (Eq,Show) 

instance (Functor f, Functor g, Functor h) => Functor (Cmps3 f g h) where
  fmap k = Cmps3 . (fmap . fmap . fmap) k . getCmps3

