*** Settings ***
Documentation       Page Object for the SauceDemo Inventory Page.

Resource            ../../resources/common.resource


*** Variables ***
${INVENTORY_LIST}       css=[data-test="inventory-container"]
${APP_LOGO}             css=.app_logo
${ADD_BACKPACK_BTN}     css=[data-test="add-to-cart-sauce-labs-backpack"]
${CART_LINK}            css=[data-test="shopping-cart-link"]


*** Keywords ***
Verify Inventory Page Loaded
    Wait For Elements State    ${APP_LOGO}    visible    timeout=5s
    Get Text    ${APP_LOGO}    ==    Swag Labs
    Wait For Elements State    ${INVENTORY_LIST}    visible    timeout=5s

Add Backpack To Cart
    Click    ${ADD_BACKPACK_BTN}

Open Cart
    Click    ${CART_LINK}
