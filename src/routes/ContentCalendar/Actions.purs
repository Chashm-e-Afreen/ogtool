module ContentCalendar.Actions 
  ( toggleSubreddit, toggleKeyword, togglePersona, setActiveTab
  , onCompanyNameChange, onCompanyDescChange, onPostsPerWeekChange, onKeywordsChange, fetchCalendar
  , generate, nextWeek, prevWeek, setPostsPerWeek, setKeywords, copyToClipboard, saveAndGenerate
  ) where

import Prelude

import ContentCalendar.Store (storeBundle)
import ContentCalendar.Types (Action(..), FinalCalendar, Persona)
import Data.Array (filter, elem)
import Data.Either (Either(..))
import Data.HTTP.Method (Method(..))
import Data.Int as Int
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Fetch (fetch)
import Store (readStore)
import Web.Event.Event (Event)
import Web.Event.Event as Event
import Web.HTML (window)
import Web.HTML.Window (alert)
import Web.HTML.HTMLInputElement as Input
import Web.HTML.HTMLTextAreaElement as TextArea
import Yoga.JSON (readJSON, writeJSON)

toggleSubreddit :: String -> Effect Unit
toggleSubreddit s = void $ storeBundle.dispatch (ToggleSubreddit s)

toggleKeyword :: String -> Effect Unit
toggleKeyword k = void $ storeBundle.dispatch (ToggleKeyword k)

togglePersona :: String -> Effect Unit
togglePersona p = void $ storeBundle.dispatch (TogglePersona p)

setActiveTab :: String -> Effect Unit
setActiveTab t = void $ storeBundle.dispatch (SetActiveTab t)

onCompanyNameChange :: Event -> Effect Unit
onCompanyNameChange e = do
  case (Event.target e >>= Input.fromEventTarget) of
    Just input -> do
      val <- Input.value input
      void $ storeBundle.dispatch (UpdateCompanyName val)
    Nothing -> pure unit

onCompanyDescChange :: Event -> Effect Unit
onCompanyDescChange e = do
  case (Event.target e >>= TextArea.fromEventTarget) of
    Just area -> do
      val <- TextArea.value area
      void $ storeBundle.dispatch (UpdateCompanyDesc val)
    Nothing -> pure unit

onPostsPerWeekChange :: Event -> Effect Unit
onPostsPerWeekChange e = do
  case (Event.target e >>= Input.fromEventTarget) of
    Just input -> do
      valStr <- Input.value input
      case Int.fromString valStr of
        Just n -> setPostsPerWeek n
        Nothing -> pure unit
    Nothing -> pure unit

onKeywordsChange :: Event -> Effect Unit
onKeywordsChange e = do
  case (Event.target e >>= TextArea.fromEventTarget) of
    Just area -> do
      val <- TextArea.value area
      setKeywords val
    Nothing -> pure unit

fetchCalendar :: Int -> Array String -> Array String -> Int -> Array Persona -> Effect Unit
fetchCalendar week subs kws ppw pers = do
  void $ storeBundle.dispatch (SetLoading true)
  launchAff_ do
    let payload = { reqWeekIndex: week, reqSubreddits: subs, reqKeywords: kws, reqPostsPerWeek: ppw, reqPersonas: pers }
    resp <- fetch "http://localhost:3000/generate-week" 
              { method: POST
              , body: writeJSON payload
              , headers: { "Content-Type": "application/json" }
              }
    text <- resp.text
    case readJSON text of
       Right (c :: FinalCalendar) -> liftEffect $ void $ storeBundle.dispatch (SetCalendar c)
       Left _ -> liftEffect $ void $ storeBundle.dispatch (SetLoading false)

generate :: Effect Unit
generate = do
  state <- readStore storeBundle.store
  let selectedPers = filter (\p -> p.pName `elem` state.selectedPersonas) state.personas
  fetchCalendar state.currentWeek state.selectedSubreddits state.selectedKeywords state.company.postsPerWeek selectedPers

nextWeek :: Effect Unit
nextWeek = do
  void $ storeBundle.dispatch NextWeek
  generate

prevWeek :: Effect Unit
prevWeek = do
  void $ storeBundle.dispatch PrevWeek
  generate

setPostsPerWeek :: Int -> Effect Unit
setPostsPerWeek n = void $ storeBundle.dispatch (UpdatePostsPerWeek n)

setKeywords :: String -> Effect Unit
setKeywords s = void $ storeBundle.dispatch (UpdateKeywords s)

copyToClipboard :: String -> Effect Unit
copyToClipboard text = do
  w <- window
  alert ("Copied to clipboard: " <> text) w

saveAndGenerate :: Effect Unit
saveAndGenerate = do
  generate
  setActiveTab "calendar"