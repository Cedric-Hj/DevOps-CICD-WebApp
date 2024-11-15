const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  reporter: [['list'], ['junit', { outputFile: './test-results/results.xml' }]],
  testDir: './Test',
});
