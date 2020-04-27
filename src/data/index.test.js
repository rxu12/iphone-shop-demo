import { filterIphones } from './';

describe('Data module', () => {
  describe('filterIphones', () => {
    it('Should return the list of iphones filtered by the search term', () => {
      const iphones = [
        { name: 'ip1', color: 'gold', capacity: '1GB', price: '$1' },
        { name: 'ip2', color: 'silver', capacity: '2GB', price: '$22' }
      ];
      expect(filterIphones(iphones, 'silver')).toEqual([
        { name: 'ip2', color: 'silver', capacity: '2GB', price: '$22' }
      ]);
    });
    it('Should return empty array if no match found', () => {
      const iphones = [
        { name: 'ip1', color: 'gold', capacity: '1GB', price: '$1' },
        { name: 'ip2', color: 'silver', capacity: '2GB', price: '$22' }
      ];
      expect(filterIphones(iphones, 'black')).toEqual([]);
    });
    it('Should be able to handle malformed result', () => {
      const iphones = [
        { name: 'ip1', color: 'gold', capacity: '1GB', price: '$1' },
        { name: 'ip2', color: 'silver', capacity: '2GB', price: '$22' },
        {},
        { name1: null }
      ];
      expect(filterIphones(iphones, 'silver')).toEqual([
        { name: 'ip2', color: 'silver', capacity: '2GB', price: '$22' }
      ]);
    });
  });
});
