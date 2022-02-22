*** Settings ***

Library    JSONLibrary
Library    os     #for specification for location of your file
Library    Collections
Library    RequestsLibrary

*** Variables ***
${base_url}    https://restcountries.eu


#to run =>> robot TestCases\TC5_ComplexJSONValidation.robot
*** Test Cases ***
Get_CountryInfo
    create session    mysession    ${base_url}
    ${response}=    get request    mysession    /rest/v2/alpha/IN
#    response header, content vs sahip
#    burada ${response.content} ile content JSONPath convert to
    ${json_object}=    to json    ${response.content}

#    Single DATA VAlidation
    ${country_Name}=    get value from json    ${json_object}    $.name
    log to console  ${country_Name[0]}
    should be equal    ${country_Name[0]} India

#   Single DATA VAlidation in array
    ${border}=    get value from json    ${json_object}    $.borders[0]
    log to console  ${border[0]}
    should be equal    ${border[0]}    AFG

    #   Multiple DATA VAlidation in array
    ${borders}=    get value from json    ${json_object}    $.borders
    log to console  ${borders[0]}
#    WE are verifing if this element exist in the list or not
#    should contain any ==> any of them
    should contain any    ${borders[0]}    AFG      BGD    BTN
    should not contain any    ${borders[0]}    abc xyz