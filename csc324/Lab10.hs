{- CSC324 Fall 2018 Lab 10 -}

module Lab10 where


-- |
-- = Task 1
mapMaybes :: (a -> b) -> [Maybe a] -> [Maybe b]
mapMaybes f ms = map (\m -> m >>= (\a -> return (f a))) ms 

-- mapMaybes (\x -> x + 1) [Just 1, Just 2, Nothing]

composeMaybe :: (a -> Maybe b) -> (b -> Maybe c) -> (a -> Maybe c)
composeMaybe f g = (\a -> f a >>= (\b -> g b))

-- composeMaybe (\x -> Just "String") (\b -> Just ("Another " ++ b)) 1

foldMaybe :: (b -> a -> Maybe b) -> b -> [a] -> Maybe b
foldMaybe f init lst = (foldl (\mb a -> mb >>= (\b -> (f b a)))
                             (return init)
                             lst)

-- foldMaybe (\b a -> Just (b + a)) 0 [1, 2, 3]

applyBinaryMaybe :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
applyBinaryMaybe f ma mb = ma >>= \a ->
                           mb >>= \b ->
                           return (f a b) 

-- applyBinaryMaybe (\a b -> a + b) (Just 1) (Just 2)

collectMaybes :: [Maybe a] -> Maybe [a]
collectMaybes [] = return []
collectMaybes (m:ms) = m >>= \x ->
                       collectMaybes ms >>= \xs ->
                       return (x:xs)  

-- collectMaybes [Just 1, Just 2, Just 3]

-- |
-- = Task 2
mapF :: Functor f => (a -> b) -> [f a] -> [f b]
mapF f ms = map (\fa -> fmap f fa) ms 

composeM :: Monad m => (a -> m b) -> (b -> m c) -> (a -> m c)
composeM f g = (\a -> f a >>= (\b -> g b))

foldM :: Monad m => (b -> a -> m b) -> b -> [a] -> m b
foldM f init lst = (foldl (\mb a -> mb >>= (\b -> (f b a)))
                          (return init)
                          lst)

applyBinaryM :: Monad m => (a -> b -> c) -> m a -> m b -> m c
applyBinaryM f ma mb = ma >>= \a ->
                       mb >>= \b ->
                       return (f a b) 

collectM :: Monad m => [m a] -> m [a]
collectM [] = return []
collectM (m:ms) = m >>= \x ->
                  collectM ms >>= \xs ->
                  return (x:xs)  
