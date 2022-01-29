*** Settings ***
Library    RequestsLibrary
Library    Collections    #LIST ICIN GEREKLI

*** Variables ***
#http://restapi.demoqa.com/utilities/weather/city/Delhi
${base_url}    http://restapi.demoqa.com
${city}    Delhi
#http://dummy.restapiexample.com/api/v1/employee/1
#https://demoqa.com/swagger/#/
${dummy_base_url}    http://dummy.restapiexample.com
${dummy_employee_id}    1

*** Test Cases ***
Get_WeatherInfo
#Buraya to do ekleyebeiliyoruz. Boylece alt ekranda gorebilriz.
#Birden fazla to do yazilabilir
# TODO is used to check if we have TODO
# TODO Complete
# TODO NO ACTION TAKEN

    create session    mysession    ${base_url}
    ${response}=    get request    mysession    /utilities/weather/city/${city}
#    create session    mysession1    ${dummy_base_url}
#    ${response}=    get request    mysession1    /api/v1/employee/${dummy_employee_id}
    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

    #VALIDATIONS
#    ${response.status_code}==> integer ve asagidaki 200==> string oldugu icin convert ettik
    ${status_code}=  convert to string    ${response.status_code}
    should be equal     ${status_code}    200

#   Burada da number formati var.Convert it to string
     ${response_body}=  convert to string    ${response.content}
     should contain  ${response_body}  Delhi

#   Verify headers.Header has a key=value format.
#   This is called in Python as a DICTIONARY format/variable
#   Dictionary is an collection type, we are using collections library for this
     ${contentTypeValue}=    get from dictionary    ${response.headers}    Content-Type
     should be equal    ${contentTypeValue}    application/json