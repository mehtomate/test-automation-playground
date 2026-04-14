*** Settings ***
Documentation       Page Object for the SauceDemo Inventory Page.

Resource            ../../resources/common.resource


*** Variables ***
${INVENTORY_LIST}       css=[data-test="inventory-container"]
${APP_LOGO}             css=.app_logo
${ADD_BACKPACK_BTN}     css=[data-test="add-to-cart-sauce-labs-backpack"]
${REMOVE_BACKPACK_BTN}  css=[data-test="remove-sauce-labs-backpack"]
${CART_LINK}            css=[data-test="shopping-cart-link"]
${CART_BADGE}           css=[data-test="shopping-cart-badge"]


*** Keywords ***
Verify Inventory Page Loaded
    Wait For Elements State    ${APP_LOGO}    visible    timeout=5s
    Get Text    ${APP_LOGO}    ==    Swag Labs
    Wait For Elements State    ${INVENTORY_LIST}    visible    timeout=5s

Add Backpack To Cart
    Click    ${ADD_BACKPACK_BTN}

Remove Backpack From Cart
    Click    ${REMOVE_BACKPACK_BTN}

Verify Cart Badge Quantity
    [Arguments]    ${expected_quantity}
    Wait For Elements State    ${CART_BADGE}    visible    timeout=3s
    Get Text    ${CART_BADGE}    ==    ${expected_quantity}

Verify Cart Badge Is Hidden
    Wait For Elements State    ${CART_BADGE}    hidden    timeout=3s

Open Cart
    Click    ${CART_LINK}
