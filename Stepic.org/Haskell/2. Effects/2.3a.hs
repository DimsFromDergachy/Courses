
class (Functor t, Foldable t) => Traversable t where
    sequenceA :: Applicative f => t (f a) -> f (t a)
    traverse  :: Applicative f => (a -> f b) -> t a -> f (t b)

--  Laws: (for traverse)
--  1. Identity
--      traverse Identity === Identity
--               Identity ::   a -> Identity    a
--      traverse Identity :: t a -> Identity (t a)

--  2. Composition
--      traverse (Compose . fmap g2 . g1) === Compose . fmap (traverse g2) . traverse g1
--
--      fmap :: (a -> b) -> f a -> f b
--      traverse :: (a -> f b) -> t a -> f (t b)
--      Compose :: f (g a) -> Compose f g a
--      g1 :: a -> f1 b
--      g2 :: b -> f2 c
--      
--      fmap g2 . g1 :: a -> f1 (f2 c)
--      Compose . fmap g2 . g1 :: a -> Compose f1 f2 c
--      traverse (Compose . fmap g2 . g1) :: t a -> Compose f1 f2 (t c)
--      
--      traverse g1 :: t a -> f1 (t b)
--      traverse g2 :: t b -> f2 (t c)
--      fmap (traverse g2) :: f1 (t b) -> f1 (f2 (t c))
--      fmap (traverse g2) . (traverse g1) :: t a -> f1 (f2 (t c))
--      Compose . fmap (traverse g2) . (traverse g1) :: t a -> Compose f1 f2 (t c)

--  3. Naturality
--      t . traverse g === traverse (t . g)
-- 
--      t should be an applicative transformation
--      i.e.
--      t :: (Applicative f, Applicative g) => f a -> g a
--      t (pure x) === x
--      t (x <*> y) === t x <*> t y

--  Laws: (for sequenceA)
--  1. Identity
--      sequenceA . fmap Identity === Identity
--
--      Identity :: a -> Identity a
--      fmap :: (a -> b) -> f a -> f b
--      fmap Identity :: f a -> f (Identity a)
--      sequenceA :: t (f a) -> f (t a)
--      sequenceA . fmap Identity :: t a -> Identity (t a)

--  2. Composition
--      sequenceA . fmap Compose === Compose . fmap sequenceA . sequenceA
--
--      Compose :: f1 (f2 a) -> Compose f1 f2 a
--      fmap :: (a -> b) -> f a -> f b
--      fmap Compose :: h (f1 (f2 a)) -> h (Compose f1 f2 a)
--      sequenceA :: t (f a) -> f (t a)
--      sequenceA . fmap Compose :: t (f1 (f2 a)) -> Compose f1 f2 (t a)
--
--      sequenceA :: t (f1 a) -> f1 (t a)
--      fmap :: (a -> b) -> f a -> f b
--      sequenceA :: t (f2 a) -> f2 (t a)
--      fmap sequenceA :: f1 (t (f2 a)) -> f1 (f2 (t a))
--      fmap sequenceA . sequenceA :: t (f1 (f2 a)) -> f1 (f2 (t a))
--      Compose :: f1 (f2 a) -> Compose f1 f2 a
--      Compose . fmap sequenceA . sequenceA :: t (f1 (f2 a)) -> Compose f1 f2 (t a)

--  3. Naturality
--      t . sequenceA === sequenceA . fmap t
--
--      sequenceA :: (Traversable t, Applicative f) => t (f a) -> f (t a)
--      t :: (Applicative f, Applicative g) => f a -> g a
--      t . sequenceA :: (Traversable t, Applicative f, Applicative g) => t (f a) -> g (t a)
--
--      t :: (Applicative f, Applicative g) => f a -> g a
--      fmap :: Functor f => (a -> b) -> f a -> f b
--      fmap t :: (Applicative f, Applicative g, Functor h) => h (f a) -> h (g a)
--      sequenceA :: (Traversable t, Applicative g) => t (g a) -> g (t a)
--      sequenceA . fmap t :: (Traversable t, Applicative f, Applicative g) => t (f a) -> g (t a)
