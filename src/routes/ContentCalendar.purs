module ContentCalendar where

import Prelude

import Data.Array (length, (..), index, snoc, deleteAt, updateAt)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Nullable (Nullable, toNullable)
import Data.String (take)
import Effect (Effect)
import Store (Store, StoreBundle, createStore, useStore)
import Web.Event.Event (Event, target)
import Web.HTML (window)
import Web.HTML.Window (alert)
import Web.HTML.HTMLInputElement as Input
import Web.HTML.HTMLTextAreaElement as TextArea

-- Data Types
type CompanyInfo = 
  { name :: String
  , description :: String
  , industry :: String
  }

type Persona = 
  { name :: String
  , tone :: String
  }

type Subreddit = 
  { name :: String
  , url :: String
  }

type ChatGPTQuery = 
  { topic :: String
  , prompt :: String
  }

type ScheduledPost = 
  { day :: Int
  , persona :: Persona
  , subreddit :: Subreddit
  , query :: ChatGPTQuery
  , contentDraft :: String
  }

type Post = 
  { postId :: String 
  , pSubreddit :: String 
  , pAuthor :: Persona 
  , pContent :: String 
  , pTimestamp :: String -- UTCTime as ISO String
  }

type Comment = 
  { cTargetId :: String 
  , cAuthor :: Persona 
  , cContent :: String 
  , cDelayMinutes :: Int 
  }

type FinalCalendar = 
  { fcWeekId :: String
  , fcPosts :: Array Post
  , fcComments :: Array Comment
  }

type State = 
  { company :: CompanyInfo
  , personas :: Array Persona
  , subreddits :: Array Subreddit
  , queries :: Array ChatGPTQuery
  , postsPerWeek :: Int
  , currentWeek :: Int
  , calendar :: Maybe FinalCalendar
  , activeTab :: String
  }

data Action 
  = UpdateCompanyName String
  | UpdateCompanyDesc String
  | UpdateCompanyIndustry String
  | AddPersona
  | UpdatePersonaName Int String
  | UpdatePersonaTone Int String
  | RemovePersona Int
  | AddSubreddit
  | UpdateSubredditName Int String
  | RemoveSubreddit Int
  | AddQuery
  | UpdateQueryTopic Int String
  | UpdateQueryPrompt Int String
  | RemoveQuery Int
  | SetPostsPerWeek Int
  | GenerateCalendar
  | NextWeek
  | SetActiveTab String

-- DOM Helpers
getInputValue :: Event -> Effect String
getInputValue e = do
  let t = target e
  case t of
     Nothing -> pure ""
     Just et -> do
       case Input.fromEventTarget et of
         Just input -> Input.value input
         Nothing -> case TextArea.fromEventTarget et of
             Just text -> TextArea.value text
             Nothing -> pure ""

handleInput :: (String -> Action) -> Event -> Effect Unit
handleInput toAction e = do
  val <- getInputValue e
  void $ storeBundle.dispatch (toAction val)

handleInputIndex :: (Int -> String -> Action) -> Int -> Event -> Effect Unit
handleInputIndex toAction i e = do
  val <- getInputValue e
  void $ storeBundle.dispatch (toAction i val)

-- Logic
generatePosts :: Int -> Int -> State -> Array Post
generatePosts weekNum count state = 
  let
    getPersona i = fromMaybe { name: "Default", tone: "Neutral" } (index state.personas (i `mod` (max 1 (length state.personas))))
    getSubreddit i = fromMaybe { name: "r/all", url: "" } (index state.subreddits (i `mod` (max 1 (length state.subreddits))))
    getQuery i = fromMaybe { topic: "General", prompt: "Write something" } (index state.queries (i `mod` (max 1 (length state.queries))))
    indices = 0 .. (count - 1)
  in
    map (\i -> 
      { postId: "post-" <> show weekNum <> "-" <> show i
      , pSubreddit: (getSubreddit i).name
      , pAuthor: getPersona i
      , pContent: "Draft for " <> (getQuery i).topic <> " (Week " <> show weekNum <> ")"
      , pTimestamp: "2026-01-0" <> show ((i `mod` 7) + 1) <> "T10:00:00Z" -- Mock Timestamp
      }
    ) indices

initialData :: State
initialData = 
  { company: 
      { name: "OGTool"
      , description: "Automated Reddit growth platform."
      , industry: "Marketing"
      }
  , personas: 
      [ { name: "Founder Frank", tone: "Professional" }
      , { name: "Growth Greg", tone: "Casual" } 
      ]
  , subreddits: 
      [ { name: "SaaS", url: "https://reddit.com/r/SaaS" } 
      , { name: "startups", url: "https://reddit.com/r/startups" }
      ]
  , queries: 
      [ { topic: "Launch Story", prompt: "How we launched." }
      , { topic: "Mistakes", prompt: "Common mistakes." }
      ]
  , postsPerWeek: 5
  , currentWeek: 1
  , calendar: Nothing
  , activeTab: "settings"
  }

initialState :: State
initialState = 
  let posts = generatePosts initialData.currentWeek initialData.postsPerWeek initialData
  in initialData { calendar = Just { fcWeekId: "week-1", fcPosts: posts, fcComments: [] } }

reducer :: State -> Action -> State
reducer state action = case action of
  UpdateCompanyName n -> state { company = state.company { name = n } }
  UpdateCompanyDesc d -> state { company = state.company { description = d } }
  UpdateCompanyIndustry i -> state { company = state.company { industry = i } }
  
  AddPersona -> state { personas = snoc state.personas { name: "", tone: "" } }
  UpdatePersonaName i n -> 
    let update p = p { name = n }
    in state { personas = fromMaybe state.personas (updateAt i (update (fromMaybe {name:"", tone:""} (index state.personas i))) state.personas) }
  UpdatePersonaTone i t -> 
    let update p = p { tone = t }
    in state { personas = fromMaybe state.personas (updateAt i (update (fromMaybe {name:"", tone:""} (index state.personas i))) state.personas) }
  RemovePersona i -> state { personas = fromMaybe state.personas (deleteAt i state.personas) }
  
  AddSubreddit -> state { subreddits = snoc state.subreddits { name: "", url: "" } }
  UpdateSubredditName i n -> 
    let update s = s { name = n }
    in state { subreddits = fromMaybe state.subreddits (updateAt i (update (fromMaybe {name:"", url:""} (index state.subreddits i))) state.subreddits) }
  RemoveSubreddit i -> state { subreddits = fromMaybe state.subreddits (deleteAt i state.subreddits) }
  
  AddQuery -> state { queries = snoc state.queries { topic: "", prompt: "" } }
  UpdateQueryTopic i t -> 
    let update q = q { topic = t }
    in state { queries = fromMaybe state.queries (updateAt i (update (fromMaybe {topic:"", prompt:""} (index state.queries i))) state.queries) }
  UpdateQueryPrompt i p -> 
    let update q = q { prompt = p }
    in state { queries = fromMaybe state.queries (updateAt i (update (fromMaybe {topic:"", prompt:""} (index state.queries i))) state.queries) }
  RemoveQuery i -> state { queries = fromMaybe state.queries (deleteAt i state.queries) }
  
  SetPostsPerWeek n -> state { postsPerWeek = n }
  
  GenerateCalendar -> 
    let posts = generatePosts state.currentWeek state.postsPerWeek state
    in state { calendar = Just { fcWeekId: "week-" <> show state.currentWeek, fcPosts: posts, fcComments: [] } }
    
  NextWeek -> 
    let 
      nextWeekNum = state.currentWeek + 1
      newState = state { currentWeek = nextWeekNum } 
      posts = generatePosts nextWeekNum state.postsPerWeek newState
    in newState { calendar = Just { fcWeekId: "week-" <> show nextWeekNum, fcPosts: posts, fcComments: [] } }

  SetActiveTab t -> state { activeTab = t }

storeBundle :: StoreBundle State Action
storeBundle = createStore initialState reducer

store :: Store State
store = storeBundle.store

-- Selectors
selectCompany :: Store CompanyInfo
selectCompany = useStore storeBundle _.company

selectPersonas :: Store (Array Persona)
selectPersonas = useStore storeBundle _.personas

selectSubreddits :: Store (Array Subreddit)
selectSubreddits = useStore storeBundle _.subreddits

selectQueries :: Store (Array ChatGPTQuery)
selectQueries = useStore storeBundle _.queries

selectCalendar :: Store (Nullable FinalCalendar)
selectCalendar = useStore storeBundle (\s -> toNullable s.calendar)

selectActiveTab :: Store String
selectActiveTab = useStore storeBundle _.activeTab

selectPostsPerWeek :: Store Int
selectPostsPerWeek = useStore storeBundle _.postsPerWeek

-- Event Handlers
onCompanyNameChange :: Event -> Effect Unit
onCompanyNameChange = handleInput UpdateCompanyName

onCompanyDescChange :: Event -> Effect Unit
onCompanyDescChange = handleInput UpdateCompanyDesc

onPersonaNameChange :: Int -> Event -> Effect Unit
onPersonaNameChange = handleInputIndex UpdatePersonaName

onPersonaToneChange :: Int -> Event -> Effect Unit
onPersonaToneChange = handleInputIndex UpdatePersonaTone

onSubredditNameChange :: Int -> Event -> Effect Unit
onSubredditNameChange = handleInputIndex UpdateSubredditName

onQueryTopicChange :: Int -> Event -> Effect Unit
onQueryTopicChange = handleInputIndex UpdateQueryTopic

onQueryPromptChange :: Int -> Event -> Effect Unit
onQueryPromptChange = handleInputIndex UpdateQueryPrompt

-- Simple Actions
addPersona :: Effect State
addPersona = storeBundle.dispatch AddPersona

addSubreddit :: Effect State
addSubreddit = storeBundle.dispatch AddSubreddit

addQuery :: Effect State
addQuery = storeBundle.dispatch AddQuery

generate :: Effect State
generate = storeBundle.dispatch GenerateCalendar

nextWeek :: Effect State
nextWeek = storeBundle.dispatch NextWeek

setActiveTab :: String -> Effect State
setActiveTab t = storeBundle.dispatch (SetActiveTab t)

-- View Helpers
formatTimestamp :: String -> String
formatTimestamp iso = take 10 iso

copyToClipboard :: String -> Effect Unit
copyToClipboard text = do
  w <- window
  alert ("Copied to clipboard: " <> text) w