const { defineConfig, devices } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './Azure/tests', 
  reporter: [['junit', { outputFile: 'results.xml' }]],
});

