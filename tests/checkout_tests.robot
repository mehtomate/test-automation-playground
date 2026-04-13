*** Settings ***
Resource            ../resources/common.resource
Library             ../resources/Libraries/CustomLib.py
Resource            ../resources/PageObjects/LoginPage.resource
Resource            ../resources/PageObjects/InventoryPage.resource
Resource            ../resources/PageObjects/CartPage.resource
Resource            ../resources/PageObjects/CheckoutPage.resource

Suite Setup         Initialize Test Suite
Suite Teardown      Clean Up Test Suite
Test Setup          Start New User Session
Test Teardown       Clean Up Test Context

Test Tags           smoke    regression    checkout


*** Test Cases ***
Complete E2E Checkout Flow With Backpack
    [Documentation]    Verify order can be placed successfully.
    Add Backpack To Cart
    Open Cart
    Verify Cart Contains Item    Sauce Labs Backpack
    Click Checkout

    ${dynamic_zip}=    Generate Random Zip Code
    Fill Checkout Information    Sami    Automation    ${dynamic_zip}
    Confirm Order Overview
    Verify Order Completed


*** Keywords ***
Start New User Session
    Initialize Test Context
    Open Login Page
    Input Credentials    standard_user    secret_sauce
    Submit Login Form
    Verify Inventory Page Loaded
