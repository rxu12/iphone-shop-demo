import React from 'react';
import './product-tile.css';

const ProductTile = ({ id, name, price, color, capacity, imgUrl }) => (
  <div className="tile-container">
    <div className="image-container">
      <img src={imgUrl} alt={name} />
    </div>
    <div className="price-tag">{`$${price}`}</div>
    <div className="name">{name}</div>
    <div className="specs">
      <div className="color">{color}</div>
      <div className="capacity">{capacity}</div>
    </div>
  </div>
);

export default ProductTile;
