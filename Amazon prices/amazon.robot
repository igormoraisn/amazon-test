*** Settings ***
Documentation     A test suite with three Amazon tests.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***

80% Of Shown Products Should Be Exclusively The Searched Product
    Open Browser and Search for Page
    Search For Iphone Using The Search Bar
    Check If 80% Of Elements Are Iphone
    Close All Browsers

The Higher Price In The First Page Can't Be Greater Than U$2000
    Open Browser and Search for Page
    Search For Iphone Using The Search Bar
    Check The Higher Price For Iphone
    Close All Browsers


Products Different Than The Searched Product Should Be Cheaper Than The Searched Product
    Open Browser and Search for Page
    Search For Iphone Using The Search Bar
    Check If All Products Are Cheapest Than The Cheapest Iphone
    Close All Browsers
