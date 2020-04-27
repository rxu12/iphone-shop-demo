export const getIphones = searchTerm => {
  // use the fetch API to load iphones.json to iphones variable
  // after this has loaded call the filterIphones() function below to filter the results
  return fetch(`/iphones.json`)
    .then(response => response.json())
    .then(iphones => filterIphones(iphones, searchTerm))
    .catch(console.error);
};

export const filterIphones = (iphones, searchTerm) => {
  return iphones.filter(iphone =>
    Object.values(iphone)
      .join(' ')
      .includes(searchTerm)
  );
};
