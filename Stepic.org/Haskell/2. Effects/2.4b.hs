{-# LANGUAGE LambdaCase #-}

newtype PrsE a = PrsE { runPrsE :: String -> Either String (a, String) }

instance Functor PrsE where
  fmap f p = PrsE $ \s -> do
      (x, s') <- runPrsE p s
      return (f x, s')

instance Applicative PrsE where
  pure x = PrsE $ \s -> Right (x, s)
  pf <*> px = PrsE $ \s -> do
    (f, s')  <- runPrsE pf s
    (x, s'') <- runPrsE px s'
    return (f x, s'')

instance Monad PrsE where
    -- (>>=) :: PrsE a -> (a -> PrsE b) -> PrsE b
    m >>= f = PrsE $ \s -> do -- Either's monad
        (a, s') <- runPrsE m s
        runPrsE (f a) s'

    -- This is not a recursive defenition,
    -- thus (>>=) at the right part is for Either's monad
    -- m >>= f = PrsE $ \s -> runPrsE m s >>= \(a, s') -> runPrsE (f a) s'


satisfyE :: (Char -> Bool) -> PrsE Char
satisfyE p = PrsE $ \case
    ""     -> Left "unexpected end of input"
    (c:cs) -> if p c
        then Right (c, cs)
        else Left $ "unexpected " ++ [c]
        
charE :: Char -> PrsE Char
charE c = satisfyE (== c)
