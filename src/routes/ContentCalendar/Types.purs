module ContentCalendar.Types 
  ( Persona, CompanyInfo, Author, Post, Comment, FinalCalendar
  , PostWithComments, RequestPayload, State, Action(..)
  , personas, company, keywords
  ) where

import Data.Maybe (Maybe)

type Persona = { pName :: String, pInfo :: String }

type CompanyInfo = 
  { name :: String
  , website :: String
  , description :: String
  , subreddits :: Array String
  , postsPerWeek :: Int
  }

-- Backend Integration Types (Outputs)
type Author = { pName :: String, pInfo :: String }
type Post = { postId :: String, pSubreddit :: String, pAuthor :: Author, pContent :: String, pTimestamp :: String }
type Comment = { cTargetId :: String, cAuthor :: Author, cContent :: String, cDelayMinutes :: Int }
type FinalCalendar = { fcWeekId :: String, fcPosts :: Array Post, fcComments :: Array Comment }

type PostWithComments = { post :: Post, comments :: Array Comment }

type RequestPayload = 
  { reqWeekIndex :: Int
  , reqSubreddits :: Array String
  , reqKeywords :: Array String
  , reqPostsPerWeek :: Int
  , reqPersonas :: Array Persona
  }

type State = 
  { company :: CompanyInfo
  , personas :: Array Persona
  , keywords :: Array String
  , selectedSubreddits :: Array String
  , selectedKeywords :: Array String
  , selectedPersonas :: Array String
  , currentWeek :: Int
  , calendar :: Maybe FinalCalendar
  , activeTab :: String
  , loading :: Boolean
  }

data Action 
  = ToggleSubreddit String
  | ToggleKeyword String
  | TogglePersona String
  | SetCalendar FinalCalendar
  | SetLoading Boolean
  | NextWeek
  | PrevWeek
  | SetActiveTab String
  | UpdateCompanyName String
  | UpdateCompanyDesc String
  | UpdatePostsPerWeek Int
  | UpdateKeywords String

-- --- Defaults ---

personas :: Array Persona
personas =
  [ { pName: "Riley Hart", pInfo: "Head of Operations at a SaaS startup. A perfectionist who became the unofficial owner of every internal deck. He uses Slideforge because misaligned headers drive him crazy, and it allows him to focus on the narrative spine of the company rather than formatting adjustments." }
  , { pName: "Jordan Brooks", pInfo: "Independent Consultant for early-stage founders. A natural storyteller who needs slides that match the high quality of his strategic thinking. He uses Slideforge to instantly create clean flows that allow his story to land with clients without hitting a 'design wall'." }
  , { pName: "Emily Chen", pInfo: "Economics student and the 'unofficial slide maker' for every group project. She is overcommitted and tired of tweaking fonts at 1am. She uses Slideforge to turn outlines into professional slides instantly so she can actually sleep." }
  , { pName: "Alex Ramirez", pInfo: "Head of Sales at a mid-market SaaS company. Believes in showing up sharp and winning enterprise deals. He uses Slideforge to ensure his entire team's pitch decks look consistent and polished, rather than having reps create messy, unbranded slides." }
  , { pName: "Priya Nandakumar", pInfo: "Product Manager who translates between engineering, design, and leadership. She uses Slideforge to visualize complex roadmaps and dependencies clearly, making her stories feel honest and digestible without draining her energy on design." }
  , { pName: "Marcus Thorne", pInfo: "Growth Lead at a fintech scale-up. Obsessed with metrics and high-velocity experimentation. He uses Slideforge to quickly turn data insights into investor-ready decks without wasting his team's bandwidth." }
  , { pName: "Sarah Jenkins", pInfo: "Non-profit Director. Needs to inspire donors and communicate complex impact stories on a tight budget. She uses Slideforge because it makes her look professional and established, helping her secure critical funding." }
  , { pName: "David Ko", pInfo: "Freelance Software Architect. Explains complex technical systems to non-technical stakeholders. He uses Slideforge to create clear, logical diagrams and flows that bridge the communication gap." }
  ]

company :: CompanyInfo
company =
  { name: "Slideforge.ai"
  , website: "https://slideforge.ai"
  , description: "Slideforge is an AI-powered presentation and storytelling tool that turns outlines or rough notes into polished, professional slide decks. It supports exporting to PowerPoint, Google Slides, and PDF, offers branded templates, and provides an API for developers to integrate slide generation."
  , subreddits: ["r/PowerPoint", "r/GoogleSlides", "r/consulting", "r/marketing", "r/entrepreneur", "r/startups", "r/smallbusiness", "r/business", "r/productivity", "r/AskAcademia", "r/teachers", "r/education", "r/Canva", "r/ChatGPT", "r/ChatGPTPro", "r/ClaudeAI", "r/artificial", "r/design", "r/contentcreation", "r/presentations"]
  , postsPerWeek: 3
  }

keywords :: Array String
keywords = [ "best ai presentation maker", "ai slide deck tool", "pitch deck generator", "alternatives to PowerPoint", "how to make slides faster", "design help for slides", "Canva alternative for presentations", "Claude vs Slideforge", "best tool for business decks", "automate my presentations", "need help with pitch deck", "tools for consultants", "tools for startups", "best ai design tool", "Google Slides alternative", "best storytelling tool" ]