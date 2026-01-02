module ContentCalendar.Store (store, storeBundle) where

import Store (Store, StoreBundle, createStore)
import ContentCalendar.Types (Action, State)
import ContentCalendar.State (initialState, reducer)

storeBundle :: StoreBundle State Action
storeBundle = createStore initialState reducer

store :: Store State
store = storeBundle.store