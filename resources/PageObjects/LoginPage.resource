*** Settings ***
Documentation    Page Object for SauceDemo Login Page.
Library         Browser


*** Variables ***
${USERNAME_FIELD}       id=user-name
${PASSWORD_FIELD}       id=password
${LOGIN_BUTTON}         id=login-button
${ERROR_CONTAINER}      css=.error-message-container


*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Text    ${PASSWORD_FIELD}    ${password}
    Click        ${LOGIN_BUTTON}

Verify Login Error
    [Arguments]    ${expected_error}
    Get Text    ${ERROR_CONTAINER}    contains    ${expected_error}

Verify Landing Page Is Open
    Get Url    ==    https://www.saucedemo.com/inventory.html
