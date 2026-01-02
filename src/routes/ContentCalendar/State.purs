module ContentCalendar.State (initialState, reducer) where

import Prelude
import Data.Array (filter, snoc, elem, (!!), updateAt, length)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.String (trim)
import Data.String.Common (split)
import Data.String.Pattern (Pattern(..))
import ContentCalendar.Types (Action(..), State, availableCompanies, personas, keywords)

initialState :: State
initialState = 
  { companies: availableCompanies
  , selectedCompanyIndex: 0
  , personas
  , keywords
  , selectedSubreddits: fromMaybe [] $ (_.subreddits <$> (availableCompanies !! 0))
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
    then 
        if length state.selectedSubreddits > 1
        then state { selectedSubreddits = filter (_ /= s) state.selectedSubreddits }
        else state
    else state { selectedSubreddits = snoc state.selectedSubreddits s }
  
  ToggleKeyword k -> 
    if k `elem` state.selectedKeywords
    then state { selectedKeywords = filter (_ /= k) state.selectedKeywords }
    else state { selectedKeywords = snoc state.selectedKeywords k }

  TogglePersona p -> 
    if p `elem` state.selectedPersonas
    then 
        if length state.selectedPersonas > 1
        then state { selectedPersonas = filter (_ /= p) state.selectedPersonas }
        else state
    else state { selectedPersonas = snoc state.selectedPersonas p }

  SelectCompany idx -> 
    case state.companies !! idx of
      Just comp -> state { selectedCompanyIndex = idx, selectedSubreddits = comp.subreddits }
      Nothing -> state

  SetCalendar c -> state { calendar = Just c, loading = false }
  SetLoading b -> state { loading = b }
  NextWeek -> state { currentWeek = state.currentWeek + 1 } 
  PrevWeek -> state { currentWeek = if state.currentWeek > 1 then state.currentWeek - 1 else 1 }
  SetActiveTab t -> state { activeTab = t }
  
  UpdateCompanyName n -> 
    case state.companies !! state.selectedCompanyIndex of
      Just comp -> state { companies = fromMaybe state.companies $ updateAt state.selectedCompanyIndex (comp { name = n }) state.companies }
      Nothing -> state
    
  UpdateCompanyDesc d -> 
    case state.companies !! state.selectedCompanyIndex of
      Just comp -> state { companies = fromMaybe state.companies $ updateAt state.selectedCompanyIndex (comp { description = d }) state.companies }
      Nothing -> state

  UpdatePostsPerWeek n -> 
    case state.companies !! state.selectedCompanyIndex of
      Just comp -> state { companies = fromMaybe state.companies $ updateAt state.selectedCompanyIndex (comp { postsPerWeek = n }) state.companies }
      Nothing -> state

  UpdateKeywords s -> state { selectedKeywords = filter (_ /= "") $ map trim $ split (Pattern ",") s }
