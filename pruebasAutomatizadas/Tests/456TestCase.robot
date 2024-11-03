*** Settings ***
Library    SeleniumLibrary
Resource   ../Resources/resources.robot

*** Test Cases ***
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

