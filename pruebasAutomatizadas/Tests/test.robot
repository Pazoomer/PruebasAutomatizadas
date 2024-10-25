#Equipo:
#Jorge Alan Zamora Mejia 245103
#Jorge Eduardo Elias Cazarez 187134
#Maximiliano Reyna Aguilar 244877
#Gamaliel Armenta Pérez 245254

*** Settings ***
Library         SeleniumLibrary        run_on_failure=None
Resource        ../Resources/keywords.robot
Resource        ../Resources/resources.robot
Test Setup      Inicializar navegador
Test Teardown   Cerrar el Navegador

*** Test Cases ***
Verificar existencia de al menos 9 productos en el inicio xpath
    @{productos}=    Get WebElements    xpath://*[@id="tbodyid"]/div/div/div/h4/a
    ${total_productos}=    Get Length    ${productos}
    Should Be True    ${total_productos} >= 9

Verificar existencia de al menos 9 productos en el inicio css
    @{productos}=    Get WebElements    css:#tbodyid > div > div > div > h4 > a
    ${total_productos}=    Get Length    ${productos}
    Should Be True    ${total_productos} >= 9

#   robot Tests/test.robot
#   robot --test "Verificar existencia de al menos 9 productos en el inicio css" Tests/test.robot