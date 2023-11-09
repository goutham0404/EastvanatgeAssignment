*** Settings ***
Documentation                   To validate "submission of the application"
Library                         SeleniumLibrary
Resource                        ../pageObjects/GenericResource.robot
Test Setup                      open the test browser
Test Teardown                   close the test browser
Library                         String
#Resource                        ../resourceFiles/userdata.json
Library                         OperatingSystem
Library                         JSONLibrary
Library                         Collections


*** Variables ***
${sample_pic}             sample_picture.png
${sample_pic_path}        ${CURDIR}${/}..${/}resourceFiles${/}${sample_pic}

*** Test Cases ***
Validate submission of the application
    Close the Cookie Window
    Login Using Credentials
    Click on Submit a New Application
    Check and Continue                    Continue with the submission of an application?
    Fill Out the Form
    Click Next Screen Button
    Verify Inputted Values in Summary Page
    Click Validate and Send Button
    Verify Thank You Page
    
    
*** Keywords ***
Close the Cookie Window
    Sleep    3
    Click Button    id:cookie-close-button
    Maximize Browser Window


Login Using Credentials
    Sleep    3
    Click Element         css:.ml-auto.btn.btn-outline-primary
    Sleep    3
    Input Text            id:login-email                                    ${mail_id}
    Input Text            id:login-password                                 ${password}
    Click Element         css:.btn.btn-lg.btn-primary.col-12.mt-1.mt-md-2
    

Click on Submit a New Application
    Sleep    3
    Click Element        css:.btn.btn.btn-primary.btn-lg.col-md-auto


Check and Continue
    [Arguments]        ${checking}
    ${header_text}    Get Text    css:h1.h1
    IF    '${header_text}' == '${checking}'
        Click Element    css:.btn.btn-outline-primary
    END


Fill Out the Form
    ${json_file_path} =    Join Path    ${CURDIR}${/}..    resourceFiles    userdata.json
    Log To Console        ${json_file_path}
    ${json_data} =    Evaluate    json.load(open('${json_file_path}'))
    ${json_values} =    Get Value From Json       ${json_data}    $.first_name
    Input Text    id:629d7b5a-f6a1-5a14-ac1d-21b2fafdbdef           ${json_data["First_name"]}
    Input Text    id:23e5e47e-bab1-5a1e-9929-f180182bda43           ${json_data["Last_name"]}
    Input Text    id:7172c3f2-f508-5f9c-82a1-11ce9d0f3edc::c3f44a2e-72e9-587b-b88c-b5c9fbeed2db    ${json_data["Address"]}
    Input Text     css:.form-control.ui-autocomplete-input    ${json_data["Postal code"]}
    Select From List By Label    id:7e595970-fc12-558c-9eaf-385735fcae6b    ${json_data["Country"]}
    #Choose File       css:.btn.btn-outline-primary.qq-upload-button-selector    ${sample_pic_path}
    #Wait Until Element Is Visible    css:.fs-medium.font-weight-bold.overflow-hidden.text-nowrap.text-truncate
    ${gender_list}=    Create Dictionary
    Set To Dictionary    ${gender_list}    Male      f3fa11a5-a516-5cec-9025-b940b1b113d0
    Set To Dictionary    ${gender_list}    Female    514632f0-b9ec-5946-997e-f486fcd8276c
    Set To Dictionary    ${gender_list}    "Prefer not to answer"     f9291e23-4c53-56d3-8115-45818912be01
    Dictionary Should Contain Key    ${gender_list}    ${json_data["Gender"]}
    ${value}=    Get From Dictionary    ${gender_list}    ${json_data["Gender"]}
    Click Element        id:${value}
    Select From List By Value        id:field_f801d7d8-0762-5407-95f9-b8c3a793157c        ${json_data["Role"]}
    Click Element        id:5ab6a927-7b72-5869-acc3-0db0858bc495
    Click Element        id:92dcaa01-633c-5db1-ac87-e003906567ea
    Click Element        id:773e5289-f4b3-5d6d-ac81-5c99e2b39acd
    Input Text            css:.cke_editable.cke_editable_themed.cke_contents_ltr.cke_show_borders        ${json_data["Objective"]}


Click Next Screen Button
    Click Element    css:.btn.btn-primary.w-100


Verify Inputted Values in Summary Page
    ${json_file_path} =    Join Path    ${CURDIR}${/}..    resourceFiles    userdata.json
    ${json_data} =    Evaluate    json.load(open('${json_file_path}'))
    ${json_values} =    Get Value From Json       ${json_data}    $.first_name
    ${f_name}=    Get Text    id:container_629d7b5a-f6a1-5a14-ac1d-21b2fafdbdef
    ${l_name}=    Get Text    id:container_23e5e47e-bab1-5a1e-9929-f180182bda43
    ${address}=    Get Text    id:container_c3f44a2e-72e9-587b-b88c-b5c9fbeed2db
    ${postalcode}=    Get Text    id:container_e57df0b5-c2ad-514a-967f-ee8b962f5ed4
    ${country}=    Get Text    id:container_e57df0b5-c2ad-514a-967f-ee8b962f5ed4
    ${picture}=    Get Text    id:container_d370f504-7ff5-509f-babb-d80126387290
    ${gender}=    Get Text    id:container_f3fa11a5-a516-5cec-9025-b940b1b113d0
    ${address}=    Get Text    css:.answer.view.mb-0
    ${tools}=    Get Text    id:container_5ab6a927-7b72-5869-acc3-0db0858bc495
    ${objective}=    Get Text    xpath://p[@class='mb-0 field']
    Should Be Equal As Strings    ${json_data["First_name"]}    ${f_name}
    Should Be Equal As Strings    ${json_data["Last_name"]}    ${l_name}
    Should Be Equal As Strings    ${json_data["Address"]}    ${address}
    Should Be Equal As Strings    ${json_data["Postal code"]}    ${postalcode}
    Should Be Equal As Strings    ${json_data["Country"]}    ${country}
    Should Be Equal As Strings    ${json_data["Gender"]}    ${gender}
    Should Be Equal As Strings    ${json_data["Role"]}    ${address}
    Should Be Equal As Strings    ${json_data["Tools"]}    ${tools}
    Should Be Equal As Strings    ${json_data["Objective"]}    ${objective}


Click Validate and Send Button
    Click Button    css:.btn.btn-primary.w-100

Verify Thank You Page
    Page Should Contain    Thank you for submitting your project !


