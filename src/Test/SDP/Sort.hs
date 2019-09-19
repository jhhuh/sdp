{- |
    Module      :  Test.SDP.Sort
    Copyright   :  (c) Andrey Mulik 2019
    License     :  BSD-style
    Maintainer  :  work.a.mulik@gmail.com
    Portability :  non-portable (imports SDP.Linear).
    
    @Test.SDP.Sort@ provides simple test for 'Sort' class.
-}
module Test.SDP.Sort
  (
    -- * Default test
    sortTest
  )
where

import Prelude ()
import SDP.SafePrelude

import SDP.Linear
import SDP.Sort

default ()

--------------------------------------------------------------------------------

{- |
  sortTest is just @sorted . sort@ synonym.
  
  Please note that for default definition of Arbitrary generates very short
  structures and this isn't enough for verification (if the length of the
  structure is less than 65, then TimSort uses InsertionSort).
-}
sortTest :: (Sort s e, Linear s e, Ord e) => s -> Bool
sortTest =  sorted . sort





