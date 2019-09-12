{- |
    Module      :  Test.SDP.Sort
    Copyright   :  (c) Andrey Mulik 2019
    License     :  BSD-style
    Maintainer  :  work.a.mulik@gmail.com
    Portability :  non-portable (imports SDP.Linear).
    
    Test.SDP.Sort provides simple test for SDP.Sort class.
-}
module Test.SDP.Sort ( sortTest ) where

import Prelude ()
import SDP.SafePrelude

import SDP.Linear
import SDP.Sort

default ()

--------------------------------------------------------------------------------

-- | sortTest is just sorted . sort synonym.
sortTest :: (Sort s e, Linear s e, Ord e) => s -> Bool
sortTest =  sorted . sort

