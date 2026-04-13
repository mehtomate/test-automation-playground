*** Settings ***
Documentation       Page Object for the SauceDemo Login Page.

Resource            ../../resources/common.resource


*** Variables ***
${BASE_URL}             https://www.saucedemo.com/
${USERNAME_FIELD}       id=user-name
${PASSWORD_FIELD}       id=password
${LOGIN_BUTTON}         id=login-button
${ERROR_CONTAINER}      css=.error-message-container


*** Keywords ***
Open Login Page
    New Page    ${BASE_URL}
    Get Title    ==    Swag Labs

Input Credentials
    [Arguments]    ${username}    ${password}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Secret    ${PASSWORD_FIELD}    $password

Submit Login Form
    Click    ${LOGIN_BUTTON}

Verify Login Error
    [Arguments]    ${expected_error_text}
    Get Text    ${ERROR_CONTAINER}    contains    ${expected_error_text}
