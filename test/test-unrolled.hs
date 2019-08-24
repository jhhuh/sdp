module Main where

import Test.Framework
import Test.Framework.Providers.QuickCheck2

import SDP.Unrolled

import Test.SDP.Indexed
import Test.SDP.Linear
import Test.SDP.Sort

default ()

--------------------------------------------------------------------------------

main :: IO ()
main = defaultMain
  [
    -- linear tests
    testProperty "unrolled-linear-basic   " basicLinearProp,
    testProperty "unrolled-linear-decons  " deconstructionLinearProp,
    testProperty "unrolled-linear-cons    " constructionLinearProp,
    testProperty "unrolled-linear-reverse " reverseProp,
    testProperty "unrolled-linear-concat  " concatProp,
    
    -- split test
    testProperty "unrolled-split          " splitProp,
    
    -- indexed tests
    testProperty "unrolled-indexed-basic  " basicIndexedProp,
    testProperty "unrolled-indexed-assoc  " assocIndexedProp,
    testProperty "unrolled-indexed-read   " readIndexedProp,
    
    -- sort test
    testProperty "unrolled-sort           " sortProp
    
    -- set test (planned)
  ]

--------------------------------------------------------------------------------

{- Linear properties. -}

basicLinearProp          :: Char -> Unrolled Int Char -> Bool
basicLinearProp          =  basicLinearTest

deconstructionLinearProp :: Unrolled Int Char -> Bool
deconstructionLinearProp =  deconstructionLinearTest

constructionLinearProp   :: Char -> Unrolled Int Char -> Bool
constructionLinearProp   =  constructionLinearTest

reverseProp              :: Unrolled Int Char -> Bool
reverseProp              =  reverseTest

replicateProp            :: TestLinear2 Unrolled Int Char
replicateProp            =  replicateTest

concatProp               :: Unrolled Int Char -> Bool
concatProp               =  concatTest

--------------------------------------------------------------------------------

{- Split property. -}

splitProp :: TestSplit2 Unrolled Int Char
splitProp =  splitTest

--------------------------------------------------------------------------------

{- Indexed property. -}

basicIndexedProp :: TestIndexed2 Unrolled Int Char
basicIndexedProp =  basicIndexedTest

assocIndexedProp :: TestIndexed2 Unrolled Int Char
assocIndexedProp =  assocIndexedTest

readIndexedProp  :: TestIndexed2 Unrolled Int Char
readIndexedProp  =  readIndexedTest

--------------------------------------------------------------------------------

{- Sort property. -}

sortProp :: Unrolled Int Char -> Bool
sortProp =  sortTest



