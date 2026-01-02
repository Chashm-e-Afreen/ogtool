module ContentCalendar.State (initialState, reducer) where

import Prelude
import Data.Array (filter, snoc, elem)
import Data.Maybe (Maybe(..))
import Data.String (trim)
import Data.String.Common (split)
import Data.String.Pattern (Pattern(..))
import ContentCalendar.Types (Action(..), State, company, personas, keywords)

initialState :: State
initialState = 
  { company
  , personas
  , keywords
  , selectedSubreddits: ["r/startups", "r/marketing"]
  , selectedKeywords: ["pitch deck generator", "automate my presentations"]
  , selectedPersonas: ["Riley Hart", "Jordan Brooks", "Emily Chen"]
  , currentWeek: 1
  , calendar: Nothing
  , activeTab: "settings"
  , loading: false
  }

reducer :: State -> Action -> State
reducer state action = case action of
  ToggleSubreddit s -> 
    if s `elem` state.selectedSubreddits
    then state { selectedSubreddits = filter (_ /= s) state.selectedSubreddits }
    else state { selectedSubreddits = snoc state.selectedSubreddits s }
  
  ToggleKeyword k -> 
    if k `elem` state.selectedKeywords
    then state { selectedKeywords = filter (_ /= k) state.selectedKeywords }
    else state { selectedKeywords = snoc state.selectedKeywords k }

  TogglePersona p -> 
    if p `elem` state.selectedPersonas
    then state { selectedPersonas = filter (_ /= p) state.selectedPersonas }
    else state { selectedPersonas = snoc state.selectedPersonas p }

  SetCalendar c -> state { calendar = Just c, loading = false }
  SetLoading b -> state { loading = b }
  NextWeek -> state { currentWeek = state.currentWeek + 1 } 
  PrevWeek -> state { currentWeek = if state.currentWeek > 1 then state.currentWeek - 1 else 1 }
  SetActiveTab t -> state { activeTab = t }
  UpdateCompanyName n -> state { company = state.company { name = n } }
  UpdateCompanyDesc d -> state { company = state.company { description = d } }
  UpdatePostsPerWeek n -> state { company = state.company { postsPerWeek = n } }
  UpdateKeywords s -> state { selectedKeywords = filter (_ /= "") $ map trim $ split (Pattern ",") s }