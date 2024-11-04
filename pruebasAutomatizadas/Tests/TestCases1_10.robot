*** Settings ***
Library    SeleniumLibrary
Resource   ../Resources/resources.robot
Resource   ../Resources/keywords.robot
Test Teardown       Cerrar el Navegador

*** Test Cases ***
Agregar y Quitar Elementos
    [Setup]  Inicializar navegador   ${URL_ANADIR_REMOVER_ELEMENTOS}

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
    [Setup]  Inicializar navegador   ${URL_BASIC_AUTH}

    ${message}=    Get Text    css:p
    Should Contain    ${message}    ${MENSAJE_EXITO}
    Close Browser

    Open Browser    ${URL_BASIC_AUTH_FAIL}    ${BROWSER}
    ${failed_message}=    Get Source
    Should Not Contain    ${failed_message}    ${MENSAJE_EXITO}

Checkboxes
    [Setup]  Inicializar navegador   ${URL_CHECKBOXES}

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

Context Menu
    [Documentation]    Este caso de prueba verifica la funcionalidad del menú contextual.
    [Setup]    Inicializar Navegador  ${url_context_menu}

    Open Context Menu    css:#hot-spot
    sleep                1

    Should Be Equal    ${alert_text}    You selected a context menu

    ${is_alert_open}=    Run Keyword And Return Status    Get Alert Text
    Should Not Be True    ${is_alert_open}

Elementos Que Desaparecen
    [Documentation]    Este caso de prueba verifica la visibilidad del botón “Gallery” que puede aparecer y desaparecer.
    [Setup]     Inicializar navegador    ${url_disappearing_elements}

    ${is_visible}=    run keyword and return status    page should contain link    ${GALLERY_BUTTON}

    IF     '${is_visible}' == 'True'
        WHILE   '${is_visible}' == 'True'
            reload page
            sleep   1
            ${is_visible}=    run keyword and return status    page should contain link    ${GALLERY_BUTTON}
        END
        page should not contain link    ${GALLERY_BUTTON}
    ELSE
        WHILE   '${is_visible}' == 'False'
            reload page
            sleep   1
            ${is_visible}=    run keyword and return status    page should contain link    ${GALLERY_BUTTON}
        END
        page should contain link    ${GALLERY_BUTTON}
        WHILE   '${is_visible}' == 'True'
            reload page
            sleep   1
            ${is_visible}=    run keyword and return status    page should contain link    ${GALLERY_BUTTON}
        END
        page should not contain link    ${GALLERY_BUTTON}
    END

Arrastrar Y Soltar
    [Documentation]    Este caso de prueba verifica la funcionalidad de arrastrar y soltar entre las cajas A y B.
    [Setup]    Inicializar Navegador  ${url_drag_and_drop}

    Drag And Drop    ${column_a}    ${column_b}

    ${column_a_text}=    Get Text    ${column_a}
    ${column_b_text}=    Get Text    ${column_b}
    Should Be Equal    ${column_a_text}    B
    Should Be Equal    ${column_b_text}    A

    Drag And Drop    ${column_b}    ${column_a}

    ${column_a_text}=    Get Text    ${column_a}
    ${column_b_text}=    Get Text    ${column_b}
    Should Be Equal    ${column_a_text}    A
    Should Be Equal    ${column_b_text}    B

Verificar la Funcionalidad de Eliminar y Anadir el Elemento Checkbox
    [Documentation]    Este caso de prueba verifica la funcionalidad de eliminar y añadir elementos.
    [Setup]    Inicializar Navegador  ${url_dynamic_controls}
    click button                        Remove
    wait until element is not visible   id:checkbox
    page should not contain checkbox    id:checkbox
    sleep                               1
    click button                        Add
    wait until element is visible       id:checkbox
    page should contain checkbox        id:checkbox

Verificar que el Menu Flotante Sigue Siendo Visible al Desplazarse al Final de la Pagina
    [Documentation]    Este caso de prueba verifica la funcionalidad del menu flotante.
    [Setup]    Inicializar navegador    ${url_floating_menu}
    execute javascript           window.scrollTo(0, document.body.scrollHeight)
    sleep                        1
    element should be visible    id:menu

Verificar Inicio de Sesion Exitoso
    [Documentation]    Este caso de prueba verifica el inicio de sesion con credenciales correctas.
    [Setup]    Inicializar navegador    ${url_login}
    input text                  id:username    tomsmith
    input password              id:password    SuperSecretPassword!
    sleep                       1
    click button                Login
    page should contain         You logged into a secure area!

Verificar Cierre de Sesion Exitoso
    [Documentation]    Este caso de prueba verifica el cierre de sesion.
    [Setup]    Inicializar navegador    ${url_login}
    input text                  id:username    tomsmith
    input password              id:password    SuperSecretPassword!
    sleep                       1
    click button                Login
    page should contain         You logged into a secure area!
    sleep                       1
    click link                  Logout
    page should contain         You logged out of the secure area!

Verificar Inicio de Sesion Fallido con Username Incorrecto
    [Documentation]    Este caso de prueba verifica el inicio de sesion fallido con username incorrecto.
    [Setup]    Inicializar navegador    ${url_login}
    input text                       id:username    tomsmith1
    input password                   id:password    SuperSecretPassword!
    click button                     Login
    wait until element is visible    id:flash-messages
    page should contain              Your username is invalid!

Verificar Inicio de Sesion Fallido con Password Incorrecto
    [Documentation]    Este caso de prueba verifica el inicio de sesion fallido con password incorrecto.
    [Setup]    Inicializar navegador    ${url_login}
    input text                       id:username    tomsmith
    input password                   id:password    SuperS1ecretPassword!
    click button                     Login
    wait until element is visible    id:flash-messages
    page should contain              Your password is invalid!

Verificar funcionaliadad Teclas presionadas
    [Setup]    Inicializar navegador    ${URL_KEY_PRESSES}

    Sleep    2s
    Press Keys   id=target   ESC
    Wait Until Element Is Visible    id=result
    ${mensaje} =    Get Text    id=result
    Should Be Equal    ${mensaje}    You entered: ESCAPE
    Press Keys    id=target  SPACE
    Wait Until Element Is Visible    id=result
    ${mensaje} =    Get Text    id=result
    Should Be Equal    ${mensaje}    You entered: SPACE