
class Functor f => Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b

instance Applicative Maybe where
    pure = Just
    Just f <*> Just x = Just $ f x
    _ <*> _ = Nothing

-- Law:
-- fmap f cont === pure f <*> cont

