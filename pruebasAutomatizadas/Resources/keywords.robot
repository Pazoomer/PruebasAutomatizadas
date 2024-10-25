*** Keywords ***
Inicializar navegador
    open browser            ${URL}             ${BROWSER}
    maximize browser window
    Sleep                   2s

Cerrar el navegador
    Sleep                   2s
    close browser
