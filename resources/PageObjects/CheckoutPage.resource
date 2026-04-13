*** Settings ***
Documentation       Page Object for the SauceDemo Checkout Pages.

Resource            ../../resources/common.resource


*** Variables ***
${FIRST_NAME_FIELD}     css=[data-test="firstName"]
${LAST_NAME_FIELD}      css=[data-test="lastName"]
${ZIP_FIELD}            css=[data-test="postalCode"]
${CONTINUE_BTN}         css=[data-test="continue"]
${FINISH_BTN}           css=[data-test="finish"]
${COMPLETE_HEADER}      css=[data-test="complete-header"]


*** Keywords ***
Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${zip_code}
    Fill Text    ${FIRST_NAME_FIELD}    ${first_name}
    Fill Text    ${LAST_NAME_FIELD}    ${last_name}
    Fill Text    ${ZIP_FIELD}    ${zip_code}
    Click    ${CONTINUE_BTN}

Confirm Order Overview
    Click    ${FINISH_BTN}

Verify Order Completed
    Wait For Elements State    ${COMPLETE_HEADER}    visible    timeout=5s
    Get Text    ${COMPLETE_HEADER}    ==    Thank you for your order!
