*** Variables ***
${URL}                  https://www.demoblaze.com/
${BROWSER}              chrome
${USUARIO_VALIDO}       standard_userndkjsbkfcsbkcbskjcbs
${CORREO_VALIDO}        standard_user@gmail.com
${CONTRASEÑA_VALIDA}    secret_sauce
${CREDENCIAL_INVALIDA}  SoyInvalido

#RESOURCES - TEST CASES 1, 2, 3
${URL_ANADIR_REMOVER_ELEMENTOS}    https://the-internet.herokuapp.com/add_remove_elements/
${URL_BASIC_AUTH}             https://admin:admin@the-internet.herokuapp.com/basic_auth
${URL_BASIC_AUTH_FAIL}        https://admin1:admin1@the-internet.herokuapp.com/basic_auth
${MENSAJE_EXITO}   Congratulations
${URL_CHECKBOXES}             https://the-internet.herokuapp.com/checkboxes

#RESOURCES - TEST CASES 4, 5, 6
${URL_CONTEXT_MENU}    https://the-internet.herokuapp.com/context_menu
${URL_DISAPPEARING_ELEMENTS}    https://the-internet.herokuapp.com/disappearing_elements
${URL_DRAG_AND_DROP}    https://the-internet.herokuapp.com/drag_and_drop
${alert_text}    You selected a context menu
${is_alert_open}    False
${GALLERY_BUTTON}    Gallery
${COLUMN_A}    css:#column-a
${COLUMN_B}    css:#column-b

#RESOURCES - TEST CASES 7, 8, 9
${URL_DYNAMIC_CONTROLS}    https://the-internet.herokuapp.com/dynamic_controls
${URL_FLOATING_MENU}    https://the-internet.herokuapp.com/floating_menu
${URL_LOGIN}    https://the-internet.herokuapp.com/login

#RESOURCES - TEST CASE 10
${URL_KEY_PRESSES}    https://the-internet.herokuapp.com/key_presses


