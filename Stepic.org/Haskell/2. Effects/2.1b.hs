data Tree a = Nil | Branch (Tree a) a (Tree a)
    deriving (Eq, Show)

newtype Preorder a   = PreO   (Tree a)    deriving (Eq, Show)
newtype Postorder a  = PostO  (Tree a)    deriving (Eq, Show)
newtype Levelorder a = LevelO (Tree a)    deriving (Eq, Show)

{-         4
         2   5
        1 3         -}
tree = Branch (Branch (leaf 1) 2 (leaf 3)) 4 (leaf 5)
  where
    leaf x = Branch Nil x Nil

instance Foldable Tree where
    foldr f z (Branch left x right) = foldr f (x `f` foldr f z right) left
    foldr _ z _                     = z
    foldl f z (Branch left x right) = foldl f (foldl f z left `f` x) right
    foldl _ z _                     = z

instance Foldable Preorder where
    foldr f z (PreO (Branch left x right)) = x `f` foldr f (foldr f z (PreO right)) (PreO left)
    foldr _ z _ = z

instance Foldable Postorder where
    foldr f z (PostO (Branch left x right)) = foldr f (foldr f (x `f` z) (PostO right)) (PostO left)
    foldr _ z _ = z

instance Foldable Levelorder where
    foldr f z tree = foldr f z (toList tree)
      where
        toList (LevelO (Branch left x right)) = x : merge (toList (LevelO left)) (toList (LevelO right))
          where
            merge (a:as) (b:bs) = a : b : merge as bs
            merge as [] = as
            merge [] bs = bs
        toList _ = []