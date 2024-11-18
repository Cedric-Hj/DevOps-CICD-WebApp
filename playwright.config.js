const { defineConfig } = require('@playwright/test');

// playwright.config.js
module.exports = {
  use: {
    // Enable video recording for all tests
    recordVideo: {
      dir: 'videos/',  // Save videos to the 'videos' folder
      size: { width: 1280, height: 720 },
    },
  },
  reporter: [
    ['junit', { outputFile: 'test-results/results.xml' }],  // JUnit report output
    ['html', { open: 'never' }]  // Optional: HTML report for interactive viewing
  ],
};
