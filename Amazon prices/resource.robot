*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           utils.py

*** Variables ***
${GOOGLE_URL}     https://google.com
${BROWSER}        Firefox
${TITLE}          Amazon Brasil
${SITE}           www.amazon.com.br
${MAXIMUM}        2000
${LINK}           xpath=//a[@href=\'www.amazon.com.br'\]

*** Keywords ***
Open Browser and Search for Page
    Open Browser    ${GOOGLE_URL}    ${BROWSER}
    Input Text    name:q    ${TITLE}
    Press Keys    name:q    RETURN
    Wait Until Element Is Visible    //cite[@class="iUh30 tjvcx"]
    Click Element       //cite[@class="iUh30 tjvcx"]

Search For Iphone Using The Search Bar
    Input Text    twotabsearchtextbox    Iphone
    Press Keys    twotabsearchtextbox    RETURN

Check If 80% Of Elements Are Iphone
    Wait Until Element Is Visible    //span[@class="a-size-base-plus a-color-base a-text-normal"]
    @{products}=  Get WebElements    //span[@class="a-size-base-plus a-color-base a-text-normal"]
    ${result}=    Check Products List    ${products}
    Should Be True    ${result}

Check The Higher Price For Iphone
    Wait Until Element Is Visible    //span[@class="a-size-base-plus a-color-base a-text-normal"]
    @{products}=  Get WebElements    //span[@class="a-size-base-plus a-color-base a-text-normal"]
    @{values}=   Get WebElements    //span[@class="a-price-whole"]
    ${expensive}=    Find More Expensive    ${products}    ${values}
    ${converted_value}=    Convert To Dolar    ${expensive}
    Should Be True    ${converted_value} <= ${MAXIMUM}

Check If All Products Are Cheapest Than The Cheapest Iphone
    Wait Until Element Is Visible    //span[@class="a-size-base-plus a-color-base a-text-normal"]
    @{products}=  Get WebElements    //span[@class="a-size-base-plus a-color-base a-text-normal"]
    @{values}=   Get WebElements    //span[@class="a-price-whole"]
    @{not_iphones}=    Find Not Iphones    ${products}
    ${cheapest_iphone}=    Find Iphone Less Expensive    ${products}    ${values}
    ${result}=    Check Cheapest Values    ${cheapest_iphone}    ${not_iphones}    ${values}
    Should Be True    ${result}