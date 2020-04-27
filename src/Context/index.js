import React, { useReducer, useContext } from 'react';
import { setSearchState } from './actionType';

const initialState = {
  searchResult: [],
  searchTerm: '',
  isSearching: false
};

const SearchContext = React.createContext(initialState);

const searchReducer = (state, action) => {
  switch (action.type) {
    case setSearchState:
      return { ...state, ...action.payload };
    default:
      return state;
  }
};

const SearchProvider = props => {
  const [state, dispatch] = useReducer(searchReducer, initialState);
  return (
    <SearchContext.Provider value={{ state, dispatch }}>{props.children}</SearchContext.Provider>
  );
};

const useSearchContext = () => useContext(SearchContext);

export { SearchContext, SearchProvider, useSearchContext, initialState, searchReducer };
