const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  reporter: [['list'], ['junit', { outputFile: 'results.xml' }]],
  testDir: './Tests',
});
