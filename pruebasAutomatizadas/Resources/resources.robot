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
