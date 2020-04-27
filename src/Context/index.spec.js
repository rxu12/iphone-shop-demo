import React from 'react';
import { mount } from 'enzyme';
import { SearchProvider, useSearchContext, initialState, searchReducer } from './';

describe('SearchContext', () => {
  it('should pass state to child component', () => {
    let state;
    const Harness = props => {
      state = useSearchContext().state;
      return <div />;
    };
    const Wrapper = props => (
      <SearchProvider>
        <Harness />
      </SearchProvider>
    );
    mount(<Wrapper />);
    expect(state).toEqual(initialState);
  });
  describe('searchReducer', () => {
    it('should receive action to update state', () => {
      const actual = searchReducer(initialState, {
        type: 'searchstate',
        payload: { isSearching: true, searchTerm: 'iphone' }
      });
      expect(actual).toEqual({
        searchResult: [],
        isSearching: true,
        searchTerm: 'iphone'
      });
    });
  });
});
