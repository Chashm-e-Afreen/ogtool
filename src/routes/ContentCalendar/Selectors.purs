module ContentCalendar.Selectors 
  ( selectCompany, selectPersonas, selectKeywords, selectSelectedSubreddits
  , selectSelectedKeywords, selectSelectedPersonas, selectCalendar
  , selectActiveTab, selectLoading, selectPostsPerWeek, selectPostsWithComments
  , selectCurrentWeek, selectKeywordsString
  ) where

import Prelude
import Data.Array (filter)
import Data.Maybe (Maybe(..))
import Data.String.Common (joinWith)
import Data.Nullable (Nullable, toNullable)
import Store (Store, useStore)
import ContentCalendar.Types (CompanyInfo, Persona, FinalCalendar, PostWithComments)
import ContentCalendar.Store (storeBundle)

selectCompany :: Store CompanyInfo
selectCompany = useStore storeBundle _.company

selectPersonas :: Store (Array Persona)
selectPersonas = useStore storeBundle _.personas

selectKeywords :: Store (Array String)
selectKeywords = useStore storeBundle _.keywords

selectSelectedSubreddits :: Store (Array String)
selectSelectedSubreddits = useStore storeBundle _.selectedSubreddits

selectSelectedKeywords :: Store (Array String)
selectSelectedKeywords = useStore storeBundle _.selectedKeywords

selectSelectedPersonas :: Store (Array String)
selectSelectedPersonas = useStore storeBundle _.selectedPersonas

selectCalendar :: Store (Nullable FinalCalendar)
selectCalendar = useStore storeBundle (\s -> toNullable s.calendar)

selectActiveTab :: Store String
selectActiveTab = useStore storeBundle _.activeTab

selectLoading :: Store Boolean
selectLoading = useStore storeBundle _.loading

selectPostsPerWeek :: Store Int
selectPostsPerWeek = useStore storeBundle (\s -> s.company.postsPerWeek)

selectPostsWithComments :: Store (Array PostWithComments)
selectPostsWithComments = useStore storeBundle \s -> 
  case s.calendar of
    Nothing -> []
    Just c -> 
      map (\p -> 
        { post: p
        , comments: filter (\comm -> comm.cTargetId == p.postId) c.fcComments
        }
      ) c.fcPosts

selectCurrentWeek :: Store Int
selectCurrentWeek = useStore storeBundle _.currentWeek

selectKeywordsString :: Store String
selectKeywordsString = useStore storeBundle (\s -> joinWith ", " s.selectedKeywords)