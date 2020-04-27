import React, { Fragment } from 'react';
import { useSearchContext } from '../../Context';
import ProductTile from '../ProductTile';
import NoResult from '../NoResult';
import './content.css';

const Content = props => {
  const {
    state: { searchResult, searchTerm }
  } = useSearchContext();
  const resultCount = searchResult.length;
  return (
    <div className="content">
      {resultCount === 0 && !searchTerm && (
        <img src={'/iphone-11-banner.jpg'} alt="homepage-banner-ip11" />
      )}
      {resultCount === 0 && searchTerm && <NoResult searchTerm={searchTerm} />}
      {resultCount > 0 && (
        <Fragment>
          <h3 className="result-count">{`${resultCount} iphones found for search: ${searchTerm}`}</h3>
          <div className="hr" />
        </Fragment>
      )}
      <div className="result-container">
        {searchResult.map(iphone => (
          <ProductTile key={iphone.id} {...iphone} />
        ))}
      </div>
    </div>
  );
};

export default Content;
