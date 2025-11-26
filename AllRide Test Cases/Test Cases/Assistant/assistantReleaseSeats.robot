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

1 hours local 
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}


Get All users
    Skip
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    url=api/v1/admin/users/listPagination?page=1&pageSize=20&community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.content}
    ${userQty}=    Set Variable    ${response.json()}[totalItems]
    Set Global Variable    ${userQty}

Create new service in the selected route
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/routes/${assistantFlowRoute}?community=6654ae4eba54fe502d4e4187
    ...    data={"_id":"66954794b24db9885e5aed7e","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"enabled":true},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"mon","time":"13:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":0},{"enabled":true,"day":"mon","time":"14:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":1},{"enabled":true,"day":"mon","time":"13:30","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":2},{"enabled":true,"day":"mon","time":"17:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":3},{"enabled":true,"day":"mon","time":"17:10","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":4},{"enabled":true,"day":"tue","time":"13:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":5},{"enabled":true,"day":"tue","time":"13:15","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":6},{"enabled":true,"day":"tue","time":"13:30","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":7},{"enabled":true,"day":"wed","time":"10:45","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":8},{"enabled":true,"day":"wed","time":"11:15","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":9},{"enabled":true,"day":"wed","time":"12:20","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":10},{"enabled":true,"day":"wed","time":"13:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":11},{"enabled":true,"day":"wed","time":"14:10","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":12},{"enabled":true,"day":"wed","time":"17:40","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":13},{"enabled":true,"day":"wed","time":"18:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":14},{"enabled":true,"day":"wed","time":"18:30","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":15},{"enabled":true,"day":"thu","time":"11:45","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":16},{"enabled":true,"day":"thu","time":"11:25","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":17},{"enabled":true,"day":"thu","time":"12:15","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":18},{"enabled":true,"day":"thu","time":"13:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":19},{"enabled":true,"day":"thu","time":"13:25","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":20},{"enabled":true,"day":"thu","time":"15:40","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":21},{"enabled":true,"day":"thu","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":22},{"enabled":true,"day":"thu","time":"17:30","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":23},{"enabled":true,"day":"thu","time":"18:30","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":24},{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":25},{"enabled":true,"day":"fri","time":"13:45","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":26},{"enabled":true,"day":"fri","time":"14:15","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":27},{"enabled":true,"day":"fri","time":"15:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":28},{"enabled":true,"day":"fri","time":"16:25","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":29},{"enabled":true,"day":"mon","time":"10:15","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":30},{"enabled":true,"day":"mon","time":"18:10","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":31},{"enabled":true,"day":"mon","time":"19:10","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":32},{"enabled":true,"day":"mon","time":"23:10","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":33},{"enabled":true,"day":"mon","time":"23:30","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":34},{"enabled":true,"day":"mon","time":"23:50","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":35},{"enabled":true,"day":"tue","time":"10:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":36},{"enabled":true,"day":"tue","time":"10:20","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":37},{"enabled":true,"day":"tue","time":"10:30","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":38}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["66954794b24db9885e5aed7e"],"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":["66ccdf58193998eca49014c3"],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":true,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"name":"Flujos Auxiliar","shapeId":"6654d514713b9a5184cfe21e","description":"Crear Ruta 2 servicios Template","extraInfo":"","color":"652525","legOptions":[],"ownerIds":[{"_id":"66954794b24db9885e5aed83","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[{"_id":"66d613bf6e35d960a3f0a9e4","position":10,"distance":721.2678769755704,"lat":-34.405460000000005,"lon":-70.85045000000001,"loc":[-70.85045000000001,-34.405460000000005]},{"_id":"66d613bf6e35d960a3f0a9e5","position":20,"distance":1241.2723067370255,"lat":-34.402730000000005,"lon":-70.84620000000001,"loc":[-70.84620000000001,-34.402730000000005]},{"_id":"66d613bf6e35d960a3f0a9e6","position":30,"distance":1595.0719239538578,"lat":-34.40229,"lon":-70.84241,"loc":[-70.84241,-34.40229]},{"_id":"66d613bf6e35d960a3f0a9e7","position":40,"distance":2645.233134740408,"lat":-34.40482,"lon":-70.83145,"loc":[-70.83145,-34.40482]},{"_id":"66d613bf6e35d960a3f0a9e8","position":50,"distance":3375.973761804057,"lat":-34.40608,"lon":-70.82371,"loc":[-70.82371,-34.40608]},{"_id":"66d613bf6e35d960a3f0a9e9","position":60,"distance":4001.477015019511,"lat":-34.40887,"lon":-70.81783,"loc":[-70.81783,-34.40887]},{"_id":"66d613bf6e35d960a3f0a9ea","position":70,"distance":4306.587282954995,"lat":-34.409800000000004,"lon":-70.81472000000001,"loc":[-70.81472000000001,-34.409800000000004]},{"_id":"66d613bf6e35d960a3f0a9eb","position":80,"distance":4661.458987821193,"lat":-34.41008,"lon":-70.81132000000001,"loc":[-70.81132000000001,-34.41008]},{"_id":"66d613bf6e35d960a3f0a9ec","position":90,"distance":5358.443846332689,"lat":-34.40614,"lon":-70.80558,"loc":[-70.80558,-34.40614]},{"_id":"66d613bf6e35d960a3f0a9ed","position":100,"distance":5592.97633142821,"lat":-34.40478,"lon":-70.80369,"loc":[-70.80369,-34.40478]},{"_id":"66d613bf6e35d960a3f0a9ee","position":110,"distance":5831.604676259522,"lat":-34.40424,"lon":-70.80122,"loc":[-70.80122,-34.40424]},{"_id":"66d613bf6e35d960a3f0a9ef","position":120,"distance":6198.2717933998565,"lat":-34.40551,"lon":-70.79848000000001,"loc":[-70.79848000000001,-34.40551]},{"_id":"66d613bf6e35d960a3f0a9f0","position":130,"distance":6639.446024483833,"lat":-34.40744,"lon":-70.79534000000001,"loc":[-70.79534000000001,-34.40744]},{"_id":"66d613bf6e35d960a3f0a9f1","position":140,"distance":7804.1175750023685,"lat":-34.4014,"lon":-70.78497,"loc":[-70.78497,-34.4014]},{"_id":"66d613bf6e35d960a3f0a9f2","position":150,"distance":7962.092716278467,"lat":-34.4009,"lon":-70.78353,"loc":[-70.78353,-34.4009]},{"_id":"66d613bf6e35d960a3f0a9f3","position":160,"distance":8263.930344850285,"lat":-34.39882,"lon":-70.78226000000001,"loc":[-70.78226000000001,-34.39882]},{"_id":"66d613bf6e35d960a3f0a9f4","position":170,"distance":8751.198754212694,"lat":-34.395250000000004,"lon":-70.78141000000001,"loc":[-70.78141000000001,-34.395250000000004]}],"roundOrder":[],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":15,"distance":9,"distanceInMeters":8794,"originStop":"6654d4acba54fe502d4e6b6b","destinationStop":"6654d4c8713b9a5184cfe1df","customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-07-15T16:00:20.434Z","updatedAt":"2024-09-10T12:34:15.012Z","__v":22,"assistantAssignsSeat":true,"codeValidationOptions":{"failureMessage":"El código QR ingresado no es válido.","type":"qr"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roles":[]}},"notifySkippedStop":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roles":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roles":[]}},"useServiceReservations":true,"routeCost":0,"ticketCost":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

    Sleep    5s

Create services
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/6654ae4eba54fe502d4e4187?community=6654ae4eba54fe502d4e4187
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s

Get Today Service Id
    [Tags]    test:retry(1)
    
    # Define la URL del recurso que requiere autenticación para la semana 1
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad2}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

# Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${filtered_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '66954794b24db9885e5aed7e']    json

# Ordenamos los servicios filtrados por la fecha de creación en orden descendente
    ${sorted_services}=    Evaluate    sorted(${filtered_services}, key=lambda service: service['createdAt'], reverse=True)    json

# Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = '66954794b24db9885e5aed7e'. Stopping test"

    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id}=    Set Variable    ${service['_id']}

    Set Global Variable    ${service_id}


Make Bulk Reservation(3 should pass, one fail)
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/bookService/bulk/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    data={"users":[{"userId":"666078059a5ece0ee6e95904"},{"userId":"66f5becbf3a0b05c0092e66f"},{"userId":"66e30a06e2b22c7d017bb492"},{"userId":"66d8cf4f4a7101503b01f84a"}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${correctReservation1}=      Set Variable    ${response.json()}[correct][0][userId]
    ${correctReservation2}=      Set Variable    ${response.json()}[correct][1][userId]
    ${correctReservation3}=      Set Variable    ${response.json()}[correct][2][userId]
    ${withErrorsUser}=      Set Variable    ${response.json()}[withErrors][0][user]
    ${withErrorsMessage}=      Set Variable    ${response.json()}[withErrors][0][message]
    ${withErrorsCode}=      Set Variable    ${response.json()}[withErrors][0][code]
    Should Be Equal As Strings    ${correctReservation1}    666078059a5ece0ee6e95904            The user with certification webcontrol could not reserve, failing
    Should Be Equal As Strings    ${correctReservation2}    66e30a06e2b22c7d017bb492            The user with certification webcontrol could not reserve, failing
    Should Be Equal As Strings    ${correctReservation3}    66d8cf4f4a7101503b01f84a            The user with certification webcontrol could not reserve, failing
    
    #----WITH ERRORS--#
    Should Be Equal As Strings    ${withErrorsUser}    66f5becbf3a0b05c0092e66f
    Should Be Equal As Strings    ${withErrorsMessage}    Unauthorized to book.
    Should Be Equal As Strings    ${withErrorsCode}    webcontrol_failed
    Sleep    5s
    #---------CASO1 Tres usuarios con reservas, con webcontrol sin liberación de asientos, 1 usuario no acreditado----------------------------#
    # Crear reserva masiva con 4 usuarios, 3 deberían pasar, uno debería fallar por webcontrol
    # Asignar recursos para crear dos salidas
    # Verificar que cada salida tenga la misma cantidad de reservas
    # Verificar que cada salida tenga el mismo serviceId
    # Aceptar servicio con ambos conductores
    # Iniciar sesión cómo auxiliar
    # Obtener salidas andando, deberían ser dos, estas salidas deberían tener la misma cantidad de reservas
    # Validar usuarios con QR, solamente aquellos que tienen reserva y webcontrol deberían pasar
    # Usuario que no cuenta con webcontrol no debería funcionar la validación
    # Buses cuentan con solo dos asientos, por lo que solo debería dejar validarme dos usuarios en una salida, y uno en la siguiente.
    # Vincular validaciones con salida correspondiente
    # Revisar en Coordinacion Interna que cada vinculación de validación esté en su salida correspondiente
    # Finalizar viaje con ambos conductores

#---------CASO2,  Dos usuarios con reservas, con webcontrol sin liberación de asientos, 1 usuario acreditado sin reserva, 1 usuario no acreditado ----------------------------#
    # Crear reserva masiva con tres usuarios, 2 deberían pasar, uno debería fallar por webcontrol
    # Asignar recursos para crear dos salidas
    # Verificar que cada salida tenga la misma cantidad de reservas
    # Verificar que cada salida tenga el mismo serviceId
    # Aceptar servicio con ambos conductores
    # Iniciar sesión cómo auxiliar
    # Obtener salidas andando, deberían ser dos, estas salidas deberían tener la misma cantidad de reservas
    # Validar usuarios con QR, solamente aquellos que tienen webcontrol deberían pasar (3 usuarios, 2 que tienen reserva, 1 que no)
    # Usuario que no cuenta con webcontrol no debería funcionar la validación
    # Buses cuentan con solo dos asientos, por lo que solo debería dejar validarme dos usuarios en una salida, y uno en la siguiente. Hacer el intento de validarme en una salida donde ya hay reservas, no debería dejarme continuar, pero si en la salida siguiente(Luego de validados los dos usuarios)
    # Vincular validaciones con salida correspondiente
    # Revisar en Coordinacion Interna que cada vinculación de validación esté en su salida correspondiente
    # Finalizar viaje con ambos conductores

    #---------CASO3,  Dos usuarios con reservas, con webcontrol con liberación de asientos, 1 usuario acreditado sin reserva, 1 usuario no acreditado ----------------------------#
    # Crear reserva masiva con tres usuarios, 2 deberían pasar, uno debería fallar por webcontrol
    # Asignar recursos para crear dos salidas
    # Verificar que cada salida tenga la misma cantidad de reservas
    # Verificar que cada salida tenga el mismo serviceId
    # Aceptar servicio con ambos conductores
    # Iniciar sesión cómo auxiliar
    # Obtener salidas andando, deberían ser dos, estas salidas deberían tener la misma cantidad de reservas
    # Liberar reservas, verificar que se hayan liberado del servicio completo, no solo de la salida
    # Validar usuarios con QR, solamente aquellos que tienen webcontrol, por lo que el usuario sin reserva y acreditado, debería poder validarse en cualquiera de las dos salidas, (validar, eliminar validación, y validar en otra salida para probar)
    # Usuario que no cuenta con webcontrol no debería funcionar la validación
    # Buses cuentan con solo dos asientos, por lo que solo debería dejar validarme dos usuarios en una salida, y uno en la siguiente. Hacer el intento de validarme en una salida donde ya hay asientos utilizados, no debería dejarme continuar, pero si en la salida siguiente(Luego de validados los dos usuarios)
    # Vincular validaciones con salida correspondiente
    # Revisar en Coordinacion Interna que cada vinculación de validación esté en su salida correspondiente
    # Finalizar viaje con ambos conductores
Make Bulk Reservation(all should failed, already booked)
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/bookService/bulk/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    data={"users":[{"userId":"666078059a5ece0ee6e95904"},{"userId":"6667489cb5433b5dc2fa94e9"},{"userId":"66e30a06e2b22c7d017bb492"},{"userId":"66d8cf4f4a7101503b01f84a"}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${correctReservations} =     Set Variable    ${response.json()}[correct]
    Should Be Empty    ${correctReservations}
    ${failedReservations} =    Set Variable    ${response.json()}[withErrors]
    Length Should Be    ${failedReservations}    4

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad2}&driverId=${driverId3}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver1}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver1}

    Log    ${tokenDriver1}
    Log    ${response.content}
Get Driver Token 2
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad2}&driverId=${driverId2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver2}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver2}

    Log    ${tokenDriver2}
    Log    ${response.content}

Resource Assignment(Driver and Vehicle Without reservations assignment)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/assignServiceResources/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId3}"},"drivers":[],"vehicle":{"vehicleId":"666941a7b8d6ea30f9281110","capacity":2},"passengers":[],"departure":null},{"multipleDrivers":false,"driver":{"driverId":"${driverId2}"},"drivers":[],"vehicle":{"vehicleId":"66d86aafd60f7ada27c56e23","capacity":2},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    
    ${routeId2} =     Set Variable    ${response.json()}[routeId]
    Should Be Equal As Strings    ${routeId2}    66954794b24db9885e5aed7e        Departures created dont have the selected route "66954794b24db9885e5aed7e" ,failing
    
    ${resources}=     Set Variable    ${response.json()}[resources]
    Length Should Be    ${resources}    2

    ${departureId_1}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    ${departureId_2}=    Set Variable    ${response.json()}[resources][1][departure][departureId]

    ${reservations}=    Set Variable    ${response.json()}[reservations]
    Length Should Be    ${reservations}    3            

    Set Global Variable    ${departureId_1}
    Set Global Variable    ${departureId_2}

Get departureId
    Skip
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



Get Assistant Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/assistants/list?community=${idComunidad2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()[0]['accessToken']}
    ${tokenAssistant}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenAssistant}

    Log    ${tokenAssistant}
    Log    ${response.content}

Get Assistant Info(Self)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/provider/me

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

Login User With Email(Obtain Token)
    Skip
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+userpelambres@allrideapp.com","password":"Lolowerty21@"}
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


Driver Accept Service 1
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/acceptOrReject/${departureId_1}
    ...    data={"state":"accepted"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Driver Accept Service 2
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver2}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/acceptOrReject/${departureId_2}
    ...    data={"state":"accepted"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}


Start Departure Leg 1
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver1}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/${departureId_1}
    ...    data={"departureId":"${departureId_1}","communityId":"${idComunidad2}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":2,"busCode":"1111","driverCode":"159753","vehicleId":"666941a7b8d6ea30f9281110","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken1}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken1}
    Log    ${code}
    Set Global Variable    ${departureToken1}
Start Departure Leg 2
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver2}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/${departureId_2}
    ...    data={"departureId":"${departureId_2}","communityId":"${idComunidad2}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":3,"busCode":"","driverCode":"159159","vehicleId":"66d86aafd60f7ada27c56e23","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken2}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken2}
    Log    ${code}
    Set Global Variable    ${departureToken2}

Get Active Departures
    Skip
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/actives

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    ${activeDepartureId}=   Set Variable    ${response.json()}[0][_id]
    Should Be Equal As Strings    ${departureId_1}    ${activeDepartureId}
    ${activeDepartureId}=   Set Variable    ${response.json()}[1][_id]
    Should Be Equal As Strings    ${departureId_2}    ${activeDepartureId}

Get Active Departure 1 Details
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/${departureId_1}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
Get Active Departure 2 Details
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/${departureId_2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

Release seats without validations
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAssistant}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departure/releaseReservations/${departureId_1}
    ...    data={"userList": ["666078059a5ece0ee6e95904", "66e30a06e2b22c7d017bb492", "66d8cf4f4a7101503b01f84a"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

Get Active Departure 1 Details after realase
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/${departureId_1}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=     Set Variable    ${response.json()}[reservations]
    ${reservationsServices}=     Set Variable    ${response.json()}[service][reservations]

    Should Be Empty    ${reservations}            Reservations should be empty but is not, release seats not working
    Should Be Empty    ${reservationsServices}    Reservations Services should be empty but is not, release seats not working
Get Active Departure 2 Details after release
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/${departureId_2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=     Set Variable    ${response.json()}[reservations]
    ${reservationsServices}=     Set Variable    ${response.json()}[service][reservations]

    Should Be Empty    ${reservations}            Reservations should be empty but is not, release seats not working
    Should Be Empty    ${reservationsServices}    Reservations Services should be empty but is not, release seats not working


#-------------------Make reservation-----------------------------------#

Get User QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["666078059a5ece0ee6e95904"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}

Get User QR(User Barbara)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["66d8cf4f4a7101503b01f84a"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUserBarbara}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUserBarbara}
    Log    ${qrCodeUserBarbara}
    Log    ${code}

Get User QR(User Barbara)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["66e30a06e2b22c7d017bb492"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUserMorita}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUserMorita}
    Log    ${qrCodeUserMorita}
    Log    ${code}

Validate With QR Assistant(Should be able to validate as user without reservation)


    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeNico}", "seatNumber": "1","validationLat":-34.41084810977676,"validationLon":-70.85297670602283}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    ${validationIdNico}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${validationIdNico}

Validate With QR Barbara(Pending Assigned2 User Dont have tickets)

    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=      POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeUserBarbara}","seatNumber": "2", "validationLat":-34.41084810977676,"validationLon":-70.85297670602283}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)


Validate With QR Morita(SHould not be able to validate, all seats taken, seat1)

    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Run Keyword And Expect Error  HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeUserMorita}","seatNumber": "1", "validationLat":-34.41084810977676,"validationLon":-70.85297670602283}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Validate With QR Morita(SHould not be able to validate, all seats taken, seat2)

    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=   Run Keyword And Expect Error  HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate   POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeUserMorita}","seatNumber": "2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Validate With QR Morita(SHould be able to validate, departure2)

    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken2}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=      POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeUserMorita}" , "seatNumber": "2","validationLat":-34.41084810977676,"validationLon":-70.85297670602283}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Status Should Be    200        msg= Failing, passenger couldn't validate in service with available seats
    ${validationMorita}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${validationMorita}
Validate With QR user Not in ALLRIDE But has webcontrol(SHould be able to validate, departure2)
    Skip
    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${departureToken2}    Content-Type=application/json

    ${response}=      POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"https://portal.sidiv.registrocivil.cl/docstatus?RUN=10827067-5&type=CEDULA&serial=517834468&mrz=517834468899012812901282","seatNumber": "1", "validationLat":-34.41084810977676,"validationLon":-70.85297670602283}
    ...    headers=${headers}

    Status Should Be    200        msg= Failing, passenger couldn't validate in service with available seats
    ${validationEXT}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${validationEXT}
    Sleep    3s

Get All users After Validation
    Skip
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    url=api/v1/admin/users/listPagination?page=1&pageSize=20&community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.content}

    Convert To Integer    ${userQty}
    ${userQtyAfterValidation}=    Evaluate    $${userQty}+1

    Should Be True    ${userQtyAfterValidation}


Link Validation to active Departure 1 With Custom
    #SE HACE CON ASSISTANt TOKEN -----------Duplicar validacion con el mismo usuasrio para luego vincular con patente de vehiculo
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAssistant}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/assistant/departures/link/${departureId_1}
    ...    data={"plate":"MORI2","validations":["${validationIdNico}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}



Delete Recent Validation
    Skip
    #SE HACE CON ASSISTANt TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAssistant}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/assistant/departures/validation/${validationMorita}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}



Get Active Departure 1 Details after validations
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/${departureId_1}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=     Set Variable    ${response.json()}[reservations]
    ${reservationsServices}=     Set Variable    ${response.json()}[service][reservations]

    Should Be Empty    ${reservations}            Reservations should be empty but is not, release seats not working
    Should Be Empty    ${reservationsServices}    Reservations Services should be empty but is not, release seats not working

Get Active Departure 2 Details after validations
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/${departureId_2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=     Set Variable    ${response.json()}[reservations]
    ${reservationsServices}=     Set Variable    ${response.json()}[service][reservations]

    Should Be Empty    ${reservations}            Reservations should be empty but is not, release seats not working
    Should Be Empty    ${reservationsServices}    Reservations Services should be empty but is not, release seats not working

Stop Post Leg Departure 1

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken1}
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
Stop Post Leg Departure 2
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken2}
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
