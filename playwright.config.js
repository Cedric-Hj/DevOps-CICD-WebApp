const path = require('path');

module.exports = {
  use: {
    recordVideo: {
      dir: '/var/lib/jenkins/workspace/Tests/Playw/videos',  // Absolute path for video recording
    },
  },
  reporter: [
    ['junit', { outputFile: '/var/lib/jenkins/workspace/Tests/Playw/test-results/results.xml' }],  // Absolute path for JUnit report
    ['html', { outputFolder: '/var/lib/jenkins/workspace/Tests/Playw/html-report', open: 'never' }],  // Absolute path for HTML report
  ],
};
