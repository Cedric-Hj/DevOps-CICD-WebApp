const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './Azure/tests',  // Ensure this points to the correct directory
  reporter: [
    ['junit', { outputFile: 'test-results/test-results.xml' }] // Specify the output directory and file name
  ],
});
