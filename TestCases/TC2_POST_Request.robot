*** Setting ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}=    http://www.dummy.restapiexample.com
#${base_url}=    http://restapi.demoqa.com/customer ==> bu link calismiyor
# onujn yerine bu linki  kullanabiliriz
#http://www.dummy.restapiexample.com/create
#/create	POST	{"name":"test","salary":"123","age":"23"}
#RESPONSE  BODY
#{
#    "status": "success",
#    "data": {
#        "name": "test",
#        "salary": "123",
#        "age": "23",
#        "id": 25
#    }
#}

*** Test Cases ***
Put_CustomerRegistration
    create session    mysession     ${base_url}
    #burada iki dictionary olusturuyoruz. First contains data,the other contains type of data
    ${body}=    create dictionary    name=test    salary=123    age=23
    ${header}=    create dictionary    Content-Type=application/json
#   ${response}=    post request    mysession    /register    data=${body}    headers=${header}
    ${response}=    post request    mysession    /create    data=${body}    headers=${header}

    log to console    ${response.status_code}
    log to console    ${response.content}

#    VALIDATION
#       ${status_code} ==> number formatinda oluyor, convert to string
     ${status_code}=  convert to string   ${response.status_code}
     should be equal    ${status_code}    201

#   ${response.content}==> json format oluyor, bu nedenle string convert ettik
    ${res_body}=   convert to string    ${response.content}
    SHOULD CONTAIN    ${res_body}    success
#    SHOULD CONTAIN    ${res_body}    OPERATION_SUCCESS
#    SHOULD CONTAIN    ${res_body}    Operation completes succesfully