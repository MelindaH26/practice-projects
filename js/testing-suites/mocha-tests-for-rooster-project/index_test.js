const assert = require('assert');     // import assert module
const Rooster = require('./index');  // import Rooster module

describe('Rooster', () => {           // describe Rooster
  
  describe( '.announceDawn', () => { // describe .announceDawn
    it('returns a rooser call', () => {
      // Setup: Define expected output
      const expected = 'cock-a-doodle-doo!';
      
      // Exercise: Call Rooster.announceDawn and store result in variable
      const result = Rooster.announceDawn();

      // Verify: Use an assert method to compare actual and expected result
      assert.equal(expected, result);
    });
  });

  describe('.timeAtDawn', () => {
    it('returns its argument as a string', () => {  
      // Setup
      const expected = '5';
      
      // Exercise
      const result = Rooster.timeAtDawn(5);

      // Verify
      assert.strictEqual(expected, result);
    });

    it('throws an error if passed a number less than 0', () => {    
      // Setup
      const hour = -1;
      const expected = RangeError;

      // Verify
      assert.throws(() => {
        Rooster.timeAtDawn(hour); // Exercise
      }, expected);
    });

    it('throws an error if passed a number greater than 23', () => {    
      // Setup
      const hour = 24;
      const expected = RangeError;

      // Verify
      assert.throws(() => {
          Rooster.timeAtDawn(hour); // Exercise
      }, expected);
    });

  });
});