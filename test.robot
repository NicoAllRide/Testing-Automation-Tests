*** Settings ***
Library    AppiumLibrary

*** Variables ***
${REMOTE_URL}       http://localhost:4723/wd/hub
${PLATFORM_NAME}    Android
${PLATFORM_VERSION} 10
${DEVICE_NAME}      emulator-5554
${APP_PACKAGE}      com.android.calculator2
${APP_ACTIVITY}     com.android.calculator2.Calculator

*** Test Cases ***
Test Calculator App
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}

    Click Element    id=digit_7
    Click Element    id=op_add
    Click Element    id=digit_3
    Click Element    id=eq

    ${result}=    Get Text    id=result
    Should Be Equal    ${result}    10

    Close Application
