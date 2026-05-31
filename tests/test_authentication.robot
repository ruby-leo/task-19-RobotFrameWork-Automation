*** Settings ***
Documentation    A test suite to verify the login and logout functionality
...              of the RobotSpareBin Industries demo application using
...              Robot Framework and SeleniumLibrary
Library          SeleniumLibrary
Test Teardown    Close All Browsers

*** Variables ***
${URL}           https://robotsparebinindustries.com/
${BROWSER}       chrome

*** Test Cases ***
Verify Login and Logout
    [Documentation]    Executes the full user flow: opening the site, logging in,
    ...                verifying the login, logging out, and confirming return to login page.
    Open URL
    Login With Credentials    maria    thoushallnotpass
    Verify Login
    Logout
    Verify Logout

*** Keywords ***
Open URL
    [Documentation]    Launches the target browser, navigates to the application URL,
    ...                and maximizes the window
    Open Browser               ${URL}    ${BROWSER}
    Maximize Browser Window

Login With Credentials
    [Documentation]    Accepts a username and password as arguments, inputs
    ...                them into the respective fields, and submits the login form.
    [Arguments]                ${username}    ${password}
    Input Text                 id=username    ${username}
    Input Text                 id=password    ${password}
    Click Button               Log in

Verify Login
    [Documentation]    Validates successful authentication by waiting for the dashboard's
    ...                'Log out' button to appear and saves a visual confirmation screenshot.
    Wait Until Element Is Visible    id=logout    timeout=10s
    Capture Page Screenshot    filename=login_verification.png

Logout
    [Documentation]    Clicks the log out button.
    Click Button               Log out

Verify Logout
    [Documentation]    Validates successful logout by waiting for the Login button
    ...                in the login page and captures a verification screenshot.
    Wait Until Page Contains Element    xpath=//button[text()='Log in']
    Capture Page Screenshot    filename=logout_verification.png