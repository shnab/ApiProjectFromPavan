*** Settings ***

Library    JSONLibrary
Library    os     #for specification for location of your file
Library    Collections

#to run =>> robot TestCases\TC4_JSON.robot

#related websites
#https://jsonpathfinder.com
#https://jsonpath.com
*** Test Cases ***
TestCase1:
    ${json_obj}=    load json from file    C:\\development\\robot-scripts\\ApiProjectFromPavan\\jsondata.json
    ${name_value}=    get value from json    ${json_obj}    $.firstName
    log to console    ${name_value[0]}
    should be equal    ${name_value[0]}    John

    ${street_value}=    get value from json    ${json_obj}    $.address.streetAddress
    should be equal    ${street_value[0]}    naist street

    ${faxnumber_value}=    get value from json    ${json_obj}    $.phoneNumbers[1].number
    should be equal    ${faxnumber_value[0]}    0123-4567-8910