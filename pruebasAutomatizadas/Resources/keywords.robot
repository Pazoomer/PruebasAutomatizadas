*** Keywords ***
Inicializar navegador
    [Arguments]     ${url}
    open browser            ${url}             ${BROWSER}
    maximize browser window
    Sleep                   1s

Cerrar el navegador
    Sleep                   1s
    close browser
