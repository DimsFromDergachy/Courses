
import Control.Applicative

data Tree a = Nil | Branch (Tree a) a (Tree a)
    deriving (Eq, Show)

{-         4
         2   5
        1 3         -}
tree = Branch (Branch (leaf 1) 2 (leaf 3)) 4 (leaf 5)
  where
    leaf x = Branch Nil x Nil

instance Foldable Tree where
    foldr f z Nil = z
    foldr f z (Branch left x right) = x `f` foldr f (foldr f z right) left -- preorder [4, 2, 1, 3, 5]

instance Functor Tree where
    fmap f Nil = Nil
    fmap f (Branch left x right) = Branch (f <$> left) (f x) (f <$> right)

fold :: (Foldable t, Monoid m) => t m -> m
fold = foldr mappend mempty

asum :: (Foldable t, Alternative f) => t (f a) -> f a
asum = foldr (<|>) empty

-- asum $ fmap Just tree             ==>  Just 4
-- asum $ fmap (const Nothing) tree  ==> Nothing

sequenceA_ :: (Foldable t, Applicative f) => t (f a) -> f ()
sequenceA_ = foldr (*>) (pure ())

-- sequenceA_ $ fmap Just tree             ==>  Just ()
-- sequenceA_ $ fmap (const Nothing) tree  ==>  Nothing

-- sequenceA_ $ fmap Right tree  ==>  Right ()
-- sequenceA_ $ fmap Left  tree  ==>  Left  4


foldMap :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
foldMap f = foldr (mappend . f) mempty

traverse_ :: (Foldable t, Applicative f) => (a -> f b) -> t a -> f ()
traverse_ f = foldr ((*>) . f) (pure ())

-- traverse_ Just tree             ==>  Just ()
-- traverse_ (const Nothing) tree  ==>  Nothing

-- traverse_ Right tree  ==>  Right ()
-- traverse_ Left  tree  ==>  Left  4
