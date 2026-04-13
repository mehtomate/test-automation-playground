*** Settings ***
Documentation       Data-Driven test suite for SauceDemo Login Form using the Browser Library.

Resource            ../resources/common.resource
Resource            ../resources/PageObjects/LoginPage.resource
Resource            ../resources/PageObjects/InventoryPage.resource

Suite Setup         Initialize Test Suite
Suite Teardown      Clean Up Test Suite
Test Setup          Initialize Test Context
Test Teardown       Clean Up Test Context
Test Template       Login Flow Scenario

Test Tags           regression    login


*** Test Cases ***    USERNAME    PASSWORD    EXPECTED_RESULT
Successful Login    standard_user    secret_sauce    SUCCESS
Locked Out User Login    locked_out_user    secret_sauce    Epic sadface: Sorry, this user has been locked out.
Invalid Credentials Login    invalid_user    bad_password    Epic sadface: Username and password do not match


*** Keywords ***
Login Flow Scenario
    [Arguments]    ${username}    ${password}    ${expected_result}
    Open Login Page
    Input Credentials    ${username}    ${password}
    Submit Login Form

    IF    "${expected_result}" == "SUCCESS"
        Verify Inventory Page Loaded
    ELSE
        Verify Login Error    ${expected_result}
    END
