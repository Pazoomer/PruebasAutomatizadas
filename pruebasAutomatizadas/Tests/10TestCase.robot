*** Settings ***
Library         SeleniumLibrary        run_on_failure=None
Resource        ../Resources/keywords.robot
Resource        ../Resources/resources.robot
Test Teardown   Cerrar el Navegador

*** Test Cases ***
Verificar funcionaliadad Teclas presionadas
    Open Browser    https://the-internet.herokuapp.com/key_presses    ${BROWSER}
    Maximize Browser Window
    Sleep    2s
    Press Keys   id=target   ESC
    Wait Until Element Is Visible    id=result
    ${mensaje} =    Get Text    id=result
    Should Be Equal    ${mensaje}    You entered: ESCAPE
    Press Keys    id=target  SPACE
    Wait Until Element Is Visible    id=result
    ${mensaje} =    Get Text    id=result
    Should Be Equal    ${mensaje}    You entered: SPACE

#   robot Tests/10TestCase.robot
#   robot --test "Verificar funcionaliadad Teclas presionadas" Tests/test.robot