import React, { useState } from 'react';
import * as Data from '../../data';
import { useSearchContext } from '../../Context';
import { setSearchState } from '../../Context/actionType';
import './header.css';

const Header = props => {
  const [searchTerm, setSearchTerm] = useState('');
  const { dispatch } = useSearchContext();
  const handleSearch = () => {
    const trimedQuery = searchTerm.trim();
    if (trimedQuery === '') return;
    dispatch({ type: setSearchState, payload: { isSearching: true, searchTerm: trimedQuery } });
    Data.getIphones(trimedQuery).then(iphones => {
      dispatch({ type: setSearchState, payload: { isSearching: false, searchResult: iphones } });
    });
  };
  return (
    <div className="header-container">
      <div className="header">
        <div className="logo" />
        <div className="search-bar">
          <input
            placeholder="Do a search to find iphones"
            value={searchTerm}
            onChange={event => setSearchTerm(event.target.value)}
          />
          <button type="button" onClick={handleSearch}>
            Search
          </button>
        </div>
      </div>
    </div>
  );
};

export default Header;
