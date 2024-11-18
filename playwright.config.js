const path = require('path');
module.exports = {
  use: {
    recordVideo: {
      dir: path.resolve(__dirname, './videos/'),
    },
  },
  reporter: [
    ['junit', { outputFile: path.resolve(__dirname, './test-results/results.xml') }],
    ['html', { outputFolder: path.resolve(__dirname, './html-report'), open: 'never' }],
  ],
};
