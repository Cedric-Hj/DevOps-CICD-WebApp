const path = require('path');

module.exports = {
  use: {
    recordVideo: {
      dir: '/var/lib/jenkins/workspace/Tests/Playw/playwright-report/',  // Absolute path for video recording
      size: { width: 1280, height: 720 },  // Optional: Set video resolution
      video: 'on',  // Record video for all tests
    },
  },
  reporter: [
    ['junit', { outputFolder: '/var/lib/jenkins/workspace/Tests/Playw/playwright-report', open: 'never' }],
    ['xml', { outputFolder: '/var/lib/jenkins/workspace/Tests/Playw/playwright-report', open: 'never' }],
    ['html', { outputFolder: '/var/lib/jenkins/workspace/Tests/Playw/playwright-report', open: 'never' }],
  ],
};
