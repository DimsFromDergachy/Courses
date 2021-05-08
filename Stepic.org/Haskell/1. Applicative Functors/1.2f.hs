import Control.Applicative hiding ((<*), (*>), (<**>))

(<*) :: Applicative f => f a -> f b -> f a
u <* v = const <$> u <*> v

(*>) :: Applicative f => f a -> f b -> f b
u *> v = flip const <$> u <*> v

(<**>) :: Applicative f => f a -> f (a -> b) -> f b
(<**>) = liftA2 (flip ($))

(<*?>) :: Applicative f => f a -> f (a -> b) -> f b
(<*?>) = flip (<*>)

-- For some Applicatives, functions '(<**>)' and '(<*?>)' apply effects in different way:

-- [42, 42] <**> [succ, pred] = [43,41,43,41]
-- [42, 42] <*?> [succ, pred] = [43,43,41,41]

-- Left "A" <**> Left "B" = Left "A"
-- Left "A" <*?> Left "B" = Left "B"

-- ("A", 0) <**> ("B", id) = ("AB",0)
-- ("A", 0) <*?> ("B", id) = ("BA",0)