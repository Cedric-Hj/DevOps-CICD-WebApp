const path = require('path');

module.exports = {
  use: {
    // Set the video recording path inside the playwright-report folder
    recordVideo: {
      dir: '/var/lib/jenkins/workspace/Tests/Playw/playwright-report/videos',  // Absolute path for video recording
    },
  },
  reporter: [
    // Set the JUnit report path inside the playwright-report folder
    ['junit', { outputFile: '/var/lib/jenkins/workspace/Tests/Playw/playwright-report/results.xml' }],
    // Set the HTML report path inside the playwright-report folder
    ['html', { outputFolder: '/var/lib/jenkins/workspace/Tests/Playw/playwright-report', open: 'never' }],
  ],
};
