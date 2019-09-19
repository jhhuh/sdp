module Main where

import Test.Framework
import Test.Framework.Providers.QuickCheck2

import SDP.Unrolled.Unlist

import Test.SDP.Estimate
import Test.SDP.Indexed
import Test.SDP.Linear
import Test.SDP.Sort
import Test.SDP.Set

import Test.SDP.Eq

default ()

--------------------------------------------------------------------------------

main :: IO ()
main = defaultMain
  [
    -- common tests
    testProperty "unlist-eq             " eqProp,
    
    -- linear tests
    testProperty "unlist-linear-basic   " basicLinearProp,
    testProperty "unlist-linear-decons  " deconstructionLinearProp,
    testProperty "unlist-linear-cons    " constructionLinearProp,
    testProperty "unlist-linear-reverse " reverseProp,
    testProperty "unlist-linear-concat  " concatProp,
    
    -- split test
    testProperty "unlist-split          " splitProp,
    
    -- indexed tests
    testProperty "unlist-indexed-basic  " basicIndexedProp,
    testProperty "unlist-indexed-assoc  " assocIndexedProp,
    testProperty "unlist-indexed-read   " readIndexedProp,
    
    -- sort test
    testProperty "unlist-sort           " sortProp,
    
    -- set test
    testProperty "unlist-set            " setProp,
    
    -- estimate test
    testProperty "unlist-estimate       " estimateProp
  ]

--------------------------------------------------------------------------------

{- Eq property. -}

eqProp :: TestEq (Unlist Int)
eqProp =  eqTest

--------------------------------------------------------------------------------

{- Linear properties. -}

basicLinearProp          :: Char -> Unlist Char -> Bool
basicLinearProp          =  basicLinearTest

deconstructionLinearProp :: Unlist Char -> Bool
deconstructionLinearProp =  deconstructionLinearTest

constructionLinearProp   :: Char -> Unlist Char -> Bool
constructionLinearProp   =  constructionLinearTest

reverseProp              :: Unlist Char -> Bool
reverseProp              =  reverseTest

replicateProp            :: TestLinear1 Unlist Char
replicateProp            =  replicateTest

concatProp               :: Unlist Char -> Bool
concatProp               =  concatTest

--------------------------------------------------------------------------------

{- Split property. -}

splitProp :: TestSplit1 Unlist Char
splitProp =  splitTest

--------------------------------------------------------------------------------

{- Indexed property. -}

basicIndexedProp :: TestIndexed1 Unlist Int Char
basicIndexedProp =  basicIndexedTest

assocIndexedProp :: TestIndexed1 Unlist Int Char
assocIndexedProp =  assocIndexedTest

readIndexedProp  :: TestIndexed1 Unlist Int Char
readIndexedProp  =  readIndexedTest

--------------------------------------------------------------------------------

{- Sort property. -}

sortProp :: Unlist Char -> Bool
sortProp =  sortTest

--------------------------------------------------------------------------------

{- Set property. -}

setProp :: TestSet1 Unlist Char
setProp =  setTest

--------------------------------------------------------------------------------

{- Estimate property. -}

estimateProp :: TestEstimate (Unlist Int)
estimateProp =  estimateTest



