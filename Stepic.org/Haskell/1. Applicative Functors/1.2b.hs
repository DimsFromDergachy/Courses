import Control.Applicative (ZipList(ZipList), getZipList)

infixl 4 >$<
(>$<) :: (a -> b) -> [a] -> [b]
f >$< xs = getZipList $ f <$> ZipList xs

infixl 4 >*<
(>*<) :: [a -> b] -> [a] -> [b]
fs >*< xs = getZipList $ ZipList fs <*> ZipList xs

-- Example usage:
-- (\a b c -> a + 2*b - 5*c) >$< [1,3,5] >*< [2,0,0,0,0] >*< [3,1,1,1]
--   [-10, -2, 0]