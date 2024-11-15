// Azure/playwright.config.js
const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './Azure/tests',  // Ensure this points to the correct directory

  // Add the reporter configuration for JUnit
  reporter: [
    ['junit', { outputFile: 'test-results/test-results.xml' }]  // This will output the JUnit XML report to 'test-results/test-results.xml'
  ],
});
