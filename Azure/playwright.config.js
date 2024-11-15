const { run } = require('@playwright/test');

(async () => {
  const result = await run({
    reporter: [['junit', { outputFile: './test-results/results.xml' }]],
  });

  console.log(result);
})();
