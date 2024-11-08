*** Settings ***
Documentation     Simple Calculator SOAP API Tests using Robot Framework
...               Robot Framework training - Capgemini 2024
...               To execute tests, run "robot -d .\reports\ .\calculator_tests.robot"
Library           RequestsLibrary
Library           XML
Library           OperatingSystem
Library           Collections

Suite Setup       Create Session    calculator    ${SOAP_URL}
Suite Teardown    Log               Test Suite completed

*** Variables ***
${SOAP_URL}       http://www.dneonline.com/calculator.asmx?WSDL
&{HEADERS}        Content-Type=text/xml; charset=utf-8
&{XML_FILES}      add=${CURDIR}${/}request_add.xml
...               subtract=${CURDIR}${/}request_subtract.xml
...               multiply=${CURDIR}${/}request_multiply.xml
...               divide=${CURDIR}${/}request_divide.xml

*** Keywords ***
Send SOAP Request
    [Arguments]    ${operation}    ${soap_action}
    ${xml_file}=       Get From Dictionary        ${XML_FILES}    ${operation}
    ${body}=           Get File                   ${xml_file}
    Set To Dictionary  ${HEADERS}                 SOAPAction=${soap_action}
    ${response}=       POST On Session            calculator    ${SOAP_URL}    data=${body}    headers=${HEADERS}
    Should Be Equal As Strings                    ${response.status_code}    200
    ${xml}=            Parse XML                  ${response.text}
    RETURN             ${xml}

Verify Result
    [Arguments]    ${xml}    ${xpath}    ${expected_result}
    ${result}=         Get Element Text           ${xml}    ${xpath}
    Should Be Equal As Integers                   ${result}    ${expected_result}
    Log                Result: ${result}

*** Test Cases ***
Addition Test
    [Documentation]    Test addition operation: 5 + 8 = 13
    ${xml}=            Send SOAP Request          add    http://tempuri.org/Add
    Verify Result      ${xml}    .//AddResult     13

Subtraction Test
    [Documentation]    Test subtraction operation: 10 - 5 = 5
    ${xml}=            Send SOAP Request          subtract    http://tempuri.org/Subtract
    Verify Result      ${xml}    .//SubtractResult    5

Multiplication Test
    [Documentation]    Test multiplication operation: 3 * 4 = 12
    ${xml}=            Send SOAP Request          multiply    http://tempuri.org/Multiply
    Verify Result      ${xml}    .//MultiplyResult    12

Division Test
    [Documentation]    Test division operation: 8 / 2 = 4
    ${xml}=            Send SOAP Request          divide    http://tempuri.org/Divide
    Verify Result      ${xml}    .//DivideResult    4