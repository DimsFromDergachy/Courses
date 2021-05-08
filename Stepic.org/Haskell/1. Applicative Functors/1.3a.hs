import Text.Parsec as P

getList :: Parsec String u [String]
getList = number `P.sepBy` semicolon <* P.eof
  where
    number = P.many1 P.digit
    semicolon = P.char ';'
