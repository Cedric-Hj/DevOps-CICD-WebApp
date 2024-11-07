#!/bin/bash

# Mock test that will create a JUnit-compatible XML report with one test suite and three test cases
cat <<EOF > report.xml
<?xml version="1.0" encoding="UTF-8"?>
<testsuites>
    <testsuite name="Security Test Suite 1" tests="5" failures="0" errors="0">
        <testcase name="Test Case 1" />
        <testcase name="Test Case 2" />
        <testcase name="Test Case 3" />
        <testcase name="Test Case 4" />
        <testcase name="Test Case 5" />
    </testsuite>
</testsuites>
EOF

# Exit with code 0 to indicate success
exit 0