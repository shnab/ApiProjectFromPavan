*** Settings ***

Library    XML
Library    os     #for specification for location of your file
Library    Collections

#to run =>> robot TestCases\TC6_XML.robot
*** Test Cases ***
TestCase1:
    ${xml_obj}=    parse xml    C:\\development\\robot-scripts\\ApiProjectFromPavan\\employees.xml

    #Validations

    #Validation1-Check single element value

    # xml file icindeki ilk elementin firstname kontrol edecegiz .//employee[1]
    #Approach1
   ${emp_firstname}=  get element text  ${xml_obj}   .//employee[1]/firstname
    should be equal    ${emp_firstname}    John

    #Approach2
    ${emp_firstname}=    get element    ${xml_obj}   .//employee[1]/firstname
    should be equal    ${emp_firstname.text}    John

    #Approach3
    element text should be    ${xml_obj}    John    .//employee[1]/firstname

#    Val2--> Check Number of Elements
#     5 (integer) != 5 (string) oldugu icin
    ${count}=    get element count    ${xml_obj}    .//employee
    should be equal as integers    ${count}    6

#    VAL3==> Check attribute presence
# file icindeki attribute kontrol ediliyor bu sekilde
    element attribute should be    ${xml_obj}    id    be129    .//employee[1]
    element attribute should be    ${xml_obj}    id    be135    .//employee[6]

#    Val4_-> Check values of child elements