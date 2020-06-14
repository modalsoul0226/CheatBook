{- Demos for the State data type. -}
import Control.Monad (ap)


-------------------------------------------------------------------------------
-- Core State implementation
-------------------------------------------------------------------------------
data State s a = State (s -> (a, s))

get :: State s s
get = State $ \state -> (state, state)

put :: s -> State s ()
put x = State $ \state -> ((), x)

runState :: State s a -> s -> (a, s)
runState (State f) init = f init


{-
Sample code to model:

x = 10000
...
x = num
x = x * 2
return "Final result: " + str(x)
-}
example :: Int -> State Int String
example num = State $ \s0 ->
    let (result1, s1) = runState (put num) s0
        (result2, s2) = runState get s1
        (result3, s3) = runState (put (result2 * 2)) s2
        (result4, s4) = runState get s3
    in
        ("Final result: " ++ show result4, s4)


example2 :: Int -> State Int String
example2 num =
    put num >>= \result1 ->
    get >>= \result2 ->
    put (result2 * 2) >>= \result3 ->
    get >>= \result4 ->
    return ("Final result: " ++ show result4)


-- do notation version
example3 :: Int -> State Int String
example3 num = do
    _       <- put num
    result2 <- get
    _       <- put (result2 * 2)
    result4 <- get
    return ("Final result: " ++ show result4)


instance Monad (State s) where
    -- (>>=) :: State s a -> (a -> State s b) -> State s b
    (>>=) op1 opMaker = State $ \s0 ->
        let (result1, s1) = runState op1 s0
            op2 = opMaker result1
            (result2, s2) = runState op2 s1
        in
            (result2, s2)
    -- return :: a -> State s a
    return x = State $ \s0 -> (x, s0)


-------------------------------------------------------------------------------
-- Postorder labelling
-------------------------------------------------------------------------------
data BTree a = Empty | BTree a (BTree a) (BTree a)
             deriving Show

sampleTree :: BTree String
sampleTree =
    BTree "A"
      (BTree "B"
        (BTree "D"
          (BTree "H" Empty Empty)
          (BTree "I" Empty Empty))
        (BTree "E"
          (BTree "J" Empty Empty)
          Empty))
      (BTree "C"
        (BTree "F" Empty Empty)
        (BTree "G" Empty Empty))


-- | Post-order labelling of a tree.
postOrderLabel :: BTree a -> State Int (BTree Int)
postOrderLabel Empty = return Empty         -- State (\state -> (Empty, state))
postOrderLabel (BTree root left right) =
    postOrderLabel left >>= \newLeft ->
    postOrderLabel right >>= \newRight ->
    get >>= \i ->
    (let newTree = BTree i newLeft newRight
     in
        put (i + 1) >>= \_ ->
        return newTree                      -- State (\state -> (newTree, state))
    )


-- | Do notation version. (Note the syntax for "let".)
postOrderLabel1 :: BTree a -> State Int (BTree Int)
postOrderLabel1 Empty = return Empty
postOrderLabel1 (BTree root left right) = do
    newLeft <- postOrderLabel1 left
    newRight <- postOrderLabel1 right
    i <- get
    let newTree = BTree i newLeft newRight
    _ <- put (i + 1)
    return newTree


-------------------------------------------------------------------------------
-- These are technically required to make a type an instance of Monad.
-- We *aren't* covering Applicative in this course.
instance Functor (State s) where
    -- fmap :: (a -> b) -> State s a -> State s b
    fmap f op = State $ \s0->
        let (x, s1) = runState op s0
        in
            (f x, s1)

instance Applicative (State s) where
    pure = return
    (<*>) = ap
