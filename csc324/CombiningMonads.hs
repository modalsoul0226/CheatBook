import Control.Monad (ap)
import Control.Monad.Trans (lift)
import Control.Monad.Trans.Maybe (MaybeT(..), runMaybeT)


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
data BTree a = Empty | BTree a (BTree a) (BTree a) deriving Show

-- Try changing a node value to "David"
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


-- | Version 0: original postorder labeling.
postOrderLabel :: BTree a -> State Int (BTree Int)
postOrderLabel Empty = return Empty
postOrderLabel (BTree root left right) = do
    newLeft <- postOrderLabel left
    newRight <- postOrderLabel right
    i <- get
    let newTree = BTree i newLeft newRight
    _ <- put (i + 1)
    return newTree


-------------------------------------------------------------------------------
-- Version 1: Manually unwrapping Maybes
-------------------------------------------------------------------------------
maybeLabel :: BTree String -> Maybe (BTree Int)
maybeLabel tree = fst (runState (postOrderLabelM tree) 0)


postOrderLabelM :: BTree String -> State Int (Maybe (BTree Int))
postOrderLabelM Empty = return (Just Empty)
postOrderLabelM (BTree "David" _ _) = return Nothing
postOrderLabelM (BTree root left right) = do
  newLeftMaybe <- postOrderLabelM left
  case newLeftMaybe of
    Nothing -> return Nothing
    Just newLeft -> do
      newRightMaybe <- postOrderLabelM right
      case newRightMaybe of
        Nothing -> return Nothing
        Just newRight -> do
          i <- get
          _ <- put (i + 1)
          return (Just (BTree i newLeft newRight))


-------------------------------------------------------------------------------
-- Version 2: Manually creating our own State+Maybe monad
-- Note the analogous implementations of "get", "put", and "runState".
-- A good exercise: how to implement getM, putM, and runStateM in terms of the
-- original State versions?
-------------------------------------------------------------------------------
data StateMaybe s a = StateMaybe (State s (Maybe a))

getM :: StateMaybe s s
getM = StateMaybe (State $ \state -> (Just state, state))

putM :: s -> StateMaybe s ()
putM x = StateMaybe (State $ \state -> (Just (), x))

runStateM :: StateMaybe s a -> s -> (Maybe a, s)
runStateM (StateMaybe (State f)) init = f init


instance Monad (StateMaybe s) where
  -- return :: a -> StateMaybe s a
  return x = StateMaybe (State $ \state -> (Just x, state))

  -- (>>=) :: StateMaybe s a -> (a -> StateMaybe s b)
  --       -> StateMaybe s b
  op1 >>= opMaker = StateMaybe (State $ \s0 ->
    let (xMaybe, s1) = runStateM op1 s0
    in case xMaybe of
      Nothing -> (Nothing, s1)
      Just x ->
        let op2 = opMaker x
            (y, s2) = runStateM op2 s1
        in
          (y, s2)
    )


postOrderLabelM1 :: BTree String -> StateMaybe Int (BTree Int)
postOrderLabelM1 Empty = return Empty
postOrderLabelM1 (BTree "David" _ _) = StateMaybe (return Nothing)
postOrderLabelM1 (BTree root left right) = do
  newLeft <- postOrderLabelM1 left
  newRight <- postOrderLabelM1 right
  i <- getM
  _ <- putM (i + 1)
  return (BTree i newLeft newRight)


-------------------------------------------------------------------------------
-- Version 3: Using the *monad transformer* MaybeT.
-- We don't need to define anything ourselves!
-------------------------------------------------------------------------------
postOrderLabelM2 :: BTree String -> MaybeT (State Int) (BTree Int)
postOrderLabelM2 Empty = return Empty
postOrderLabelM2 (BTree "David" _ _) = MaybeT (return Nothing)
postOrderLabelM2 (BTree _ left right) = do
  newLeft <- postOrderLabelM2 left
  newRight <- postOrderLabelM2 right
  -- Note the beauty of `lift` here. It's a very general function, used here with type
  --   lift :: State Int a -> MaybeT (State Int) a
  i <- lift get
  _ <- lift (put (i + 1))
  return (BTree i newLeft newRight)


-------------------------------------------------------------------------------
-- Functor/Applicative instances for State and StateMaybe.
-------------------------------------------------------------------------------
-- These are technically required to make a type an instance of Monad.
-- Note that we *aren't* covering Applicative in this course.
instance Functor (State s) where
  -- fmap :: (a -> b) -> State s a -> State s b
  fmap f op = State (\s ->
    let (x, s1) = runState op s
    in
        (f x, s1))

instance Applicative (State s) where
  pure = return
  (<*>) = ap



instance Functor (StateMaybe s) where
  -- fmap :: (a -> b) -> StateMaybe s a -> StateMaybe s b
  fmap f op = StateMaybe (State (\s ->
    let (x, s1) = runStateM op s
    in
        (fmap f x, s1)))

instance Applicative (StateMaybe s) where
  pure = return
  (<*>) = ap
