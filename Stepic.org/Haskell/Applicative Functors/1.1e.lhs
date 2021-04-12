Applicative Funtors Laws:

1. Identity:
    pure id <*> v === v

2. Homomorphism
    pure f <*> pure x === pure (f x)

3. Interchange
    cont <*> pure x === pure ($ x) <*> cont

4. Composition
    pure (.) <*> u <*> v <*> cont === u <*> (v <*> cont)
