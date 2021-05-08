
instance Functor ((,) s) where
    fmap f (a, b) = (a, f b)

instance Monoid s => Applicative ((,) s) where
    pure x = (mempty, x)
    (s1, f) <*> (s2, x) = (s1 <> s2, f x)

-- Laws:
--  1. pure id <*> v === v
--      (mempty, id) <*> (s, x) ==> (mempty <> s, id x) ==> (s, x)
--  2. pure f <*> pure x === pure (f x)
--      (mempty, f) <*> (mempty, x) ==> (mempty <> mempty, f x) ==> (mempty, f x) ==> pure (f x)
--  3. cont <*> pure x === pure ($ x) <*> cont
--      (s, f) <*> (mempty, x) ==> (s <> mempty, f x) ==> (s, f x)
--      (mempty, ($ x)) <*> (s, f) ==> (mempty <> s, ($ x) f) ==> (s, f x)
--  4. pure (.) <*> u <*> v <*> cont === u <*> (v <*> cont)
--      (mempty, (.)) <*> (s1, f) <*> (s2, g) <*> (s3, x) ==>
--          ==> (mempty <> s1 <> s2 <> s3, (.) f g x) ==>
--          ==> (s1 <> s2 <> s3, f (g x))
--      (s1, f) <*> ((s2, g) <*> (s3, x)) ==>
--          ==> (s1, f) <*> (s2 <> s3, g x) ==>
--          ==> (s1 <> (s2 <> s3), f (g x)) ==>
--          ==> (s1 <> s2 <> s3, f (g x))
