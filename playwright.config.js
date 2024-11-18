const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  use: {
    video: 'on',
  },
  reporter: [
    ['list'],
    ['./xmlReporter.js']
  ],
});
