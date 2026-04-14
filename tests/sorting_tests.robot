*** Settings ***
Documentation       Test suite verifying product sorting functionality on the Inventory Page.

Resource            ../resources/common.resource
Resource            ../resources/PageObjects/LoginPage.resource
Resource            ../resources/PageObjects/InventoryPage.resource

Suite Setup         Initialize Test Suite
Suite Teardown      Clean Up Test Suite
Test Setup          Initialize Test Context And Login
Test Teardown       Clean Up Test Context

Test Tags           regression    sorting


*** Test Cases ***
Verify User Can Sort Products By Name Ascending
    [Documentation]    Verifies that the "Name (A to Z)" sorting option works correctly.
    Select Sorting Option    az
    Verify Products Are Sorted By Name Ascending

Verify User Can Sort Products By Name Descending
    [Documentation]    Verifies that the "Name (Z to A)" sorting option works correctly.
    Select Sorting Option    za
    Verify Products Are Sorted By Name Descending

Verify User Can Sort Products By Price Low To High
    [Documentation]    Verifies that the "Price (low to high)" sorting option works correctly.
    Select Sorting Option    lohi
    Verify Products Are Sorted By Price Low To High

Verify User Can Sort Products By Price High To Low
    [Documentation]    Verifies that the "Price (high to low)" sorting option works correctly.
    Select Sorting Option    hilo
    Verify Products Are Sorted By Price High To Low


*** Keywords ***
Initialize Test Context And Login
    Initialize Test Context
    LoginPage.Open Login Page
    LoginPage.Input Credentials    standard_user    secret_sauce
    LoginPage.Submit Login Form
    InventoryPage.Verify Inventory Page Loaded
