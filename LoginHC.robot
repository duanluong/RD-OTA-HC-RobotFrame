*** Settings ***
Library           BuiltIn
Library           Selenium2Library

*** Variables ***
${URL1}           http://192.168.100.1/
${URL2}           ${URL1}cgi-bin/luci
${BROWSER}        chrome
${PASSWORD}       123456
${IMAGE}          C:/Users/DuanLuong/Desktop/TempData/2023/4.RD-RobotFrame-OTA/firmware/lks7688.img
${CHECKSUM}       08b7c6162b5379aec029a3891564de00

*** Test Cases ***
Reflash HC to new firmware
    [Documentation]    Try to login HC
    [Tags]    Functional
    Open Browser    ${URL2}    ${BROWSER}
    # Enter Password and Login
    Wait Until Element Is Visible    class:cbi-button.cbi-button-apply    2
    Input Text    name:luci_password    ${PASSWORD}
    Click Element    class:cbi-button.cbi-button-apply
    # Enter Flash menu
    Wait Until Element Is Visible    class:tabmenu-item-system    2
    Click Element    class:tabmenu-item-system
    Wait Until Element Is Visible    class:tabmenu-item-flashops    2
    Click Element    class:tabmenu-item-flashops
    # Upload file
    Wait Until Element Is Visible    class:cbi-value-field    2
    Unselect Checkbox    id:keep
    Choose File    id:image    ${IMAGE}
    ${elements}=    Get WebElements    class:cbi-button.cbi-input-apply
    Log to console    Element Value is ${elements}
    Log to console    Element [2] is ${elements}[1]
    Click Element    ${elements}[1]
    # Verify checksum and Flash
    Wait Until Page Contains    Configuration files will be erased
    Page Should Contain    08b7c6162b5379aec029a3891564de00
    Click Element    class:cbi-button.cbi-button-apply
    # End Process
    Sleep    15
    Close Browser
