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



*** Test Cases ***
Set Date Variables
    ${fecha_hoy}=    Get Current Date    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_hoy}

    ${fecha_manana}=    Add Time To Date    ${fecha_hoy}    1 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_manana}

    ${fecha_pasado_manana}=    Add Time To Date    ${fecha_hoy}    2 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_pasado_manana}
    ${fecha_pasado_pasado_manana}=    Add Time To Date    ${fecha_hoy}    3 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_pasado_pasado_manana}

    ${dia_actual}=    Convert Date    ${fecha_hoy}    result_format=%a
    ${dia_actual_lower}=    Set Variable    ${dia_actual.lower()}

    ${arrival_date}=    Set Variable    ${fecha_manana}T01:00:00.000Z
    Set Global Variable    ${arrival_date}
    ${r_estimated_arrival1}=    Set Variable    ${fecha_manana}T14:45:57.000Z
    Set Global Variable    ${r_estimated_arrival1}
    ${service_date}=    Set Variable    ${fecha_manana}T00:25:29.000Z
    Set Global Variable    ${service_date}
    ${modified_arrival_date}=    Set Variable    ${fecha_manana}T01:00:00.000Z
    Set Global Variable    ${modified_arrival_date}
    ${r_modified_estimated_arrival}=    Set Variable    ${fecha_pasado_manana}T14:45:57.000Z
    Set Global Variable    ${r_modified_estimated_arrival}
    ${modified_service_date}=    Set Variable    ${fecha_manana}T00:25:29.000Z
    Set Global Variable    ${modified_service_date}
    ${service_date_20min}=    Set Variable    ${fecha_manana}T00:20:00.000Z
    Set Global Variable    ${service_date_20min}
    ${service_date_22min}=    Set Variable    ${fecha_manana}T00:47:00.000Z
    Set Global Variable    ${service_date_22min}
    ${start_date}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    Set Global Variable    ${start_date}
    ${end_date_4weeks}=    Set Variable    2023-12-30T02:59:59.999Z
    Set Global Variable    ${end_date_4weeks}
    ${end_date}=    Set Variable    ${fecha_pasado_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date}
    ${end_date_tomorrow}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_tomorrow}
    ${schedule_day}=    Set Variable    ${dia_actual_lower}
    Set Global Variable    ${schedule_day}
    ${start_date_today}=    Set Variable    ${fecha_hoy}T03:00:00.000Z
    Set Global Variable    ${start_date_today}
    ${today_date}=    Set Variable    ${fecha_hoy}
    Set Global Variable    ${today_date}
    ${end_date_tomorrow2}=    Set Variable    ${fecha_manana}T02:59:59.999Z
    Set Global Variable    ${end_date_tomorrow}
    ${expiration_date_qr}=    Set Variable    ${fecha_manana}T14:10:37.968Z
    Set Global Variable    ${expiration_date_qr}
    ${start_date_tickets}=     Set Variable     ${fecha_hoy}T04:00:00.000Z
        Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=     Set Variable     ${fecha_manana}T03:59:59.999Z
        Set Global Variable    ${end_date_tickets}

2 hours local
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

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
Generate random UUID3 (_id validations qrValidations)
    ${uuid_qr3}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr3}
    Set Global Variable    ${uuid_qr3}
Generate random UUID3 (_id validations qrValidations)
    ${uuid_qr4}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr4}
    Set Global Variable    ${uuid_qr4}
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

Get Requested Tickets(Must be 0)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/request/list/?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    Should Be Empty    ${responseJson}    Requested Tickets Should be 0 

    Log    ${responseJson}

Get Total Tickets
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad}
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${tickets_list}=    Set Variable    ${response.json()}

    ${ticketGeneral}=    Set Variable    0
    FOR    ${ticket}    IN    @{tickets_list}
        IF    "${ticket['name']}" == "Ticket general"
            ${ticketGeneral}=    Set Variable    ${ticket['total']}
        END
    END

    Log    La cantidad de tickets generales es ${ticketGeneral}
    Set Global Variable    ${ticketGeneral}

Request Tickets
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/request?community=${idComunidad}
    ...    data={"ticketQuantity":1,"cost":10,"voucherUrl":"https://s3.amazonaws.com/allride.uploads/privateBuses_voucher_653fd601f90509541a748683_1710787761571.pdf"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${ticketRequestId}=    Set Variable    ${response.json()}[_id]
    ${ticketRequestQty}=    Set Variable    ${response.json()}[ticketQuantity]
    Set Global Variable    ${ticketRequestId}
    Set Global Variable    ${ticketRequestQty}
    Should Be Equal As Strings    pendingApproval    ${response.json()}[state]        The state of the tickets should be pendingApproval but the state is ${response.json()}[state]
    Log    ${ticketRequestId}
    Log    ${ticketRequestQty}

Get Requested Tickets(Should Not Be 0)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/request/list/?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    Should Not Be Empty    ${responseJson}    The requested tickets should not be 0, but is empty

    Log    ${responseJson}

Treasurer Request Approval
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/request/approve/treasurer?community=${idComunidad}&requestId=${ticketRequestId}&userId=${idAdmin}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${ticketResponseId}=    Set Variable    ${responseJson}[ticketRequestRes][_id]
    ${ticketResponseQty}=    Set Variable    ${responseJson}[ticketRequestRes][ticketQuantity]
    ${ticketResponseState}=    Set Variable    ${responseJson}[ticketRequestRes][state]

    Should Be Equal As Strings    ${ticketResponseId}    ${ticketRequestId}        The ticket requestId is not the same in the response after Treasure Approval, is ${ticketResponseId}
    Should Be Equal As Strings    ${ticketResponseQty}    ${ticketRequestQty}        The ticket request quantity is not the same in the response after Treasure Approval, is ${ticketResponseQty}
    Should Be Equal As Strings    ${ticketResponseState}    pendingApproval            The state after Treasure Approval is ${ticketResponseState}

    Log    ${responseJson}

Seller Request Approval
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/request/approve/seller?community=${idComunidad}&requestId=${ticketRequestId}&userId=${idAdmin}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${ticketResponseId}=    Set Variable    ${responseJson}[ticketRequestRes][_id]
    ${ticketResponseQty}=    Set Variable    ${responseJson}[ticketRequestRes][ticketQuantity]
    ${ticketResponseState}=    Set Variable    ${responseJson}[ticketRequestRes][state]
    ${ticketAssignedQuantity}=    Set Variable    ${responseJson}[ticketRequestRes][assignedQuantity]

    Should Be Equal As Strings    ${ticketResponseId}    ${ticketRequestId}
    Should Be Equal As Strings    ${ticketResponseQty}    ${ticketRequestQty}
    Should Be Equal As Strings    ${ticketResponseState}    approved
    Should Be Equal As Strings    ${ticketAssignedQuantity}    ${ticketRequestQty}

    Log    ${responseJson}

Get Total Tickets(After Request)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad}
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}

    # Guardamos el JSON
    ${tickets_list}=    Set Variable    ${response.json()}

    # Extraemos SOLO el total de "Ticket general"
    ${totalTicketsAfterRequest}=    Evaluate    [t["total"] for t in ${tickets_list} if t["name"]=="Ticket general"][0]

    Convert To Integer    ${ticketGeneral}
    Convert To Integer    ${ticketRequestQty}

    ${ticketsPlus}=    Evaluate    ${ticketGeneral}+${ticketRequestQty}
    Should Be True    ${totalTicketsAfterRequest}==${ticketsPlus}

    Log    La cantidad de tickets generales después de la solicitud es ${totalTicketsAfterRequest}
    Set Global Variable    ${totalTicketsAfterRequest}

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

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}        



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

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}

Assing Tickets(DNI)
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

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}



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

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}


Get Assigned Tickets (Nico)
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

    Should Be True    ${assignedQtyNico}==${assignQty}            Assigned tickets Nico should be ${assignQty} but it is ${assignedQtyNico} The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyNico}

Get Assigned Tickets (Kratos)
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
        ${assignedQtyKratos}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "${idKratos}"    BREAK
        Set Global Variable    ${assignedQtyKratos}
    END

     Should Be True    ${assignedQtyKratos}==${assignQty}            Assigned tickets Kratos should be ${assignQty} but it is ${assignedQtyKratos}; The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyKratos}

Get Assigned Tickets (Pedro)
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

    Should Be True    ${assignedQtyPedro}==${assignQty}        Assigned tickets Pedro should be ${assignQty} but it is ${assignedQtyPedro}; The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyPedro}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Create services PABLO
        skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/680bcf8989a04026d771e09a?community=653fd601f90509541a748683
    ...    data={"_id":"680bcf8989a04026d771e09a","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":5,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":5,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"fri","time":"15:55","estimatedArrival":null,"capped":{"enabled":false,"capacity":0,"by":"vehicle"},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"_id":"680bcfb489a04026d771e363","stopId":"6654d4acba54fe502d4e6b6b","scheduledDate":"2025-04-25T19:05:00.435Z"},{"_id":"680bcfb489a04026d771e364","stopId":"6654d4c8713b9a5184cfe1df","scheduledDate":null}],"defaultResources":[],"_ogIndex":0},{"enabled":true,"day":"fri","time":"15:40","estimatedArrival":null,"stopSchedule":[{"stopId":"6654d4acba54fe502d4e6b6b","scheduledDate":"2025-04-25T19:40:38.951Z"},{"stopId":"6654d4c8713b9a5184cfe1df","scheduledDate":null}],"capped":{"enabled":false,"capacity":0,"by":"vehicle"},"vehicleCategoryId":null,"defaultResources":[],"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"_ogIndex":1}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["680bcf8989a04026d771e09a"],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"},"estimatedDuration":{"byPercentage":{"enabled":false,"amount":0,"timer":{"amount":0,"unit":"minutes"}},"byTime":{"enabled":false,"amount":0,"unit":"minutes","timer":{"amount":0,"unit":"minutes"}}}},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"DNIValidation":{"enabled":false,"options":["qr"]},"validation":{"external":[]},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"active":false,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":false,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":false,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":false,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":false,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"hasBarrier":false,"name":"BUG PABLO MX","shapeId":"680bcf8989a04026d771e058","description":"BUG PABLO MX","extraInfo":"","color":"754e4e","legOptions":[{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100},"ETA":{"enabled":null,"update":{"amount":0,"unit":"minutes"},"visibility":["admin"],"notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}}}],"ownerIds":[{"_id":"680bcf8989a04026d771e0a2","id":"653fd68233d83952fafcd4be","role":"superCommunity"}],"segments":[],"roundOrder":[{"stopId":"6654d4acba54fe502d4e6b6b","notifyIfPassed":false},{"stopId":"6654d4c8713b9a5184cfe1df","notifyIfPassed":false}],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":13,"distance":9,"distanceInMeters":8521,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2025-04-25T18:08:09.734Z","updatedAt":"2025-04-25T18:31:09.799Z","__v":9,"autoStartConditions":{"enabled":false,"ignition":false,"allowStop":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"destinationStop":"6654d4c8713b9a5184cfe1df","externalInfo":{"uuid":""},"originStop":"6654d4acba54fe502d4e6b6b","routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"useServiceReservations":false,"routeCost":10,"ticketCost":10,"deletedAt":"2025-04-25T18:31:09.794Z"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}
    Sleep    2s

Create services
        skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/653fd601f90509541a748683?community=653fd601f90509541a748683
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s

Get Service Id
    skip
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id}=    Set Variable    None

    
    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate    sorted([s for s in ${responseJson} if s['routeId']['_id'] == '${scheduleId}'], key=lambda x: x['createdAt'])    json


    Run Keyword If    ${sorted_services} == []    Fatal Error    msg= No services were created with routeId._id = "${scheduleId}" All createSheduled Tests Failing(Fatal error)
    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}
    
    Set Global Variable    ${service_id_tickets}

    Log    Last created service ID: ${service_id}

    

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad}&driverId=${driverId}

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


Start Departure Leg
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures
    ...    data={"communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"routeId":"680bda0089a04026d7728f95","capacity":5,"busCode":"1712","vehicleId":"65b13780fd1711a264653aa1","shareToUsers":false,"customParams":[],"pin":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]    
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${departureToken}
    Log    ${departureToken}
    Log    ${code}
    ${departureId}=     Set Variable    ${response.json()}[_id]
    Set Global Variable    ${departureId}

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

Validate With QR(KRATOS)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeKratos}","timezone":"America/Santiago","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}



Stop Post Leg Departure
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":false,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Get User QR(Another Community User) 1
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=6654ae4eba54fe502d4e4187
    ...    data={"ids":["666078059a5ece0ee6e95904"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNotPart}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNotPart}
    Log    ${qrCodeNotPart}
    Log    ${code}

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
    ...    data={"validations":[{"assignedSeat":"","communityId":"${idComunidad}","createdAt":"2024-10-08T19:35:10.885Z","departureId":"${departureId}","_id":"${uuid_manual}","isCustom":false,"isDNI":false,"isManual":true,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"","reason":["manual_validation"],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"","validated":false},{"assignedSeat":"2","communityId":"653fd601f90509541a748683","createdAt":"2024-10-08T19:35:10.885Z","departureId":"${departureId}","_id":"${uuid_custom}","isCustom":true,"isDNI":false,"isManual":false,"key":"rut","latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"","reason":["custom"],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"654a5148bf3e9410d0bcd39a","validated":false,"value":"126278489"},{"assignedSeat":"3","communityId":"${idComunidad}","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico}","reason":[],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"${idNico}","validated":false},{"assignedSeat":"3","communityId":"653fd601f90509541a748683","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_dni}","isCustom":false,"isDNI":true,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"https://portal.sidiv.registrocivil.cl/docstatus?RUN=19186681-9&type=CEDULA&serial=107182779&mrz=107182779695092742509275","reason":[],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"${idDNI}","validated":false},{"assignedSeat":"5","communityId":"653fd601f90509541a748683","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr3}","isCustom":false,"isDNI":true,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"https://portal.sidiv.registrocivil.cl/docstatus?RUN=19186681-9&type=CEDULA&serial=107182779&mrz=107182779695092742509275","reason":[],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"66f5bee8f3a0b05c0092e702","validated":false},{"assignedSeat":"6","communityId":"${idComunidad}","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr4}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNotPart}","reason":[],"remainingTickets":0,"routeId":"680bda0089a04026d7728f95","synced":false,"token":"","userId":"666078059a5ece0ee6e95904","validated":false}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    
    Should Not Be Empty    ${response.json()}
    ${validations}=    Set Variable    ${response.json()}
    ${data}=    Set Variable    ${response.json()}

    ${is_list}=    Evaluate    isinstance($data, (list, tuple))
    Run Keyword If    ${is_list}    Set Variable    ${validations}    ${data}
    ...    ELSE    Create List    ${data}

    FOR    ${v}    IN    @{validations}
        Should Not Be Empty    ${v}    ❌ Validation item is empty.
        ${id}=          Set Variable    ${v}[_id]
        ${validated}=   Set Variable    ${v}[validated]
        ${reasons}=     Set Variable    ${v}[reason]

        Should Be Equal As Strings    ${validated}    False
        ...    msg=❌ Expected 'validated' to be False but got True. id=${id} | reasons=${reasons}
    END


    Status Should Be    200




Get Assigned Tickets After Validation(Nico)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    ${assignedQtyNico}=    Set Variable    0
    FOR    ${user}    IN    @{responseJson}
        IF    "${user}[id]" == "${idNico}"
            ${assignedQtyNico}=    Set Variable    ${user}[availableTickets]
            BREAK
        END
    END

    Should Be Equal As Integers    ${assignedQtyNico}    2
    ...    msg=Expected 2 assigned tickets, but got ${assignedQtyNico}



Get Assigned Tickets After Validation(Pedro)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    ${assignedQtyPedro}=    Set Variable    0
    FOR    ${user}    IN    @{responseJson}
        IF    "${user}[id]" == "${idPedro}"
            ${assignedQtyPedro}=    Set Variable    ${user}[availableTickets]
            BREAK
        END
    END

    Should Be Equal As Integers    ${assignedQtyPedro}    2
    ...    msg=Expected 2 assigned tickets, but got ${assignedQtyPedro}


Get Assigned Tickets After Validation(DNI)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    ${assignedQtyDNI}=    Set Variable    0
    FOR    ${user}    IN    @{responseJson}
        IF    "${user}[id]" == "653ff52433d83952fafcf397"
            ${assignedQtyDNI}=    Set Variable    ${user}[availableTickets]
            BREAK
        END
    END

    Should Be Equal As Integers    ${assignedQtyDNI}    2
    ...    msg=Expected 2 assigned tickets, but got ${assignedQtyDNI}



Get Assigned Tickets After Validation(Kratos) Should discount
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    ${assignedQtyKratos}=    Set Variable    0
    FOR    ${user}    IN    @{responseJson}
        IF    "${user}[id]" == "${idKratos}"
            ${assignedQtyKratos}=    Set Variable    ${user}[availableTickets]
            BREAK
        END
    END

    Should Be Equal As Integers    ${assignedQtyKratos}    1
    ...    msg=Expected 1 assigned tickets, but got ${assignedQtyKratos}


Get Assigned Tickets After Validation(Pedro)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    ${assignedQtyPedro}=    Set Variable    0
    FOR    ${user}    IN    @{responseJson}
        IF    "${user}[id]" == "${idPedro}"
            ${assignedQtyPedro}=    Set Variable    ${user}[availableTickets]
            BREAK
        END
    END

    Should Be Equal As Integers    ${assignedQtyPedro}    2
    ...    msg=Expected 2 assigned tickets, but got ${assignedQtyPedro}


Get Report Id
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/departures/${departureId}?community=${idComunidad}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}

        Status Should Be    200
    Log    ${code}

    Sleep    5s

Get Passenger Details(Validations)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/departureValidations/${departureId}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Sleep    1s
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}         Departure has no validation details, check again for possible failing   
    ${responseJson}=    Set Variable    ${response.json()}[0]


    Log    ${response.content}




Check Payment Settlement (4 electronic tickets)

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

    Should Be Equal As Strings    ${electronicTicket}[type]    electronicTicket
      Should Be Equal As Numbers    ${ticketqty}    1    There should be 1 electronic tickets, but there are ${ticketqty} in https://stage.allrideapp.com/api/v1/admin/pb/paymentSettlement/?community=653fd601f90509541a748683&settlementId=${settlementId}
  #  Should Be Equal As Numbers    ${electronicTicket}[value]    10    msg=❌ 'electronicTicket.value' should be 10, but was ${electronicTicket}[value]

   # ${paymentSettlement}=    Set Variable    ${responseJson}[paymentSettlement][0]
   # ${driverCode}=    Set Variable    ${paymentSettlement}[driverCode]

  #  Should Contain    ${paymentSettlement}    driverCode    No driverCode found
  #  Should Be Equal As Strings    ${driverCode}    1712    driverCode should be 1712 but it is ${driverCode}


