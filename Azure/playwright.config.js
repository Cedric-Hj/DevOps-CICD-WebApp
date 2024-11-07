// Azure/playwright.config.js
const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './tests',  // Ensure Playwright looks in the correct directory
});
