const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  use: {
    recordVideo: {
      dir: './Test/videos/',
      size: { width: 1280, height: 720 },
    },
  },
  reporter: [
    ['junit', { outputFile: './Test/test-results/results.xml' }],
    ['html', { outputFolder: './Test/html-report', open: 'never' }],
  ],
});

