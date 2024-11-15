const { run } = require('@playwright/test');

(async () => {
  const result = await run({
    reporter: [['junit', { outputFile: 'results.xml' }]],
  });

  console.log(result);
})();
