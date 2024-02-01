var assert = require("assert");
var Calculate =  require('../index.js')

describe('Calculate', () => {
  describe('.factorial', () => {
    it('The output of 5! is equal to 120', () => {
      // Setup
      const input = 5;
      const expectedResult = 120;

      // Exercise
      const result = Calculate.factorial(input)
      
      // Verify
      assert.equal(result, expectedResult);
    });

    it('The output of 6! is equal to 720', () => {
      // Setup
      const input = 6;
      const expectedResult = 720;

      // Exercise
      const result = Calculate.factorial(input)

      // Verify
      assert.equal(result, expectedResult);
    });
    
    it('returns 1 when you pass in 0.', () => {
      // Setup
      const input = 0;
      const expectedResult = 1;

      // Exercise
      const result = Calculate.factorial(input);

      // Verify
      assert.equal(result, expectedResult);
    });
  });
});