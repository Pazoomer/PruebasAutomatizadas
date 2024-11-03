*** Keywords ***
Inicializar navegador
    [Arguments]     ${url}
    open browser            ${url}             ${BROWSER}
    maximize browser window
    Sleep                   2s

Cerrar el navegador
    Sleep                   2s
    close browser
