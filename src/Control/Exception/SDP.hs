module Control.Exception.SDP
(
  module Control.Exception,
  IndexException (..)
)
where

import Prelude ((++))
import SDP.SafePrelude

import Control.Exception
import Data.Typeable

--------------------------------------------------------------------------------

{-
    Exception type IndexException replaces the less informative ArrayException
    and has more neutral names in relation to other indexable structures.
  NOTE:
    If the index can overflow and underflow at the same time,
    it is recommended to indicate in the documentation.
-}

data IndexException = UndefinedValue  String
                    | EmptyRange      String
                    | IndexUnderflow  String
                    | IndexOverflow   String
  deriving (Eq, Typeable)

instance Show IndexException
  where
    show (UndefinedValue  s) = "undefined element "        ++ s
    show (EmptyRange      s) = "empty range "              ++ s
    show (IndexOverflow   s) = "index out of upper bound " ++ s
    show (IndexUnderflow  s) = "index out of lower bound " ++ s

instance Exception IndexException

--------------------------------------------------------------------------------
