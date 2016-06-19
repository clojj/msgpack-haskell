{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad.Trans

import           Network.MessagePack.Client
import           Network.MessagePack.Server

main :: IO ()
main = 
  serveUnix "/tmp/node.msgpack.rpc.sock"
    [ method "add"  add
    , method "echo" echo
    ]
  where

    add :: Int -> Int -> Server Int
    add x y = do 
      liftIO $ print $ "x: " ++ show x ++ ", y: " ++ show y 
      return $ x + y

    echo :: String -> Server String
    echo s = do
      liftIO $ print s 
      return $ "***" ++ s ++ "***"
