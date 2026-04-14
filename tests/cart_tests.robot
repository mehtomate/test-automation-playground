*** Settings ***
Documentation       Test suite verifying Epic 200 Cart Operations (Add/Remove items).

Resource            ../resources/common.resource
Resource            ../resources/PageObjects/LoginPage.resource
Resource            ../resources/PageObjects/InventoryPage.resource

Suite Setup         Initialize Test Suite
Test Setup          Initialize Test Context
Test Teardown       Clean Up Test Context
Suite Teardown      Clean Up Test Suite


*** Test Cases ***
Verify User Can Add And Remove Merchandise Seamlessly
    [Documentation]    Satisfies Epic 200 AC 1 & 2: Cart Badge updates dynamically upon adding/removing.

    LoginPage.Open Login Page
    LoginPage.Input Credentials    standard_user    secret_sauce
    LoginPage.Submit Login Form
    InventoryPage.Verify Inventory Page Loaded

    # Pre-condition: Cart is completely empty on fresh login
    InventoryPage.Verify Cart Badge Is Hidden

    # Acceptance Criteria 1: Adding Merchandise displays badge
    InventoryPage.Add Backpack To Cart
    InventoryPage.Verify Cart Badge Quantity    1

    # Acceptance Criteria 2: Removing Merchandise hides badge dynamically
    InventoryPage.Remove Backpack From Cart
    InventoryPage.Verify Cart Badge Is Hidden
