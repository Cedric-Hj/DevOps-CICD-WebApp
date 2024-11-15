const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  reporter: [['junit', { outputFile: 'results.xml' }]],
  testDir: './Azure/tests', // Ensure this points to the correct directory
});
