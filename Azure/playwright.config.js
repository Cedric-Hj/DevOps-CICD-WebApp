const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  reporter: [['list'], ['junit', { outputFile: 'Azure/results.xml' }]],
  testDir: './Azure/tests',
});
