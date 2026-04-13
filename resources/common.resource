*** Settings ***
Documentation       Shared configuration and setup keywords for the SauceDemo UI Framework.

Library             Browser


*** Variables ***
${BROWSER}      chromium
${HEADLESS}     False
${SLOWMO}       0.5s


*** Keywords ***
Initialize Test Suite
    New Browser    browser=${BROWSER}    headless=${HEADLESS}    slowMo=${SLOWMO}

Initialize Test Context
    New Context    viewport={'width': 1280, 'height': 720}    recordVideo={'dir': 'results/videos'}

Clean Up Test Context
    Close Context

Clean Up Test Suite
    Close Browser
