-- Pointed - aka singleton, return, unit, point

import Prelude hiding (pure)

class Functor f => Pointed f where
  pure :: a - f a

instance Pointed Maybe where
  pure x = Just x

instance Pointed [] where
  pure x = [x]

instance Pointed (Either e) where
  pure x = Right x

instance Pointed ((-) e) where
  pure x = const x

instance Monoid s = Pointed ((,) s) where
  pure x = (mempty , x)

-- Law:
-- fmap g (pure x) === pure (g x)