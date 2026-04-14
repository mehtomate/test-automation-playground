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
${SORT_DROPDOWN}        css=[data-test="product-sort-container"]
${ITEM_NAME_LIST}       css=[data-test="inventory-item-name"]
${ITEM_PRICE_LIST}      css=[data-test="inventory-item-price"]


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

Select Sorting Option
    [Arguments]    ${option}
    # options: az, za, lohi, hilo
    Select Options By    ${SORT_DROPDOWN}    value    ${option}

Verify Products Are Sorted By Name Ascending
    ${items}=    Get All Product Names
    ${sorted}=    Copy List    ${items}
    Sort List    ${sorted}
    Lists Should Be Equal    ${items}    ${sorted}

Verify Products Are Sorted By Name Descending
    ${items}=    Get All Product Names
    ${sorted}=    Copy List    ${items}
    Sort List    ${sorted}
    Reverse List    ${sorted}
    Lists Should Be Equal    ${items}    ${sorted}

Verify Products Are Sorted By Price Low To High
    ${items}=    Get All Product Prices
    ${sorted}=    Copy List    ${items}
    Sort List    ${sorted}
    Lists Should Be Equal    ${items}    ${sorted}

Verify Products Are Sorted By Price High To Low
    ${items}=    Get All Product Prices
    ${sorted}=    Copy List    ${items}
    Sort List    ${sorted}
    Reverse List    ${sorted}
    Lists Should Be Equal    ${items}    ${sorted}

Get All Product Names
    ${elements}=    Get Elements    ${ITEM_NAME_LIST}
    VAR    @{names}    @{EMPTY}
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}

Get All Product Prices
    ${elements}=    Get Elements    ${ITEM_PRICE_LIST}
    VAR    @{prices}    @{EMPTY}
    FOR    ${el}    IN    @{elements}
        ${price_str}=    Get Text    ${el}
        ${price_num}=    Evaluate    float("${price_str}".replace("$", ""))
        Append To List    ${prices}    ${price_num}
    END
    RETURN    ${prices}
