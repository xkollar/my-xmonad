{-# LANGUAGE NoImplicitPrelude #-}
module My.XMonad.Config.LTH where

import Prelude (String)

import Control.Monad (return)
import Data.List ((++))

import Language.Haskell.TH
    ( Q
    , Exp(AppE, ConE, LamE, RecUpdE, VarE)
    , Pat(VarP)
    , Body(NormalB)
    , Clause(Clause)
    , Dec(FunD)
    , mkName
    )

genL :: String -> Q [Dec]
genL accessor = return
    [ FunD a
        [ Clause []
            (NormalB (l
                `AppE` VarE xa
                `AppE` LamE
                    [VarP x, VarP c]
                    (RecUpdE (VarE c) [(xa, VarE x)])
                )
            )
            []
        ]
    ]
    where
    a = mkName accessor
    xa = mkName ("X." ++ accessor)
    l = ConE (mkName "L")
    x = (mkName "x")
    c = (mkName "c")

