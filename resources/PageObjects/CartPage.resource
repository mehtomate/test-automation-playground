*** Settings ***
Documentation       Page Object for the SauceDemo Cart Page.

Resource            ../resources/common.resource


*** Variables ***
${CHECKOUT_BTN}         css=[data-test="checkout"]
${CART_ITEM_NAME}       css=.inventory_item_name


*** Keywords ***
Verify Cart Contains Item
    [Arguments]    ${expected_item_name}
    Get Text    ${CART_ITEM_NAME}    ==    ${expected_item_name}

Click Checkout
    Click    ${CHECKOUT_BTN}
