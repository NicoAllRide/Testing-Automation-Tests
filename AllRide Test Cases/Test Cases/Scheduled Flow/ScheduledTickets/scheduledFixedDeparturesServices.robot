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
        ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}

2 hours local
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Create Schedule Alto - Apumanque 19:00 hrs
    [Documentation]    Crea una ruta desde 0, fijando un horario relativo a la hora actual y limitando la capacidad a 1 pasajero.
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${endPoint}
    ...    data={"_id":"6807a6bd8ed59d3481d3f26b","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":5,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":5,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"stopSchedule":[{"stopId":"655d11d88a5a1a1ff0328466","scheduledDate":"2025-04-22T15:00:00.731Z"},{"stopId":"655d11d88a5a1a1ff0328464","scheduledDate":null}],"capped":{"enabled":true,"capacity":1,"by":"fixedDeparture"},"vehicleCategoryId":null,"defaultResources":[],"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["6807a6bd8ed59d3481d3f26b"],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"}},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"DNIValidation":{"enabled":false,"options":["qr"]},"validation":{"external":[]},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["653fd601f90509541a748683"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":false,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":false,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":false,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"hasBarrier":false,"name":"Fixed Departure","shapeId":"6807a6bd8ed59d3481d3f245","description":"Fixed Departure","extraInfo":"","color":"cb5b5b","legOptions":[{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100}}],"ownerIds":[{"_id":"6807a6bd8ed59d3481d3f270","id":"653fd601f90509541a748683","role":"community"}],"segments":[],"roundOrder":[{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false}],"communityId":"653fd601f90509541a748683","timeOnRoute":9,"distance":4,"distanceInMeters":4375,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2025-04-22T14:25:01.726Z","updatedAt":"2025-04-22T14:25:01.726Z","__v":0,"externalInfo":{"uuid":""},"routeCost":0,"ticketCost":0,"originStop":"655d11d88a5a1a1ff0328466","destinationStop":"655d11d88a5a1a1ff0328464","canReserve":true,"useServiceReservations":false,"autoStartConditions":{"enabled":false,"ignition":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false}}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    3s

Create services
    [Documentation]    Crea servicios asociados al schedule previamente creado. Se espera que al menos un servicio se cree exitosamente.
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
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    15s

Get Driver Token
    [Documentation]    Obtiene el accessToken de un conductor registrado, a partir de su ID y comunidad, para autenticación en futuras validaciones.
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad}&driverId=${driverId}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    List Should Contain Value    ${response.json()}    accessToken            No accesToken found in Driver info
    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver}

    Log    ${tokenDriver}
    Log    ${response.content}

    Sleep    3s


Login User With Email(Obtain Token)
    [Documentation]    Realiza login del usuario "nicolas+endauto" y guarda su token de autenticación para ser usado en la reserva de asientos.
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+endauto@allrideapp.com","password":"Equilibriozen123#"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    List Should Contain Value    ${response.json()}    accessToken            No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}
    sleep     15s



Get Service Id
    [Documentation]    Obtiene el ID del último servicio creado con el schedule actual. Verifica también que se haya creado correctamente.
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_pasttomorrow}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_scheduled_services}=    Get Length    ${responseJson}
    
    # Ordenamos los servicios por createdAt

    ${sorted_services}=    Evaluate    sorted(${responseJson}, key=lambda x: x['createdAt'])    json
    ${sorted_services}=    Evaluate    [service for service in ${responseJson} if service['routeId']['_id'] == '${scheduleId}']    json


    Run Keyword If    ${sorted_services} == []    Fatal Error    msg= No services were created with routeId._id = "${scheduleId}" All createSheduled Tests Failing(Fatal error)
    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}
    
    Set Global Variable    ${service_id}

    Log    Last created service ID: ${service_id}


Seat Reservation(User1-NicoEnd)
    [Documentation]    Realiza la reserva de asiento del primer usuario (NicoEnd). Si la capacidad del servicio es 1, esta debería ser la única reserva válida permitida.

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id}","stopId":"655d11d88a5a1a1ff0328464"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Run Keyword If    '${code}' == '200' or '${code}' == '409'    Log    Status code is acceptable: ${code}
    ...    ELSE    Fail    Unexpected status code: ${code}
    Log    ${code}
    Sleep    5s

Seat Reservation(User2-Pedro Pascal Available Seat)
    [Documentation]    Si el usuario 1 ya reservó correctamente y la capacidad está llena, este usuario no debería poder reservar. Se espera un error 409.

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenPedroPascal}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=   Run Keyword and expect error     HTTPError: 409 Client Error: Conflict for url: https://stage.allrideapp.com/api/v1/pb/user/booking     POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id}","stopId":"655d11d88a5a1a1ff0328464"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Sleep    5s
Seat Reservation(User3-Kratos Available Seat)
    [Documentation]    Si la capacidad sigue siendo 1 y el usuario 1 ya reservó, este usuario tampoco debería poder reservar. Se espera un error 409.

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenKratos}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=   Run Keyword and expect error     HTTPError: 409 Client Error: Conflict for url: https://stage.allrideapp.com/api/v1/pb/user/booking  POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id}","stopId":"655d11d88a5a1a1ff0328464"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Sleep    3s
Get reservations (Should only be one)
    [Documentation]    Verifica que solo exista una reserva asociada al servicio. Si hay más de una, indica que el control de capacidad falló.

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/service/${service_id}?community=${idComunidad}
    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    1        More reservations found in service, there should only be one
    ${reservation_userid}=    Set Variable    ${response.json()}[reservations][0][userId][_id]
    ${reservationId}=    Set Variable    ${response.json()}[reservations][0][_id]

    Set Global Variable    ${reservationId}

    Log    ${response.content}

Delete Route
    [Documentation]    Elimina la ruta y su programación asociada, dejando el sistema limpio tras la ejecución de las pruebas.

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/${scheduleId}?community=653fd601f90509541a748683
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    5s