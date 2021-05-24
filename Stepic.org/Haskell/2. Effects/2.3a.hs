
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