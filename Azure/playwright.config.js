const { test, expect } = require('@playwright/test');

(async () => {
  const result = await test.run({
    testDir: './Azure/tests', 
    reporter: [['junit', { outputFile: 'results.xml' }]],
  });

  console.log(result);
})();
