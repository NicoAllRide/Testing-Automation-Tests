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
    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}
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

2 hours local
    ${date}=    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}=    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}=    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}=    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Create Schedule Alto - Apumanque 19:00 hrs
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes?community=653fd601f90509541a748683
    ...    data={"name":"Limite validaciones RF(1)","description":"Limite validaciones RF","communities":["67b879e99a2ba09f940ea7c5"],"superCommunities":["653fd68233d83952fafcd4be"],"ownerIds":[{"id":"67b879e99a2ba09f940ea7c5","role":"community"}],"externalInfo":{"uuid":""},"assistantIds":[],"shapeId":"67fd1ec97b753207e7fcfb0d","usesBusCode":false,"usesVehicleList":true,"usesDriverCode":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"dynamicSeatAssignment":false,"usesTickets":false,"startsOnStop":false,"notNearStop":false,"routeCost":0,"ticketCost":0,"excludePassengers":{"active":false,"excludeType":"dontHide"},"restrictPassengers":{"enabled":false,"allowed":[],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"endDepartureNotice":{"enabled":false,"lastStop":null},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"stopSchedule":[],"capped":{"enabled":false,"capacity":0,"by":"vehicle"},"vehicleCategoryId":null,"defaultResources":[],"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"allowsServiceSnapshots":false,"allowsNonServiceSnapshots":false,"labels":[],"roundOrder":[],"anchorStops":[],"originStop":"67b883869a2ba09f940eaa14","destinationStop":"67b883979a2ba09f940eaa20","hasBeacons":false,"hasCapacity":false,"isStatic":false,"showParable":false,"extraInfo":"","color":"602e2e","usesManualSeat":false,"allowsManualValidation":false,"usesDriverPin":false,"hasBoardings":false,"hasUnboardings":false,"allowsDistance":false,"allowGenericVehicles":false,"hasExternalGPS":false,"departureHourFulfillment":{"enabled":false,"ranges":[]},"usesOfflineCount":false,"useServiceReservations":false,"autoStartConditions":{"enabled":false,"ignition":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"visible":true,"active":true,"usesTextToSpeech":false,"hasBoardingCount":false,"hasRounds":false,"hasUnboardingCount":false,"timeOnRoute":9,"distance":5,"distanceInMeters":5105,"legOptions":[{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100}}],"validateDeparture":{"enabled":false},"rounds":{"enabled":false,"anchorStops":[]},"trail":{"enabled":false,"adjustByRounds":false},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"assistantAssignsSeat":true,"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"internal":false,"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"}},"route_type":3}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s

Create services
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/67b879e99a2ba09f940ea7c5?community=67b879e99a2ba09f940ea7c5
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    202
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=67b879e99a2ba09f940ea7c5&driverId=67b884c5b5ebd5b87145e5c3

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

    sleep     5s

Get Service Id
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=67b879e99a2ba09f940ea7c5&startDate=${start_date_today}&endDate=${end_date_pastTomorrow}

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_scheduled_services}=    Get Length    ${responseJson}
    # Ordenamos los servicios por createdAt

    ${sorted_services}=    Evaluate    sorted(${responseJson}, key=lambda x: x['createdAt'])    json
    ${sorted_services}=    Evaluate
    ...    [service for service in ${responseJson} if service['routeId']['_id'] == '${scheduleId}']
    ...    json

    IF    ${sorted_services} == []
        Fatal Error
        ...    msg= No services were created with routeId._id = "${scheduleId}" All createSheduled Tests Failing(Fatal error)
    END
    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}

    Set Global Variable    ${service_id}

    Log    Last created service ID: ${service_id}



Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id}?community=67b879e99a2ba09f940ea7c5
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"67b884c5b5ebd5b87145e5c3"},"drivers":[],"vehicle":{"vehicleId":"67ed2e71a45b6aa00234a2ff","capacity":"5"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Get departureId
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${departureId}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    Set Global Variable    ${departureId}

    Log    ${departureId}
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
    ...    url=/api/v2/pb/driver/departure/${departureId}
    ...    data={"departureId":"${departureId}","communityId":"67b879e99a2ba09f940ea7c5","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":5,"busCode":"123","driverCode":"753","vehicleId":"67ed2e71a45b6aa00234a2ff","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken}
    Log    ${code}
    Set Global Variable    ${departureToken}

Validate With Card, first validation should pass
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json

   ${response}=   POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/tickets/validation/126278489
    ...    data={"communityId":"67b879e99a2ba09f940ea7c5","key":"rut","value":"126278489","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}

    Status Should Be    200        msg=First validation of the first user should pass but is failing


Check validation succeeded
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/validations/list?community=67b879e99a2ba09f940ea7c5&page=1&pageSize=200
    ...    data={"advancedSearch":false,"startDate":"${fecha_hoy}T03:00:00.000Z","endDate":"${fecha_manana}T02:59:59.999Z","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"Rut","value":""},{"key":"color","value":""},{"key":"animal","value":""},{"key":"Empresa","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos las validaciones por createdAt
    ${sorted_validations}=    Evaluate    sorted(${responseJson}[validations], key=lambda x: x['createdAt'])    json

    # Obtenemos la última validación
    ${last_validation}=    Set Variable    ${sorted_validations[-1]}

    ${last_reason}=    Get From List    ${last_validation['reason']}    0
    ${validated}=    Set Variable    ${last_validation['validated']}

    Should Be True    ${validated}    Validation status should be true, but is false, failing

    Should Be Equal As Strings    ${last_reason}    card
    Status Should Be    200

    Log    Última validación: ${last_validation}

Validate With Card, second validation should fail
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Run Keyword And Expect Error
    ...    HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v2/pb/driver/tickets/validation/126278489
    ...    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/tickets/validation/126278489
    ...    data={"communityId":"67b879e99a2ba09f940ea7c5","key":"rut","value":"126278489","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Status Should Be    403    msg=Second validation of the same user should fail but is not failing

Check validation 2 Failed
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/validations/list?community=67b879e99a2ba09f940ea7c5&page=1&pageSize=200
    ...    data={"advancedSearch":false,"startDate":"${fecha_hoy}T03:00:00.000Z","endDate":"${fecha_manana}T02:59:59.999Z","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"Rut","value":""},{"key":"color","value":""},{"key":"animal","value":""},{"key":"Empresa","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos las validaciones por createdAt
    ${sorted_validations}=    Evaluate    sorted(${responseJson}[validations], key=lambda x: x['createdAt'])    json

    # Obtenemos la última validación
    ${last_validation}=    Set Variable    ${sorted_validations[-1]}

    ${last_reason}=    Get From List    ${last_validation['reason']}    0
    ${validated}=    Set Variable    ${last_validation['validated']}

    Should Be Equal As Strings    ${validated}    False        Validation status should be false, but is not      
    Status Should Be    200

    Log    Última validación: ${last_validation}

Validate With Card, first validation of second user should pass
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json

   ${response}=  Run Keyword And Return Status    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/tickets/validation/193111742
    ...    data={"communityId":"67b879e99a2ba09f940ea7c5","key":"rut","value":"193111742","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}

    Status Should Be    200      msg=First validation of the second user should pass but is failing 

Validate With Card, second validation with second user should fail
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json

   ${response}=  Run Keyword And Expect Error     HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v2/pb/driver/tickets/validation/193111742    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/tickets/validation/193111742
    ...    data={"communityId":"67b879e99a2ba09f940ea7c5","key":"rut","value":"193111742","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}

    Status Should Be    403      msg=Second validation of the same user should fail but is not failing




Stop Departure With Post Leg
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
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":true,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
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

Delete Route
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