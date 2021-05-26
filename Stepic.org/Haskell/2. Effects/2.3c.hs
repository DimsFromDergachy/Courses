{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- Phantom types

newtype Temperature a = Temperature Double
    deriving (Eq, Fractional, Num, Show)

data Celsius
data Fahrenheit
data Kelvin

c2f :: Temperature Celsius -> Temperature Fahrenheit
c2f (Temperature c) = Temperature (1.8 * c + 32)

f2c :: Temperature Fahrenheit -> Temperature Celsius
f2c (Temperature c) = Temperature ((c - 32) / 1.8)

k2c :: Temperature Celsius -> Temperature Kelvin
k2c (Temperature c) = Temperature (c - 273.15)

freeze :: Temperature Celsius
freeze = Temperature 0.0

--  c2f freeze ==> OK: Temperature 32.0
--  f2c freeze ==> Fail: Couldn't match type ‘Celsius’ with ‘Fahrenheit’