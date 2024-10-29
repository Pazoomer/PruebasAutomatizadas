*** Settings ***
Library    SeleniumLibrary
Resource   ../Resources/resources.robot

*** Test Cases ***

Agregar y Quitar Elementos
    Open Browser   ${URL_ANADIR_REMOVER_ELEMENTOS}    ${BROWSER}
    [Teardown]    Close Browser

    FOR    ${index}    IN RANGE    20
        Click Button    css:button[onclick="addElement()"]
        ${elements}=    Get Element Count    css:.added-manually
        Should Be Equal As Numbers    ${elements}    ${index + 1}
    END

    FOR    ${index}    IN RANGE    20
        Click Button    css:.added-manually:first-child
        ${expected_count}=    Evaluate    20 - ${index} - 1
        ${elements}=    Get Element Count    css:.added-manually
        Should Be Equal As Numbers    ${elements}    ${expected_count}
    END

Autenticación Básica
    Open Browser    ${URL_BASIC_AUTH}    ${BROWSER}
    ${message}=    Get Text    css:p
    Should Contain    ${message}    ${MENSAJE_EXITO}
    Close Browser

    Open Browser    ${URL_BASIC_AUTH_FAIL}    ${BROWSER}
    ${failed_message}=    Get Source
    Should Not Contain    ${failed_message}    ${MENSAJE_EXITO}
    Close Browser

Checkboxes
    Open Browser    ${URL_CHECKBOXES}    ${BROWSER}
    [Teardown]    Close Browser

    ${is_selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    xpath://form[@id='checkboxes']/input[1]
    IF    '${is_selected}' == 'False'
        Click Element    xpath://form[@id='checkboxes']/input[1]
    END
    Checkbox Should Be Selected    xpath://form[@id='checkboxes']/input[1]

    ${is_selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    xpath://form[@id='checkboxes']/input[2]
    IF    '${is_selected}' == 'False'
        Click Element    xpath://form[@id='checkboxes']/input[2]
    END
    Checkbox Should Be Selected    xpath://form[@id='checkboxes']/input[2]
