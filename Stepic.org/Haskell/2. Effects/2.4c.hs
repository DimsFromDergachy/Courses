
--  appDefault
app :: Monad m => m (a -> b) -> m a -> m b
app mf mx = mf >>= \f -> mx >>= return . f
--app mf mx = do { f <- mf; x <- mx; return (f x) }

--  fmapDefault
liftM :: Monad m => (a -> b) -> m a -> m b
liftM f mx = mx >>= return . f
--liftM f mx = do { x <- mx; return (f x) }

--  Monad' laws:
--  1. Left identity
--      return a >>= f === f a
--  2. Right identity
--      m >>= return === m
--  3. Associativity
--      (m >>= f) >>= g === m >>= (\x -> f x >>= g)