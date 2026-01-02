module ContentCalendar.Helpers (formatTimestamp) where

import Data.String (take)

formatTimestamp :: String -> String
formatTimestamp iso = take 10 iso