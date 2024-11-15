const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './Azure/tests',  // Ensure this points to the correct directory
  reporter: [['junit', { outputFile: 'results.xml' }]],
});
