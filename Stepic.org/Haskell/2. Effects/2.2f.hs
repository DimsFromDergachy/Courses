
newtype ZipList a = ZipList [a]
    deriving Show

instance Functor ZipList where
    fmap f (ZipList as) = ZipList $ map f as

instance Applicative ZipList where
    pure x = ZipList $ repeat x
    ZipList fs <*> ZipList xs = ZipList $ zipWith ($) fs xs

instance Foldable ZipList where
    foldr f z (ZipList as) = foldr f z as

instance Traversable ZipList where
    sequenceA (ZipList fs) = ZipList <$> sequenceA fs
    traverse f (ZipList xs) = ZipList <$> traverse f xs

-- sequenceA [[2,3], [5,7], [11,13]]
-- [[2,5,11],[2,5,13],[2,7,11],[2,7,13],[3,5,11],[3,5,13],[3,7,11],[3,7,13]]

-- sequenceA $ map ZipList [[2,3], [5,7], [11,13]]
-- ZipList [[2,5,11],[3,7,13]]