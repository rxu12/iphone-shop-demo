import React from 'react';
import { shallow } from 'enzyme';
import * as SearchContext from '../../Context';
import * as data from '../../data';
import Header from './';

describe('Header', () => {
  let intialContext;
  beforeAll(() => {
    intialContext = {
      state: { searchTerm: '', isSearching: false, searchResult: [] },
      dispatch: jest.fn()
    };
    jest.spyOn(SearchContext, 'useSearchContext').mockImplementation(() => intialContext);
    jest.spyOn(data, 'getIphones').mockImplementation(() => Promise.resolve([{ id: 1 }]));
  });
  afterEach(() => {
    jest.clearAllMocks();
  });
  it('should render', () => {
    const wrapper = shallow(<Header />);
    expect(wrapper.find('.header-container').exists()).toBeTruthy();
    expect(wrapper.find('.logo').exists()).toBeTruthy();
    expect(wrapper.find('.search-bar').exists()).toBeTruthy();
  });
  describe('handleSearch', () => {
    it('should trigger search with meaningful term', done => {
      const eventMock = { target: { value: 'iphone' } };
      const wrapper = shallow(<Header />);
      wrapper.find('input').simulate('change', eventMock);
      wrapper.find('button').simulate('click');
      setImmediate(() => {
        wrapper.update();
        expect(intialContext.dispatch.mock.calls[0][0]).toStrictEqual({
          type: 'searchstate',
          payload: { isSearching: true, searchTerm: 'iphone' }
        });
        expect(intialContext.dispatch.mock.calls[1][0]).toStrictEqual({
          type: 'searchstate',
          payload: { isSearching: false, searchResult: [{ id: 1 }] }
        });
        done();
      });
    });
  });
});
