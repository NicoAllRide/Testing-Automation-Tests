*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../Variables/variablesStage.robot



*** Test Cases ***

Edit userStop(Should mantain categorty 'odd' and 'userStop')
        [Documentation]    Se busca el usuario recién eliminado, no debería encontrarse

    ${jsonBody}=    Set Variable    {"username":"nicolas+endauto@allrideapp.com","password":"Equilibriozen123#"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    
    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/stops/6862ee8556685c282a2d1b2b?community=6654ae4eba54fe502d4e4187
    ...    data={"name":"Dirección personalizada Diego de Almagro 430 Rancagua, Chile","description":"","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":[],"ownerIds":[],"categories":["odd","userStop"],"lat":-34.17303901547532,"lon":-70.72759497910738,"config":{"options":[],"restricted":false,"stopIds":[]}}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    
    ${json}=    Set Variable    ${response.json()}

    
    ${categories}=    Set Variable    ${json}[categories]

    Should Contain    ${categories}    odd
    ...    msg=❌ Expected category "odd" to be present in the categories field, but got: ${categories}

    Should Contain    ${categories}    userStop
    ...    msg=❌ Expected category "userStop" to be present in the categories field, but got: ${categories}


