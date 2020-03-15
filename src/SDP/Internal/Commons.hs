{-
  NOTE: This is an internal module for typical functions and imports.
  Its contents may be changed or removed without reference to the changelog.
-}
module SDP.Internal.Commons
(
  module Control.Exception.SDP,
  
  module Data.Function,
  module Data.Default,
  module Data.Maybe,
  module Data.Bool,
  module Data.Ord,
  module Data.Eq,
  
  Bounded (..), Enum (..),
  
  fst, snd, fsts, snds, both,
  
  (?>), bindM2, bindM3, bindM4, (>>=>), (<=<<)
)

where

import Prelude ()
import SDP.SafePrelude

import Control.Exception.SDP

import Data.Function
import Data.Default
import Data.Maybe
import Data.Bool
import Data.Ord
import Data.Eq

default ()

--------------------------------------------------------------------------------

fsts :: (Functor f) => f (a, b) -> f a
fsts =  fmap fst

snds :: (Functor f) => f (a, b) -> f b
snds =  fmap snd

both :: (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
both =  \ f g h a -> g a `f` h a

--------------------------------------------------------------------------------

-- Monadic conditional toMaybe.
(?>) :: (Monad m) => (a -> m Bool) -> (a -> m b) -> a -> m (Maybe b)
p ?> f = \ a -> p a >>= \ b -> if b then Just <$> f a else return Nothing

-- Composition of liftM2 and join.
bindM2 :: (Monad m) => m a -> m b -> (a -> b -> m c) -> m c
bindM2 ma mb kl2 = join $ liftM2 kl2 ma mb

-- Composition of liftM3 and (>>=).
bindM3 :: (Monad m) => m a -> m b -> m c -> (a -> b -> c -> m d) -> m d
bindM3 ma mb mc kl3 = join $ liftM3 kl3 ma mb mc

-- Composition of liftM4 and (>>=).
bindM4 :: (Monad m) => m a -> m b -> m c -> m d -> (a -> b -> c -> d -> m e) -> m e
bindM4 ma mb mc md kl4 = join $ liftM4 kl4 ma mb mc md

(>>=>) :: (Monad m) => (a -> b -> m c) -> (c -> m d) -> a -> b -> m d
k1 >>=> k2 = (>=> k2) . k1

(<=<<) :: (Monad m) => (c -> m d) -> (a -> b -> m c) -> a -> b -> m d
k2 <=<< k1 = (>>= k2) ... k1



