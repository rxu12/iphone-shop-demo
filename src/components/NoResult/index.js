import React from 'react';
import './noresult.css';

const NoResult = ({ searchTerm }) => {
  return (
    <div>
      <h2 className="noresult">{`Sorry, we did not find any iphones matching the query: ${searchTerm}`}</h2>
    </div>
  );
};

export default NoResult;
