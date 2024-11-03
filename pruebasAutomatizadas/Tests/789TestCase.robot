*** Settings ***
Library    SeleniumLibrary
Resource   ../Resources/resources.robot
Resource   ../Resources/keywords.robot
Test Teardown       Cerrar el Navegador

*** Test Cases ***
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
