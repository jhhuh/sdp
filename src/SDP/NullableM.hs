{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies, ConstraintKinds #-}

{- |
    Module      :  SDP.NullableM
    Copyright   :  (c) Andrey Mulik 2021
    License     :  BSD-style
    Maintainer  :  work.a.mulik@gmail.com
    Portability :  non-portable (GHC extensions)
    
    "SDP.NullableM" provides 'NullableM' - class of types with empty values.
-}
module SDP.NullableM
(
  -- * Monadic nullable
  NullableM (..), NullableM1, NullableM2
)
where

default ()

--------------------------------------------------------------------------------

-- | @since 0.3 'NullableM' is class of types which value may be empty.
class (Monad m) => NullableM m e | e -> m
  where
    -- | Monadic 'SDP.Nullable.lzero'.
    newNull :: m e
    
    -- | Monadic 'SDP.Nullable.isNull'.
    nowNull :: e -> m Bool

--------------------------------------------------------------------------------

-- | @since 0.3 @(* -> *)@ kind 'NullableM'.
type NullableM1 m rep e = NullableM m (rep e)

-- | @since 0.3 @(* -> * -> *)@ kind 'NullableM'.
type NullableM2 m rep i e = NullableM m (rep i e)

