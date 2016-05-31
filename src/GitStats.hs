{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module GitStats ( startApp ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant.HTML.Blaze
import Text.Blaze.Html5 hiding (main)
import Servant

data Page = Page
instance ToMarkup Page where
    toMarkup Page = h1 "hello world"

type API = Get '[HTML] Page

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return Page
