{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module GitStats ( startApp ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Servant.HTML.Blaze
import Servant.Utils.StaticFiles
import Text.Blaze.Html5 hiding (main)

data Page = Page
instance ToMarkup Page where
    toMarkup Page = h1 "hello world"

type GsApi = "hello" :> Get '[HTML] Page
        :<|> Raw

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy GsApi
api = Proxy

server :: Server GsApi
server = return Page
      :<|> serveDirectory "/var/www/repos/gitstats"
