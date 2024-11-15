const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './Azure/tests',  // Ensure this points to the correct test directory
  reporter: [
    ['junit', { outputFile: 'test-results/test-results.xml' }]
  ],
});
