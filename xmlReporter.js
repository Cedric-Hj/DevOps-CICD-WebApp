const { Reporter } = require('@playwright/test/reporter');

class XMLReporter extends Reporter {
  onBegin(config, suite) {
    this.suite = suite;
    this.results = [];
  }

  onTestEnd(test, result) {
    this.results.push({
      name: test.title,
      status: result.status,
      duration: result.duration,
      error: result.error ? result.error.message : null
    });
  }

  async onEnd(result) {
    const xml = this.generateXML();
    require('fs').writeFileSync('report.xml', xml);
  }

  generateXML() {
    const tests = this.results.map(test => `
      <testcase name="${test.name}" status="${test.status}" time="${test.duration}">
        ${test.error ? `<failure>${test.error}</failure>` : ''}
      </testcase>
    `).join('\n');

    return `<?xml version="1.0" encoding="UTF-8"?>
    <testsuite name="${this.suite.title}" tests="${this.results.length}">
      ${tests}
    </testsuite>`;
  }
}

module.exports = XMLReporter;
