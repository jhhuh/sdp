{-# LANGUAGE Trustworthy, PatternSynonyms, ViewPatterns, ConstraintKinds #-}
{-# LANGUAGE CPP, MagicHash, DefaultSignatures #-}

{- |
    Module      :  SDP.Nullable
    Copyright   :  (c) Andrey Mulik 2020
    License     :  BSD-style
    Maintainer  :  work.a.mulik@gmail.com
    Portability :  non-portable (GHC extensions)
    
    "SDP.Nullable" provides 'Nullable' - class of types with empty values.
-}
module SDP.Nullable
(
  -- * Nullable
  Nullable (..), Nullable1, Nullable2, pattern NULL
)
where

import Foreign.Ptr

import GHC.ForeignPtr
import GHC.Stable
import GHC.Base
import GHC.Exts

import Control.Exception.SDP

default ()

--------------------------------------------------------------------------------

-- | 'Nullable' is class of types which value may be empty.
class Nullable e
  where
    -- | Empty value.
    lzero  :: e
    
    -- | Is value empty? Has default since @0.2.1@
    default isNull :: (Eq e) => e -> Bool
    isNull :: e -> Bool
    isNull =  (== lzero)

-- | @since 0.2.1 @(* -> *)@ kind 'Nullable' structure.
type Nullable1 rep e = Nullable (rep e)

-- | @since 0.3 @(* -> * -> *)@ kind 'Nullable' structure.
type Nullable2 rep e = Nullable (rep e)

-- | Originally defined in @sdp-ctypes@ (now @sdp-foreign@), same as @Z@ now.
pattern NULL :: (Nullable e) => e
pattern NULL <- (isNull -> True) where NULL = lzero

--------------------------------------------------------------------------------

-- | @since 0.2.1
instance Nullable ()
  where
    isNull = const True
    lzero  = ()

instance Nullable (Maybe e)
  where
    isNull = \ mx -> case mx of {Nothing -> True; _ -> False}
    lzero  = Nothing

instance Nullable [e]
  where
    isNull = null
    lzero  = []

instance Nullable (Ptr e)
  where
    lzero = nullPtr

-- Stolen from @bytestring@ package.
instance Nullable (ForeignPtr e)
  where
#if __GLASGOW_HASKELL__ >= 811
    lzero = ForeignPtr nullAddr# FinalPtr
#else
    lzero = ForeignPtr nullAddr# (throw $ UnreachableException "in SDP.Nullable.lzero :: ForeignPtr e")
#endif
    isNull (ForeignPtr addr# _) = Ptr addr# == nullPtr

instance Nullable (StablePtr e)
  where
    lzero  = StablePtr (unsafeCoerce# 0#)

-- | @since 0.2.1
instance Nullable (FunPtr e)
  where
    lzero  = nullFunPtr


