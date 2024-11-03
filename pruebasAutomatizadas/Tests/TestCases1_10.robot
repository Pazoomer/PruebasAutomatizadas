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

Context Menu
    [Documentation]    Este caso de prueba verifica la funcionalidad del menú contextual.
    Open Browser    ${URL_CONTEXT_MENU}    ${BROWSER}
    Click Right Button    css:#hot-spot
    # Validar que el texto de la alerta es igual a “You selected a context menu”
    ${alert_text}=    Get Alert Text
    Should Be Equal    ${alert_text}    You selected a context menu
    # Clic al botón de Aceptar
    Accept Alert
    # Validar que la alerta fue cerrada
    ${is_alert_open}=    Run Keyword And Return Status    Get Alert Text
    Should Be False    ${is_alert_open}
    [Teardown]    Close Browser

Elementos Que Desaparecen
    [Documentation]    Este caso de prueba verifica la aparición y desaparición del botón "Gallery".
    Open Browser    ${URL_DISAPPEARING_ELEMENTS}    ${BROWSER}
    # Actualizar hasta que el botón sea visible
    Wait Until Page Contains Element    css:a[href="/gallery/"]    timeout=10
    # Validar que el botón “Gallery” existe
    ${gallery_exists}=    Run Keyword And Return Status    Element Should Be Visible    css:a[href="/gallery/"]
    Should Be True    ${gallery_exists}
    # Actualizar hasta que el botón no esté visible
    Wait Until Page Does Not Contain Element    css:a[href="/gallery/"]    timeout=10
    # Validar que el botón “Gallery” no existe
    ${gallery_exists}=    Run Keyword And Return Status    Element Should Not Be Visible    css:a[href="/gallery/"]
    Should Be True    ${gallery_exists}
    [Teardown]    Close Browser

Arrastrar Y Soltar Caja A a Caja B
    [Documentation]    Este caso de prueba arrastra la caja A a la caja B y valida que se intercambian.
    Open Browser    ${URL_DRAG_AND_DROP}    ${BROWSER}
    Drag And Drop    ${COLUMN_A}    ${COLUMN_B}
    # Validar que las cajas fueron intercambiadas
    ${text_a}=    Get Text    ${COLUMN_A}
    ${text_b}=    Get Text    ${COLUMN_B}
    Should Be Equal    ${text_a}    B
    Should Be Equal    ${text_b}    A
    [Teardown]    Close Browser

Arrastrar Y Soltar Caja B a Caja A
    [Documentation]    Este caso de prueba arrastra la caja B a la caja A y valida que se intercambian.
    Open Browser    ${URL_DRAG_AND_DROP}    ${BROWSER}
    Drag And Drop    ${COLUMN_B}    ${COLUMN_A}
    # Validar que las cajas fueron intercambiadas
    ${text_a}=    Get Text    ${COLUMN_A}
    ${text_b}=    Get Text    ${COLUMN_B}
    Should Be Equal    ${text_a}    A
    Should Be Equal    ${text_b}    B
    [Teardown]    Close Browser

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