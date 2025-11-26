*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../../Variables/variablesStage.robot
Library     uuid


*** Test Cases ***
Generate random UUID (DepartureId)
    ${uuid}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid}
    Set Global Variable    ${uuid}

Generate random UUID (_id Manual validations)
    ${uuid_manual}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_manual}
    Set Global Variable    ${uuid_manual}

Generate random UUID (_id validations customValidations)
    ${uuid_custom}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_custom}
    Set Global Variable    ${uuid_custom}

Generate random UUID (_id validations qrValidations)
    ${uuid_qr}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr}
    Set Global Variable    ${uuid_qr}
Generate random UUID2 (_id validations qrValidations)
    ${uuid_qr2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr2}
    Set Global Variable    ${uuid_qr2}
Generate random UUID2 Cédula (_id validations qrValidations)
    ${uuid_dni}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_dni}
    Set Global Variable    ${uuid_dni}
Generate random UUID (_id events1)
    ${uuid_events}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_events}
    Set Global Variable    ${uuid_events}
Generate random UUID (_id events2)
    ${uuid_events2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_events2}
    Set Global Variable    ${uuid_events2}

Get User QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["${idNico}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}
Get User QR(Kratos)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["${idKratos}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeKratos}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeKratos}
    Log    ${qrCodeKratos}
    Log    ${code}

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad}&driverId=658b4c89f6f903bbee966467

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver}

    Log    ${tokenDriver}
    Log    ${response.content}

Assing Tickets(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=${idNico}&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Sleep    10s

Assing Tickets(Pedro)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=${idPedro}&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Sleep    10s

Assing Tickets(Kratos)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=${idKratos}&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Assing Tickets(dni)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=653ff52433d83952fafcf397&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Sync Departure without validations(Create departure, sync as active false departure)
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/sync/${idSuperCommunity}
    ...    data={"departures":[{"active":false,"boardings":1,"busCode":"0602","canResume":false,"capacity":40,"communities":["653fd601f90509541a748683"],"communityId":"653fd601f90509541a748683","createdAt":"2024-10-08T15:47:32.216-04:00","customParams":[{"name":"Km_de_partida","value":1}],"customParamsAtTheEnd":[{"name":"Km_de_salida","value":2}],"direction":"","driverCode":"1712","driverId":"658b4c89f6f903bbee966467","drivers":[],"enabledSeats":[{"available":false,"_id":"667f244c738bca04e08a02e6","seat":"1","userId":"65e092afca7842b1032f12e2"},{"available":false,"_id":"667f244c738bca04e08a02e7","seat":"2","userId":"654a5148bf3e9410d0bcd39a"},{"available":false,"_id":"667f244c738bca04e08a02e8","seat":"3","userId":"663ccf399a0c214e3398f5cd"},{"available":false,"_id":"667f244c738bca04e08a02e9","seat":"4","userId":"661d508c72418a2e98cf7978"},{"available":true,"_id":"667f244c738bca04e08a02ea","seat":"5"},{"available":true,"_id":"667f244c738bca04e08a02eb","seat":"6"},{"available":true,"_id":"667f244c738bca04e08a02ec","seat":"7"},{"available":true,"_id":"667f244c738bca04e08a02ed","seat":"8"},{"available":true,"_id":"667f244c738bca04e08a02ee","seat":"9"},{"available":true,"_id":"667f244c738bca04e08a02ef","seat":"10"},{"available":true,"_id":"667f244c738bca04e08a02f0","seat":"11"},{"available":true,"_id":"667f244c738bca04e08a02f1","seat":"12"},{"available":true,"_id":"667f244c738bca04e08a02f2","seat":"13"},{"available":true,"_id":"667f244c738bca04e08a02f3","seat":"14"},{"available":true,"_id":"667f244c738bca04e08a02f4","seat":"15"},{"available":true,"_id":"667f244c738bca04e08a02f5","seat":"16"},{"available":true,"_id":"667f244c738bca04e08a02f6","seat":"17"},{"available":true,"_id":"667f244c738bca04e08a02f7","seat":"18"},{"available":true,"_id":"667f244c738bca04e08a02f8","seat":"19"},{"available":true,"_id":"667f244c738bca04e08a02f9","seat":"20"},{"available":true,"_id":"667f244c738bca04e08a02fa","seat":"21"},{"available":true,"_id":"667f244c738bca04e08a02fb","seat":"22"},{"available":true,"_id":"667f244c738bca04e08a02fc","seat":"23"},{"available":true,"_id":"667f244c738bca04e08a02fd","seat":"24"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"25"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"26"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"27"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"28"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"29"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"30"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"31"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"32"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"33"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"34"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"35"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"36"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"37"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"38"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"39"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"40"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"41"},{"available":false,"_id":"667f244c738bca04e08a02fe","seat":"42"}],"estimatedDistance":0,"_id":"","internal":false,"legs":[{"startLocation":{"lat":-34.394115,"lon":-70.78126},"endLocation":{"lat":-34.395,"lon":-70.782},"type":"pre","customParamsAtStart":{"name":"km_de_inicio_pre","value":1},"customParamsAtTheEnd":[{"name":"km_de_salida_pre","value":1}],"preTripChecklist":[{"name":"Cosas_para_comer_manzana","value":true},{"name":"Cosas_para_comer_naranja","value":false},{"name":"Cosas_para_comer_pera","value":true}]},{"startLocation":{"lat":-34.394115,"lon":-70.78126},"endLocation":{"lat":-34.395,"lon":-70.782},"type":"service","customParamsAtStart":[],"customParamsAtTheEnd":[]},{"startLocation":{"lat":-34.394115,"lon":-70.78126},"endLocation":{"lat":-34.395,"lon":-70.782},"type":"post","customParamsAtStart":[{"name":"como_lo_pasaste","value":"bien"}],"customParamsAtTheEnd":[]}],"name":"","odd":false,"oddType":"","offlineSync":{"historical":[],"internalId":"${uuid}","synced":false},"passengersLinked":[],"passengersToLink":[],"preTripChecklist":[],"previouslyActive":false,"realStartLocation":{"_id":"","internalId":"c60b8cb6-c269-49e1-a6bf-4d1d10598bADb","lat":-34.394115,"lon":-70.78126},"reason":"","reservations":[],"rounds":2,"routeId":"670e7eee96855505c81c2e4d","scheduled":false,"startCapacity":42,"startLocation":{"_id":"","internalId":"448aac16-9362-4385-9b6f-110b174c7b60","lat":-34.394115,"lon":-70.78126},"startedAt":"2024-06-28T15:47:32.216-04:00","state":"","superCommunityId":"653fd68233d83952fafcd4be","tickets":0,"token":"","unboardings":1,"validations":[],"vehicleId":"65b13780fd1711a264653aa1"}],"events":[{"_id":"${uuid}","type":"boarding","communityId":"653fd601f90509541a748683","routeId":"670e7eee96855505c81c2e4d","departureId":"${uuid}","lat":-33.39073098922399,"lon":-70.54616911670284,"loc":[-70.54616911670284,-33.39073098922399],"__v":0,"createdAt":"2024-10-08T19:27:05.712Z","updatedAt":"2024-10-08T19:27:05.712Z"},{"_id":"${uuid_events2}","type":"unboarding","communityId":"653fd601f90509541a748683","routeId":"670e7eee96855505c81c2e4d","departureId":"${uuid}","lat":-33.39073098922399,"lon":-70.54616911670284,"loc":[-70.54616911670284,-33.39073098922399],"__v":0,"createdAt":"2024-10-08T19:27:05.712Z","updatedAt":"2024-10-08T19:27:05.712Z"}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    
    Should Not Be Empty    ${response.json()}
    Status Should Be    200

    #--------------------DEPARTURE-------------------##
    ${departureId}=     Set Variable      ${response.json()}[departures][0][_id]
    Set Global Variable    ${departureId}
    ##${is int}=      Evaluate     isinstance(${departureId}, int) 
    ${departureToken}=     Set Variable     ${response.json()}[departures][0][token]
    Set Global Variable    ${departureToken}
    ${driverCodeResponse}=     Set Variable    ${response.json()}[departures][0][driverCode]
    Should Be Equal As Strings    ${driverCodeResponse}    1712
    ${superCommunityId}=     Set Variable    ${response.json()}[departures][0][superCommunityId]
    Should Be Equal As Strings    ${superCommunityId}    653fd68233d83952fafcd4be
    ${communityId}=     Set Variable    ${response.json()}[departures][0][communityId]
    Should Be Equal As Strings    ${communityId}    653fd601f90509541a748683
    ${boardings}=    Set Variable        ${response.json()}[departures][0][boardings]
    Should Be Equal As Numbers    ${boardings}    1
    ${unboardings}=    Set Variable        ${response.json()}[departures][0][unboardings]
    Should Be Equal As Numbers    ${unboardings}    1
    ${state_Active}=    Set Variable        ${response.json()}[departures][0][active]
    Should Be Equal As Strings    ${state_Active}    False
    ${superCommunities}=    Set Variable        ${response.json()}[departures][0][superCommunities][0]
    Should Be Equal As Strings    ${superCommunities}    653fd68233d83952fafcd4be
    ${communities}=    Set Variable        ${response.json()}[departures][0][communities][0]
    Should Be Equal As Strings    ${communities}    653fd601f90509541a748683
    ${driverId}=    Set Variable        ${response.json()}[departures][0][driverId]
    Should Be Equal As Strings    ${driverId}    658b4c89f6f903bbee966467
    ${routeId}=    Set Variable        ${response.json()}[departures][0][routeId]
    Should Be Equal As Strings    ${routeId}    670e7eee96855505c81c2e4d
    ${offlineSync}=    Set Variable        ${response.json()}[departures][0][offlineSync][historical]
    Length Should Be    ${offlineSync}    1
    ${offlineSyncId}=    Set Variable    ${response.json()}[departures][0][offlineSync][_id]
    ${offlineSync_synced}=    Set Variable        ${response.json()}[departures][0][offlineSync][synced]
    Should Be Equal As Strings    ${offlineSync_synced}    True
    ${offlineSync_internalId}=    Set Variable        ${response.json()}[departures][0][offlineSync][internalId] 
    ${legs}=    Set Variable        ${response.json()}[departures][0][legs][0]
    ${legs_startLocation}=    Set Variable        ${response.json()}[departures][0][legs][0][startLocation][_id]
    ${legs_endLocation}=    Set Variable        ${response.json()}[departures][0][legs][0][endLocation][_id]
    ${legs_preTripCheckList}=    Set Variable        ${response.json()}[departures][0][legs][0][preTripChecklist]
    #${legs_customParamsAtStart}=    Set Variable        ${response.json()}[departures][0][legs][0][customParamsAtStart]
   # ${legs_customParamsAtEnd}=    Set Variable        ${response.json()}[departures][0][legs][0][customParamsAtEnd]
    Should Be Equal As Strings    ${driverCodeResponse}    1712
    ${preTripCheckList}=    Set Variable        ${response.json()}[departures][0][preTripChecklist]
    ${customParams}=    Set Variable        ${response.json()}[departures][0][customParams]
    Length Should Be    ${customParams}      1
    ${customParams_Value}=    Set Variable        ${response.json()}[departures][0][customParams][0][value]
    Should Be Equal As Numbers    ${customParams_Value}    1
    ${customParamsAtEnd}=    Set Variable        ${response.json()}[departures][0][customParamsAtTheEnd]
    Length Should Be    ${customParamsAtEnd}    1
    ${customParamsAtEnd_Value}=    Set Variable        ${response.json()}[departures][0][customParamsAtTheEnd][0][value]
    Should Be Equal As Numbers    ${customParamsAtEnd_Value}    2 
    ${vehicleId}=    Set Variable        ${response.json()}[departures][0][vehicleId]
    Should Be Equal As Strings    ${vehicleId}      65b13780fd1711a264653aa1

    #--------------------EVENTS-------------------------------------------------##
    ${eventsLength}=    Set Variable    ${response.json()}[events]
    Length Should Be    ${eventsLength}    2
    ${eventsBoarding}=    Set Variable    ${response.json()}[events][0][type]
    Should Be Equal As Strings    ${eventsBoarding}    boarding
    ${eventsUnBoarding}=    Set Variable    ${response.json()}[events][1][type]
    Should Be Equal As Strings    ${eventsUnBoarding}    unboarding
    

Sync validations offline
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/validations/sync/${idSuperCommunity}
    ...    data={"validations":[{"assignedSeat":"2","communityId":"653fd601f90509541a748683","createdAt":"2024-10-08T19:35:10.885Z","departureId":"${departureId}","_id":"${uuid_custom}","isCustom":true,"isDNI":false,"isManual":false,"key":"rut","latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"","reason":["custom"],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"654a5148bf3e9410d0bcd39a","validated":true,"value":"126278489"},{"assignedSeat":"3","communityId":"${idComunidad}","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico}","reason":[],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"${idNico}","validated":true},{"assignedSeat":"3","communityId":"653fd601f90509541a748683","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_dni}","isCustom":false,"isDNI":true,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"https://portal.sidiv.registrocivil.cl/docstatus?RUN=19186681-9&type=CEDULA&serial=107182779&mrz=107182779695092742509275","reason":[],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"${idDNI}","validated":true}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
        ${validations}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${response.json()}
    Status Should Be    200

    FOR    ${validation}    IN    @{validations}
    # Verifica que cada objeto no esté vacío
        Should Not Be Empty    ${validation}    Validations info is empty
    END

Get Assigned Tickets After Validation(Nico)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyNico}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "${idNico}"    BREAK
        Set Global Variable    ${assignedQtyNico}
    END
    Convert To Integer    ${assignedQtyNico}
    ${assignQtyMinus}=    Evaluate    ${assignQty}-1
    Convert To Integer    ${assignQtyMinus}
    Should Be True    ${assignedQtyNico}==${assignQtyMinus}         Doesn't discounts tickets after validation with QR, Expected tickets: ${assignQtyMinus}, Actual Tickets ${assignedQtyNico}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyNico}

Get Assigned Tickets After Validation(Pedro)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyPedro}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "${idPedro}"    BREAK
        Set Global Variable    ${assignedQtyPedro}
    END
    Convert To Integer    ${assignedQtyPedro}
    Convert To Integer    ${assignQty}
    Should Be True    ${assignedQtyPedro}==(${assignQty}-1)        Assigned quantity Pedro is not correct, should be ${assignQty} but it is ${assignedQtyPedro}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyPedro}

Get Assigned Tickets After Validation(DNI)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyDNI}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "653ff52433d83952fafcf397"    BREAK
        Set Global Variable    ${assignedQtyDNI}
    END
    Convert To Integer    ${assignedQtyDNI}
    Convert To Integer    ${assignQty}
    Should Be True    ${assignedQtyDNI}==(${assignQty}-1)        Assigned quantity Pedro is not correct, should be 1 but it is ${assignedQtyDNI}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyDNI}


Get Departure in admin, should be active false
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/departures/${departureId}?community=653fd601f90509541a748683


    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${responseJson}=    Set Variable    ${response.json()}
    ${activeDeparture}=    Set Variable    ${responseJson}[active]
    Should Be Equal As Strings    ${activeDeparture}    False
    ${boardings}=    Set Variable    ${responseJson}[boardings]
    Should Be Equal As Numbers    ${boardings}    1
    ${unboarding}=    Set Variable

    Log    ${response.content}


Check Payment Settlement (3 electronic tickets)

    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/paymentSettlement/list?community=653fd601f90509541a748683&search=&from=0

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Extrae directamente el objeto que sea type == electronicTicket
    ${electronicTicket}=    Evaluate    [m for m in ${responseJson}[paymentSettlement][0][paymentMethods] if m['type'] == 'electronicTicket'][0]    json

# Ahora ya tienes el objeto electronicTicket y puedes trabajar directo
    ${ticketqty}=    Set Variable    ${electronicTicket}[quantity]
    ${settlementId}=    Set Variable    ${responseJson}[paymentSettlement][0][_id]

   # Should Be Equal As Strings    ${electronicTicket}[type]    electronicTicket
   # Should Be Equal As Numbers    ${ticketqty}    3    There should be 3 electronic tickets, but there are ${ticketqty} in https://stage.allrideapp.com/api/v1/admin/pb/paymentSettlement/?community=653fd601f90509541a748683&settlementId=${settlementId}
  #  Should Be Equal As Numbers    ${electronicTicket}[value]    10    msg=❌ 'electronicTicket.value' should be 10, but was ${electronicTicket}[value]
#
   # ${paymentSettlement}=    Set Variable    ${responseJson}[paymentSettlement][0]
   # ${driverCode}=    Set Variable    ${paymentSettlement}[driverCode]

  #  Should Contain    ${paymentSettlement}    driverCode    No driverCode found
  #  Should Be Equal As Strings    ${driverCode}    1712    driverCode should be 1712 but it is ${driverCode}

