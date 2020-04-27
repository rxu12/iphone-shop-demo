import React from 'react';
import { shallow } from 'enzyme';
import * as SearchContext from '../../Context';
import Content from './';

describe('Content', () => {
  beforeAll(() => {
    const intialContext = {
      state: { searchTerm: '', isSearching: false, searchResult: [] }
    };
    jest.spyOn(SearchContext, 'useSearchContext').mockImplementation(() => intialContext);
  });
  afterEach(() => {
    jest.clearAllMocks();
  });
  it('should render', () => {
    const wrapper = shallow(<Content />);
    expect(wrapper.find('.content').exists()).toBeTruthy();
  });
  describe('initial page', () => {
    it('should display homepage banner', () => {
      const wrapper = shallow(<Content />);
      expect(wrapper.find('img').prop('src')).toEqual('/iphone-11-banner.jpg');
    });
    it('should not display no result page', () => {
      const wrapper = shallow(<Content />);
      expect(wrapper.find('NoResult').exists()).toBeFalsy();
    });
  });
  describe('No result found for search', () => {
    it('should render no result page', () => {
      const noResultContext = {
        state: { searchTerm: 'a', isSearching: false, searchResult: [] }
      };
      jest.spyOn(SearchContext, 'useSearchContext').mockImplementation(() => noResultContext);
      const wrapper = shallow(<Content />);
      expect(wrapper.find('NoResult').exists()).toBeTruthy();
    });
  });
  describe('Meaningful Search', () => {
    let resultContext;
    beforeAll(() => {
      resultContext = {
        state: {
          searchTerm: 'iphone',
          isSearching: false,
          searchResult: [
            { id: 1, name: 'iphone', color: 'gold', capacity: '1GB', price: '$1' },
            { id: 2, name: 'iphone2', color: 'silver', capacity: '2GB', price: '$22' }
          ]
        }
      };
      jest.spyOn(SearchContext, 'useSearchContext').mockImplementation(() => resultContext);
    });
    it('should show result count', () => {
      const wrapper = shallow(<Content />);
      expect(wrapper.find('.result-count').text()).toEqual('2 iphones found for search: iphone');
    });
    it('should render ProductTiles', () => {
      const wrapper = shallow(<Content />);
      expect(wrapper.find('ProductTile')).toHaveLength(2);
    });
  });
});
