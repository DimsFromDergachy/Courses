
import Data.Monoid (All (..), getAll)
import Data.Monoid (Any (..), getAny)
import Data.Monoid (Product (..), getProduct)
import Data.Monoid (Sum (..), getSum)
import Prelude hiding (Foldable, concat, foldMap, foldl, foldr)

class Foldable t where
    foldr :: (a -> b -> b) -> b -> t a -> b
    foldl :: (b -> a -> b) -> b -> t a -> b

    fold :: Monoid m => t m -> m
    fold = foldr (<>) mempty -- mconcat

    foldMap :: Monoid m => (a -> m) -> t a -> m
    foldMap f = foldr ((<>) . f) mempty

    sum :: Num a => t a -> a
    sum = getSum . foldMap Sum

    product :: Num a => t a -> a
    product = getProduct . foldMap Product

    null :: t a -> Bool
    -- null = foldr (const . const False) True
    --null = not . getAny . foldMap (Any . const True)
    null = getAll . foldMap (All . const False)

    toList :: t a -> [a]
    toList = foldr (:) []

    length :: Num b => t a -> b
    --length = foldr (\_ x -> x + 1) 0
    length = foldl (\x _ -> x + 1) 0 -- should be strict

    maximum :: (Ord a, Bounded a) => t a -> a
    maximum = foldr max minBound

    minimum :: (Ord a, Bounded a) => t a -> a
    minimum = foldr min maxBound

    elem :: Eq a => a -> t a -> Bool
    elem a = getAny . foldMap (Any . (== a))

    and :: t Bool -> Bool
    and = getAll . foldMap All

    or :: t Bool -> Bool
    or = getAny . foldMap Any

    all :: (a -> Bool) -> t a -> Bool
    all f = getAll . foldMap (All . f)

    any :: (a -> Bool) -> t a -> Bool
    any f = getAny . foldMap (Any . f)

    concat :: t [a] -> [a]
    -- concat = foldr (++) []
    concat = fold -- default implementation is more efficient than this one

    concatMap :: (a -> [b]) -> t a -> [b]
    concatMap = foldMap