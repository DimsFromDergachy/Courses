
-- List as Applicative
newtype List a = List [a]
    deriving Show

instance Functor List where
    fmap f (List xs) = List $ map f xs

instance Applicative List where
    pure x = List [x]
    List fs <*> List xs = List [f x | f <- fs, x <- xs]

-- ZipList as Applicative
newtype ZipList a = ZipList [a]
    deriving Show

instance Functor ZipList where
    fmap f (ZipList xs) = ZipList $ map f xs

instance Applicative ZipList where
    pure x = ZipList $ repeat x
    ZipList fs <*> ZipList xs = ZipList $ zipWith ($) fs xs
