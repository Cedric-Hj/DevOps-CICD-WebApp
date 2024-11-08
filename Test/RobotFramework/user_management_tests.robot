*** Settings ***
Documentation     Simple CRUD operations REST API Tests using Robot Framework
...               Robot Framework training - Capgemini 2024
...               To execute tests, run "robot -d .\reports\ .\calculator_tests.robot"
Library           RequestsLibrary
Library           Collections
Suite Setup       Create Session    api    ${BASE_URL}    headers=&{HEADERS}    verify=False
Suite Teardown    Log    Test suite execution completed.


*** Variables ***
${BASE_URL}       https://reqres.in/
&{HEADERS}        Content-Type=application/json
${USER_ENDPOINT}  /api/users
${USER_ID}        2

*** Keywords ***
Log Response And Verify Status
    [Arguments]    ${response}    ${expected_status}
    Status Should Be    ${expected_status}    ${response}
    

Create User
    [Arguments]    ${name}    ${job}
    ${data}=           Create Dictionary    name=${name}    job=${job}
    ${response}=       POST On Session      api    ${USER_ENDPOINT}    json=${data}    expected_status=201
    Log Response And Verify Status    ${response}    201
    RETURN             ${response.json()}

Update User
    [Arguments]    ${user_id}    ${name}    ${job}
    ${data}=           Create Dictionary    name=${name}    job=${job}
    ${response}=       PUT On Session        api    ${USER_ENDPOINT}/${user_id}     json=${data}    expected_status=200
    Log Response And Verify Status    ${response}    200
    RETURN             ${response.json()}

Delete User
    [Arguments]    ${user_id}
    ${response}=       DELETE On Session     api    ${USER_ENDPOINT}/${user_id}    expected_status=204
    Status Should Be    204    ${response}
    Log Response And Verify Status    ${response}    204 

Get User
    [Arguments]    ${user_id}
    ${response}=       GET On Session    api    ${USER_ENDPOINT}/${user_id}    expected_status=200
    Log Response And Verify Status    ${response}    200
    RETURN             ${response.json()}

*** Test Cases ***
POST Create User
    [Documentation]    Create a new user and verify the response.
    ${response_json}=  Create User    John Doe    Tester
    Should Be Equal As Strings    ${response_json['name']}    John Doe
    Should Be Equal As Strings    ${response_json['job']}     Tester

GET Single User
    [Documentation]    Retrieve details of the user with id = 2
    ${response_json}=  Get User    ${USER_ID}
    Dictionary Should Contain Key    ${response_json}    data
    Dictionary Should Contain Key    ${response_json['data']}    id
    Should Be Equal As Numbers    ${response_json['data']['id']}    ${USER_ID}
    Should Be Equal As Strings    ${response_json['data']['email']}    janet.weaver@reqres.in

PUT Update User
    [Documentation]    Update an existing user and verify the response.
    ${response_json}=  Update User    ${USER_ID}    morpheus    zion resident
    Should Be Equal As Strings    ${response_json['name']}    morpheus
    Should Be Equal As Strings    ${response_json['job']}     zion resident

DELETE User
    [Documentation]    Delete the user and verify the response.
    Delete User    ${USER_ID}