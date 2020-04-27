import React from 'react';
import './App.css';

import { SearchProvider } from './Context';
import Header from './components/Header';
import Content from './components/Content/';
import Footer from './components/Footer';

const App = props => (
  <div className="page">
    <SearchProvider>
      <Header />
      <Content />
      <Footer />
    </SearchProvider>
  </div>
);

export default App;
