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

    ${end_date_pasado_manana}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pasado_manana}

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


Create new service in the selected route
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/routes/${assistantFlowRoute}?community=6654ae4eba54fe502d4e4187
    ...    data={"_id":"66954794b24db9885e5aed7e","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"enabled":true},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["66954794b24db9885e5aed7e"],"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":["66ccdf58193998eca49014c3"],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":true,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"name":"Flujos Auxiliar","shapeId":"6654d514713b9a5184cfe21e","description":"Crear Ruta 2 servicios Template","extraInfo":"","color":"652525","legOptions":[],"ownerIds":[{"_id":"66954794b24db9885e5aed83","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[{"_id":"66d613bf6e35d960a3f0a9e4","position":10,"distance":721.2678769755704,"lat":-34.405460000000005,"lon":-70.85045000000001,"loc":[-70.85045000000001,-34.405460000000005]},{"_id":"66d613bf6e35d960a3f0a9e5","position":20,"distance":1241.2723067370255,"lat":-34.402730000000005,"lon":-70.84620000000001,"loc":[-70.84620000000001,-34.402730000000005]},{"_id":"66d613bf6e35d960a3f0a9e6","position":30,"distance":1595.0719239538578,"lat":-34.40229,"lon":-70.84241,"loc":[-70.84241,-34.40229]},{"_id":"66d613bf6e35d960a3f0a9e7","position":40,"distance":2645.233134740408,"lat":-34.40482,"lon":-70.83145,"loc":[-70.83145,-34.40482]},{"_id":"66d613bf6e35d960a3f0a9e8","position":50,"distance":3375.973761804057,"lat":-34.40608,"lon":-70.82371,"loc":[-70.82371,-34.40608]},{"_id":"66d613bf6e35d960a3f0a9e9","position":60,"distance":4001.477015019511,"lat":-34.40887,"lon":-70.81783,"loc":[-70.81783,-34.40887]},{"_id":"66d613bf6e35d960a3f0a9ea","position":70,"distance":4306.587282954995,"lat":-34.409800000000004,"lon":-70.81472000000001,"loc":[-70.81472000000001,-34.409800000000004]},{"_id":"66d613bf6e35d960a3f0a9eb","position":80,"distance":4661.458987821193,"lat":-34.41008,"lon":-70.81132000000001,"loc":[-70.81132000000001,-34.41008]},{"_id":"66d613bf6e35d960a3f0a9ec","position":90,"distance":5358.443846332689,"lat":-34.40614,"lon":-70.80558,"loc":[-70.80558,-34.40614]},{"_id":"66d613bf6e35d960a3f0a9ed","position":100,"distance":5592.97633142821,"lat":-34.40478,"lon":-70.80369,"loc":[-70.80369,-34.40478]},{"_id":"66d613bf6e35d960a3f0a9ee","position":110,"distance":5831.604676259522,"lat":-34.40424,"lon":-70.80122,"loc":[-70.80122,-34.40424]},{"_id":"66d613bf6e35d960a3f0a9ef","position":120,"distance":6198.2717933998565,"lat":-34.40551,"lon":-70.79848000000001,"loc":[-70.79848000000001,-34.40551]},{"_id":"66d613bf6e35d960a3f0a9f0","position":130,"distance":6639.446024483833,"lat":-34.40744,"lon":-70.79534000000001,"loc":[-70.79534000000001,-34.40744]},{"_id":"66d613bf6e35d960a3f0a9f1","position":140,"distance":7804.1175750023685,"lat":-34.4014,"lon":-70.78497,"loc":[-70.78497,-34.4014]},{"_id":"66d613bf6e35d960a3f0a9f2","position":150,"distance":7962.092716278467,"lat":-34.4009,"lon":-70.78353,"loc":[-70.78353,-34.4009]},{"_id":"66d613bf6e35d960a3f0a9f3","position":160,"distance":8263.930344850285,"lat":-34.39882,"lon":-70.78226000000001,"loc":[-70.78226000000001,-34.39882]},{"_id":"66d613bf6e35d960a3f0a9f4","position":170,"distance":8751.198754212694,"lat":-34.395250000000004,"lon":-70.78141000000001,"loc":[-70.78141000000001,-34.395250000000004]}],"roundOrder":[],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":15,"distance":9,"distanceInMeters":8794,"originStop":"6654d4acba54fe502d4e6b6b","destinationStop":"6654d4c8713b9a5184cfe1df","customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-07-15T16:00:20.434Z","updatedAt":"2024-09-10T12:34:15.012Z","__v":22,"assistantAssignsSeat":true,"codeValidationOptions":{"failureMessage":"El código QR ingresado no es válido.","type":"qr"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roles":[]}},"notifySkippedStop":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roles":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roles":[]}},"useServiceReservations":true,"routeCost":0,"ticketCost":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

Create services 2
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
    Should Be Equal As Numbers    ${code}    202
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    15s

Get Service Id
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad2}&startDate=${start_date_today}&endDate=${end_date_pasttomorrow}
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
    
    Set Global Variable    ${service_id}

    Log    Last created service ID: ${service_id}


Get ServiceInfo
    [Documentation]    Consulta la información completa de un servicio específico utilizando su ID estático, para verificar su disponibilidad y estructura.

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/67fca0193e06bcb9cec71b21?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
Get ServiceInfo and Extract Dates
    [Documentation]    Consulta un servicio usando su ID dinámico, extrae la fecha del servicio (`serviceDate`) y la formatea para su posterior uso o validación.

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    # Extraer el serviceDate desde la raíz de la respuesta
    ${serviceDate}=    Get From Dictionary    ${response.json()}    serviceDate
    Set Global Variable    ${serviceDate}    ${serviceDate}

    # Convertir el formato de fecha y hora
    ${date}=    Convert Date    ${serviceDate}    result_format=%d/%m/%Y %H:%M:%S
    Set Global Variable    ${formattedServiceDate}    ${date}

    # Imprimir ambos resultados
    Log    Service Date (original): ${serviceDate}
    Log    Service Date (formatted): ${formattedServiceDate}

Bulk Assignment without reservations
    [Documentation]    Asigna múltiples recursos (vehículos y conductores) a un servicio sin reservas previas, y valida que cada recurso tenga definida su capacidad tanto en el vehículo como en la salida (departure).

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/assignServiceResources/bulk?community=${idComunidad2}
    ...    data=[{"serviceId":"${service_id}","serviceType":"route_service","resources":[{"vehicle":{"vehicleId":"67b5f76fb5c11f24f63fe29d"},"driver":{"driverId":"66d1dca1bc357f32ce162d1c","driverCode":"142142"},"passengers":[]},{"vehicle":{"vehicleId":"678683c6b2e380c81dee85f0"},"driver":{"driverId":"6654cec2ba54fe502d4e6a0a","driverCode":"159753"},"passengers":[]}],"resource":{},"excelServiceRoute":"Flujos Auxiliar","excelServiceDate":"${formattedServiceDate}","latestServiceVersion":{"_id":"${service_id}","capped":{"enabled":false},"restrictPassengers":{"validation":{"enabled":false,"parameters":[]},"reservation":{"enabled":false,"parameters":[]},"visibility":{"enabled":false,"parameters":[]},"enabled":false},"superCommunities":[{"_id":"653fd68233d83952fafcd4be","name":"SC - Automatización","avatar":"https://s3.amazonaws.com/allride.uploads/superCommunityAvatar_653fd601f90509541a748683_1699885179092.png"}],"communities":[{"_id":"6654ae4eba54fe502d4e4187","name":"Comunidad Automatización 2","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_6654ae4eba54fe502d4e4187_1717603083265.png"}],"active":true,"hasAssignedResources":false,"blocked":false,"disabled":false,"routeId":{"_id":"66954794b24db9885e5aed7e","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]},"enabled":true},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"schedule":[{"capped":{"enabled":false,"capacity":0},"restrictPassengers":{"validation":{"enabled":false,"conditional":"or","excludes":false,"parameters":[],"parameter":[]},"reservation":{"enabled":false,"conditional":"or","excludes":false,"parameters":[],"parameter":[]},"visibility":{"enabled":false,"conditional":"or","excludes":false,"parameters":[],"parameter":[]},"enabled":false},"reservations":{"enabled":false,"list":[]},"enabled":true,"_id":"68001a291bf786d395677702","day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"vehicleCategoryId":null,"serviceCost":0,"observations":"","stopSchedule":[],"defaultResources":[]}],"defaultServiceCost":null,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"limitUnit":"minutes","limitAmount":30,"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"restrictions":{"customParams":{"enabled":false,"params":[]},"_id":"68001a291bf786d395677729"},"stopOnReservation":false,"serviceCreationLimit":null},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":["66ccdf58193998eca49014c3"],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":true,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"name":"Flujos Auxiliar","shapeId":"6654d514713b9a5184cfe21e","description":"Crear Ruta 2 servicios Template","extraInfo":"","color":"652525","legOptions":[],"ownerIds":[{"_id":"66954794b24db9885e5aed83","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[{"_id":"67e40d46c0469716597d3495","position":10,"distance":721.2678769755704,"lat":-34.405460000000005,"lon":-70.85045000000001,"loc":[-70.85045000000001,-34.405460000000005]},{"_id":"67e40d46c0469716597d3496","position":20,"distance":1241.2723067370255,"lat":-34.402730000000005,"lon":-70.84620000000001,"loc":[-70.84620000000001,-34.402730000000005]},{"_id":"67e40d46c0469716597d3497","position":30,"distance":1595.0719239538578,"lat":-34.40229,"lon":-70.84241,"loc":[-70.84241,-34.40229]},{"_id":"67e40d46c0469716597d3498","position":40,"distance":2645.233134740408,"lat":-34.40482,"lon":-70.83145,"loc":[-70.83145,-34.40482]},{"_id":"67e40d46c0469716597d3499","position":50,"distance":3375.973761804057,"lat":-34.40608,"lon":-70.82371,"loc":[-70.82371,-34.40608]},{"_id":"67e40d46c0469716597d349a","position":60,"distance":4001.477015019511,"lat":-34.40887,"lon":-70.81783,"loc":[-70.81783,-34.40887]},{"_id":"67e40d46c0469716597d349b","position":70,"distance":4306.587282954995,"lat":-34.409800000000004,"lon":-70.81472000000001,"loc":[-70.81472000000001,-34.409800000000004]},{"_id":"67e40d46c0469716597d349c","position":80,"distance":4661.458987821193,"lat":-34.41008,"lon":-70.81132000000001,"loc":[-70.81132000000001,-34.41008]},{"_id":"67e40d46c0469716597d349d","position":90,"distance":5358.443846332689,"lat":-34.40614,"lon":-70.80558,"loc":[-70.80558,-34.40614]},{"_id":"67e40d46c0469716597d349e","position":100,"distance":5592.97633142821,"lat":-34.40478,"lon":-70.80369,"loc":[-70.80369,-34.40478]},{"_id":"67e40d46c0469716597d349f","position":110,"distance":5831.604676259522,"lat":-34.40424,"lon":-70.80122,"loc":[-70.80122,-34.40424]},{"_id":"67e40d46c0469716597d34a0","position":120,"distance":6198.2717933998565,"lat":-34.40551,"lon":-70.79848000000001,"loc":[-70.79848000000001,-34.40551]},{"_id":"67e40d46c0469716597d34a1","position":130,"distance":6639.446024483833,"lat":-34.40744,"lon":-70.79534000000001,"loc":[-70.79534000000001,-34.40744]},{"_id":"67e40d46c0469716597d34a2","position":140,"distance":7804.1175750023685,"lat":-34.4014,"lon":-70.78497,"loc":[-70.78497,-34.4014]},{"_id":"67e40d46c0469716597d34a3","position":150,"distance":7962.092716278467,"lat":-34.4009,"lon":-70.78353,"loc":[-70.78353,-34.4009]},{"_id":"67e40d46c0469716597d34a4","position":160,"distance":8263.930344850285,"lat":-34.39882,"lon":-70.78226000000001,"loc":[-70.78226000000001,-34.39882]},{"_id":"67e40d46c0469716597d34a5","position":170,"distance":8751.198754212694,"lat":-34.395250000000004,"lon":-70.78141000000001,"loc":[-70.78141000000001,-34.395250000000004]}],"roundOrder":[],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":15,"distance":9,"distanceInMeters":8791.128906727876,"originStop":{"_id":"6654d4acba54fe502d4e6b6b","oDDConfig":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe458","direction":"in","day":"mon","time":"14:00","description":""},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe459","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"config":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe456","direction":"in","day":"mon","time":"14:00","description":""},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe457","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"categories":["odd"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Hospital Rengo","lat":-34.4111,"lon":-70.8537,"loc":[-70.8537,-34.4111],"communityId":"6654ae4eba54fe502d4e4187","address":"Hospital Rengo","ownerIds":[{"_id":"6818eceadee018d6a8ed794d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"users":[],"placeId":"6654d4acba54fe502d4e6b6a","createdAt":"2024-05-27T18:45:00.094Z","updatedAt":"2025-05-06T20:20:00.012Z","__v":105,"superCommunityId":"653fd68233d83952fafcd4be"},"destinationStop":{"_id":"6654d4c8713b9a5184cfe1df","oDDConfig":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":["666728c8fea8eb2b26b20e82"],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ee","direction":"in","day":"thu","time":"18:00","description":"hola2"},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ef","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"config":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":["666728c8fea8eb2b26b20e82"],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ec","direction":"in","day":"thu","time":"18:00","description":"hola2"},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ed","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"categories":["odd"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Media Luna Cerrillos","lat":-34.396547,"lon":-70.781935,"loc":[-70.781935,-34.396547],"communityId":"6654ae4eba54fe502d4e4187","address":"Media luna cerrillos","ownerIds":[{"_id":"6818eceadee018d6a8ed794d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"users":[],"placeId":"6654d4c8713b9a5184cfe1de","createdAt":"2024-05-27T18:45:28.387Z","updatedAt":"2025-05-05T20:12:44.518Z","__v":16,"superCommunityId":"653fd68233d83952fafcd4be"},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-07-15T16:00:20.434Z","updatedAt":"2025-04-16T20:59:21.125Z","__v":310,"assistantAssignsSeat":true,"codeValidationOptions":{"failureMessage":"El código QR ingresado no es válido.","type":"qr"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[]}},"notifySkippedStop":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[]}},"useServiceReservations":true,"rating":{"enabled":false,"withValidation":false},"hasBarrier":false,"minimumTimeToForceDeparture":{"amount":5,"enabled":false,"unit":"minutes"},"DNIValidation":{"enabled":false,"options":["qr"]},"validation":{"external":[]}},"serviceDate":"${serviceDate}","observations":"","apportionByCategories":[],"stopSchedule":[],"resources":[],"reservations":[],"stateHistory":[],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","createdAt":"2025-04-14T05:41:45.904Z","updatedAt":"2025-04-14T05:41:45.904Z","__v":0,"unassignedReservations":0,"resourceDrivers":[],"resourceVehicles":[],"originStop":{"_id":"6654d4acba54fe502d4e6b6b","oDDConfig":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe458","direction":"in","day":"mon","time":"14:00","description":""},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe459","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"config":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe456","direction":"in","day":"mon","time":"14:00","description":""},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe457","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"categories":["odd"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Hospital Rengo","lat":-34.4111,"lon":-70.8537,"loc":[-70.8537,-34.4111],"communityId":"6654ae4eba54fe502d4e4187","address":"Hospital Rengo","ownerIds":[{"_id":"6818eceadee018d6a8ed794d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"users":[],"placeId":"6654d4acba54fe502d4e6b6a","createdAt":"2024-05-27T18:45:00.094Z","updatedAt":"2025-05-06T20:20:00.012Z","__v":105,"superCommunityId":"653fd68233d83952fafcd4be"},"destinationStop":{"_id":"6654d4c8713b9a5184cfe1df","oDDConfig":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":["666728c8fea8eb2b26b20e82"],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ee","direction":"in","day":"thu","time":"18:00","description":"hola2"},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ef","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"config":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":["666728c8fea8eb2b26b20e82"],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ec","direction":"in","day":"thu","time":"18:00","description":"hola2"},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ed","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"categories":["odd"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Media Luna Cerrillos","lat":-34.396547,"lon":-70.781935,"loc":[-70.781935,-34.396547],"communityId":"6654ae4eba54fe502d4e4187","address":"Media luna cerrillos","ownerIds":[{"_id":"6818eceadee018d6a8ed794d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"users":[],"placeId":"6654d4c8713b9a5184cfe1de","createdAt":"2024-05-27T18:45:28.387Z","updatedAt":"2025-05-05T20:12:44.518Z","__v":16,"superCommunityId":"653fd68233d83952fafcd4be"}}}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${code}=    Convert To String    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    # Asignar el JSON completo a una variable
    ${json}=    Set Variable    ${response.json()}

    # Acceso directo al campo capacity para el primer recurso (Vehicle y Departure)
    ${capacityVehicle_0}=    Set Variable    ${json}[correct][0][resources][0][vehicle]
    Should Contain    ${capacityVehicle_0}    capacity    Vehicle in resources[0] doesn't contain the 'capacity' property
    Log    Vehicle 0 Capacity: ${capacityVehicle_0}[capacity]

    ${capacityDeparture_0}=    Set Variable    ${json}[correct][0][resources][0][departure]
    Should Contain    ${capacityDeparture_0}    capacity    Departure in resources[0] doesn't contain the 'capacity' property
    Log    Departure 0 Capacity: ${capacityDeparture_0}[capacity]

    # Acceso directo al campo capacity para el segundo recurso (Vehicle y Departure)
    ${capacityVehicle_1}=    Set Variable    ${json}[correct][0][resources][1][vehicle]
    Should Contain    ${capacityVehicle_1}    capacity    Vehicle in resources[1] doesn't contain the 'capacity' property
    Log    Vehicle 1 Capacity: ${capacityVehicle_1}[capacity]

    ${capacityDeparture_1}=    Set Variable    ${json}[correct][0][resources][1][departure]
    Should Contain    ${capacityDeparture_1}    capacity    Departure in resources[1] doesn't contain the 'capacity' property
    Log    Departure 1 Capacity: ${capacityDeparture_1}[capacity]

    Sleep    2s



Get Service Id And Validate Pending States without reservations
    [Documentation]    Obtiene el último servicio creado con un routeId específico y valida que todos los resources[x].departure.state sean 'pending'

    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad2}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id}=    Set Variable    None

    ${sorted_services}=    Evaluate    sorted([s for s in ${responseJson} if s['routeId']['_id'] == '${scheduleId}'], key=lambda x: x['createdAt'])    json
    Run Keyword If    ${sorted_services} == []    Fatal Error    msg= No services were created with routeId._id = "${scheduleId}" — All createScheduled tests failing

    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}


    # Validar que todos los resources[x].departure.state == 'pending'
    FOR    ${resource}    IN    @{last_service['resources']}
        ${res_state}=    Set Variable    ${resource['departure']['state']}
        Should Be Equal As Strings    ${res_state}    pending    msg=Expected resource departure.state to be 'pending' but got '${res_state}'
    END


Remove Assignment 1
    [Documentation]    Elimina los recursos previamente asignados al servicio indicado. Luego valida que no queden recursos activos en el servicio.

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/clearServiceResources/${service_id}?community=6654ae4eba54fe502d4e4187&type=scheduled_departure
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200

    ${resources}=    Set Variable    ${response.json()}[resources]
    Should Be Empty    ${resources}
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s
Seat reservation
    skip
    [Documentation]    Realiza una reserva manual de asiento para un usuario específico en un servicio determinado. Luego valida que la reserva se haya realizado correctamente y que coincida el ID del usuario.

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/bookService/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    data={"userId":"65e5d25bb23585cc1d6720b4"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    
    Should Not Be Empty    ${response.json()}[reservations]    No reservation was found after making an admin reservation
    ${userIdReservation}=    Set Variable    ${response.json()}[reservations][0][userId]
    Should Be Equal As Strings    ${userIdReservation}    65e5d25bb23585cc1d6720b4
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s



Bulk Assignment with reservations
    [Documentation]    Asigna múltiples recursos a un servicio existente que ya tiene reservas, validando que cada recurso contenga correctamente los campos de capacidad en vehículo y salida.

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/assignServiceResources/bulk?community=${idComunidad2}
    ...    data=[{"serviceId":"${service_id}","serviceType":"route_service","resources":[{"vehicle":{"vehicleId":"67b5f76fb5c11f24f63fe29d"},"driver":{"driverId":"66d1dca1bc357f32ce162d1c","driverCode":"142142"},"passengers":[]},{"vehicle":{"vehicleId":"678683c6b2e380c81dee85f0"},"driver":{"driverId":"6654cec2ba54fe502d4e6a0a","driverCode":"159753"},"passengers":[]}],"resource":{},"excelServiceRoute":"Flujos Auxiliar","excelServiceDate":"${formattedServiceDate}","latestServiceVersion":{"_id":"${service_id}","capped":{"enabled":false},"restrictPassengers":{"validation":{"enabled":false,"parameters":[]},"reservation":{"enabled":false,"parameters":[]},"visibility":{"enabled":false,"parameters":[]},"enabled":false},"superCommunities":[{"_id":"653fd68233d83952fafcd4be","name":"SC - Automatización","avatar":"https://s3.amazonaws.com/allride.uploads/superCommunityAvatar_653fd601f90509541a748683_1699885179092.png"}],"communities":[{"_id":"6654ae4eba54fe502d4e4187","name":"Comunidad Automatización 2","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_6654ae4eba54fe502d4e4187_1717603083265.png"}],"active":true,"hasAssignedResources":false,"blocked":false,"disabled":false,"routeId":{"_id":"66954794b24db9885e5aed7e","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]},"enabled":true},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"schedule":[{"capped":{"enabled":false,"capacity":0},"restrictPassengers":{"validation":{"enabled":false,"conditional":"or","excludes":false,"parameters":[],"parameter":[]},"reservation":{"enabled":false,"conditional":"or","excludes":false,"parameters":[],"parameter":[]},"visibility":{"enabled":false,"conditional":"or","excludes":false,"parameters":[],"parameter":[]},"enabled":false},"reservations":{"enabled":false,"list":[]},"enabled":true,"_id":"68001a291bf786d395677702","day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"vehicleCategoryId":null,"serviceCost":0,"observations":"","stopSchedule":[],"defaultResources":[]}],"defaultServiceCost":null,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"limitUnit":"minutes","limitAmount":30,"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"restrictions":{"customParams":{"enabled":false,"params":[]},"_id":"68001a291bf786d395677729"},"stopOnReservation":false,"serviceCreationLimit":null},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":["66ccdf58193998eca49014c3"],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":true,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"name":"Flujos Auxiliar","shapeId":"6654d514713b9a5184cfe21e","description":"Crear Ruta 2 servicios Template","extraInfo":"","color":"652525","legOptions":[],"ownerIds":[{"_id":"66954794b24db9885e5aed83","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[{"_id":"67e40d46c0469716597d3495","position":10,"distance":721.2678769755704,"lat":-34.405460000000005,"lon":-70.85045000000001,"loc":[-70.85045000000001,-34.405460000000005]},{"_id":"67e40d46c0469716597d3496","position":20,"distance":1241.2723067370255,"lat":-34.402730000000005,"lon":-70.84620000000001,"loc":[-70.84620000000001,-34.402730000000005]},{"_id":"67e40d46c0469716597d3497","position":30,"distance":1595.0719239538578,"lat":-34.40229,"lon":-70.84241,"loc":[-70.84241,-34.40229]},{"_id":"67e40d46c0469716597d3498","position":40,"distance":2645.233134740408,"lat":-34.40482,"lon":-70.83145,"loc":[-70.83145,-34.40482]},{"_id":"67e40d46c0469716597d3499","position":50,"distance":3375.973761804057,"lat":-34.40608,"lon":-70.82371,"loc":[-70.82371,-34.40608]},{"_id":"67e40d46c0469716597d349a","position":60,"distance":4001.477015019511,"lat":-34.40887,"lon":-70.81783,"loc":[-70.81783,-34.40887]},{"_id":"67e40d46c0469716597d349b","position":70,"distance":4306.587282954995,"lat":-34.409800000000004,"lon":-70.81472000000001,"loc":[-70.81472000000001,-34.409800000000004]},{"_id":"67e40d46c0469716597d349c","position":80,"distance":4661.458987821193,"lat":-34.41008,"lon":-70.81132000000001,"loc":[-70.81132000000001,-34.41008]},{"_id":"67e40d46c0469716597d349d","position":90,"distance":5358.443846332689,"lat":-34.40614,"lon":-70.80558,"loc":[-70.80558,-34.40614]},{"_id":"67e40d46c0469716597d349e","position":100,"distance":5592.97633142821,"lat":-34.40478,"lon":-70.80369,"loc":[-70.80369,-34.40478]},{"_id":"67e40d46c0469716597d349f","position":110,"distance":5831.604676259522,"lat":-34.40424,"lon":-70.80122,"loc":[-70.80122,-34.40424]},{"_id":"67e40d46c0469716597d34a0","position":120,"distance":6198.2717933998565,"lat":-34.40551,"lon":-70.79848000000001,"loc":[-70.79848000000001,-34.40551]},{"_id":"67e40d46c0469716597d34a1","position":130,"distance":6639.446024483833,"lat":-34.40744,"lon":-70.79534000000001,"loc":[-70.79534000000001,-34.40744]},{"_id":"67e40d46c0469716597d34a2","position":140,"distance":7804.1175750023685,"lat":-34.4014,"lon":-70.78497,"loc":[-70.78497,-34.4014]},{"_id":"67e40d46c0469716597d34a3","position":150,"distance":7962.092716278467,"lat":-34.4009,"lon":-70.78353,"loc":[-70.78353,-34.4009]},{"_id":"67e40d46c0469716597d34a4","position":160,"distance":8263.930344850285,"lat":-34.39882,"lon":-70.78226000000001,"loc":[-70.78226000000001,-34.39882]},{"_id":"67e40d46c0469716597d34a5","position":170,"distance":8751.198754212694,"lat":-34.395250000000004,"lon":-70.78141000000001,"loc":[-70.78141000000001,-34.395250000000004]}],"roundOrder":[],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":15,"distance":9,"distanceInMeters":8791.128906727876,"originStop":{"_id":"6654d4acba54fe502d4e6b6b","oDDConfig":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe458","direction":"in","day":"mon","time":"14:00","description":""},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe459","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"config":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe456","direction":"in","day":"mon","time":"14:00","description":""},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe457","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"categories":["odd"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Hospital Rengo","lat":-34.4111,"lon":-70.8537,"loc":[-70.8537,-34.4111],"communityId":"6654ae4eba54fe502d4e4187","address":"Hospital Rengo","ownerIds":[{"_id":"6818eceadee018d6a8ed794d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"users":[],"placeId":"6654d4acba54fe502d4e6b6a","createdAt":"2024-05-27T18:45:00.094Z","updatedAt":"2025-05-06T20:20:00.012Z","__v":105,"superCommunityId":"653fd68233d83952fafcd4be"},"destinationStop":{"_id":"6654d4c8713b9a5184cfe1df","oDDConfig":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":["666728c8fea8eb2b26b20e82"],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ee","direction":"in","day":"thu","time":"18:00","description":"hola2"},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ef","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"config":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":["666728c8fea8eb2b26b20e82"],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ec","direction":"in","day":"thu","time":"18:00","description":"hola2"},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ed","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"categories":["odd"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Media Luna Cerrillos","lat":-34.396547,"lon":-70.781935,"loc":[-70.781935,-34.396547],"communityId":"6654ae4eba54fe502d4e4187","address":"Media luna cerrillos","ownerIds":[{"_id":"6818eceadee018d6a8ed794d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"users":[],"placeId":"6654d4c8713b9a5184cfe1de","createdAt":"2024-05-27T18:45:28.387Z","updatedAt":"2025-05-05T20:12:44.518Z","__v":16,"superCommunityId":"653fd68233d83952fafcd4be"},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-07-15T16:00:20.434Z","updatedAt":"2025-04-16T20:59:21.125Z","__v":310,"assistantAssignsSeat":true,"codeValidationOptions":{"failureMessage":"El código QR ingresado no es válido.","type":"qr"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[]}},"notifySkippedStop":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[]}},"useServiceReservations":true,"rating":{"enabled":false,"withValidation":false},"hasBarrier":false,"minimumTimeToForceDeparture":{"amount":5,"enabled":false,"unit":"minutes"},"DNIValidation":{"enabled":false,"options":["qr"]},"validation":{"external":[]}},"serviceDate":"${serviceDate}","observations":"","apportionByCategories":[],"stopSchedule":[],"resources":[],"reservations":[],"stateHistory":[],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","createdAt":"2025-04-14T05:41:45.904Z","updatedAt":"2025-04-14T05:41:45.904Z","__v":0,"unassignedReservations":0,"resourceDrivers":[],"resourceVehicles":[],"originStop":{"_id":"6654d4acba54fe502d4e6b6b","oDDConfig":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe458","direction":"in","day":"mon","time":"14:00","description":""},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe459","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"config":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe456","direction":"in","day":"mon","time":"14:00","description":""},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"681a6ef00d6afbaa02ebe457","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"categories":["odd"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Hospital Rengo","lat":-34.4111,"lon":-70.8537,"loc":[-70.8537,-34.4111],"communityId":"6654ae4eba54fe502d4e4187","address":"Hospital Rengo","ownerIds":[{"_id":"6818eceadee018d6a8ed794d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"users":[],"placeId":"6654d4acba54fe502d4e6b6a","createdAt":"2024-05-27T18:45:00.094Z","updatedAt":"2025-05-06T20:20:00.012Z","__v":105,"superCommunityId":"653fd68233d83952fafcd4be"},"destinationStop":{"_id":"6654d4c8713b9a5184cfe1df","oDDConfig":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":["666728c8fea8eb2b26b20e82"],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ee","direction":"in","day":"thu","time":"18:00","description":"hola2"},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ef","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"config":{"options":[{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":["666728c8fea8eb2b26b20e82"],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ec","direction":"in","day":"thu","time":"18:00","description":"hola2"},{"grouping":{"byKey":{"enabled":false,"key":""},"byList":{"list":[],"enabled":false}},"restricted":{"userLocation":{"enabled":false},"stops":{"stopIds":[],"enabled":false}},"_id":"68191bbcdee018d6a8eed7ed","direction":"out","day":"mon","time":"15:00","description":""}],"restricted":false,"stopIds":[]},"categories":["odd"],"communities":["6654ae4eba54fe502d4e4187","653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Media Luna Cerrillos","lat":-34.396547,"lon":-70.781935,"loc":[-70.781935,-34.396547],"communityId":"6654ae4eba54fe502d4e4187","address":"Media luna cerrillos","ownerIds":[{"_id":"6818eceadee018d6a8ed794d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"users":[],"placeId":"6654d4c8713b9a5184cfe1de","createdAt":"2024-05-27T18:45:28.387Z","updatedAt":"2025-05-05T20:12:44.518Z","__v":16,"superCommunityId":"653fd68233d83952fafcd4be"}}}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${code}=    Convert To String    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    # Asignar el JSON completo a una variable
    ${json}=    Set Variable    ${response.json()}

    # Acceso directo al campo capacity para el primer recurso (Vehicle y Departure)
    ${capacityVehicle_0}=    Set Variable    ${json}[correct][0][resources][0][vehicle]
    Should Contain    ${capacityVehicle_0}    capacity    Vehicle in resources[0] doesn't contain the 'capacity' property
    Log    Vehicle 0 Capacity: ${capacityVehicle_0}[capacity]

    ${capacityDeparture_0}=    Set Variable    ${json}[correct][0][resources][0][departure]
    Should Contain    ${capacityDeparture_0}    capacity    Departure in resources[0] doesn't contain the 'capacity' property
    Log    Departure 0 Capacity: ${capacityDeparture_0}[capacity]

    # Acceso directo al campo capacity para el segundo recurso (Vehicle y Departure)
    ${capacityVehicle_1}=    Set Variable    ${json}[correct][0][resources][1][vehicle]
    Should Contain    ${capacityVehicle_1}    capacity    Vehicle in resources[1] doesn't contain the 'capacity' property
    Log    Vehicle 1 Capacity: ${capacityVehicle_1}[capacity]

    ${capacityDeparture_1}=    Set Variable    ${json}[correct][0][resources][1][departure]
    Should Contain    ${capacityDeparture_1}    capacity    Departure in resources[1] doesn't contain the 'capacity' property
    Log    Departure 1 Capacity: ${capacityDeparture_1}[capacity]

    
Get Service Id And Validate Pending States with reservations
    [Documentation]    Obtiene el último servicio creado con un routeId específico y valida que todos los resources[x].departure.state sean 'pending'

    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad2}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id}=    Set Variable    None

    ${sorted_services}=    Evaluate    sorted([s for s in ${responseJson} if s['routeId']['_id'] == '${scheduleId}'], key=lambda x: x['createdAt'])    json
    Run Keyword If    ${sorted_services} == []    Fatal Error    msg= No services were created with routeId._id = "${scheduleId}" — All createScheduled tests failing

    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}

    Set Global Variable    ${service_id}
    Log    Last created service ID: ${service_id}

    # Validar que todos los resources[x].departure.state == 'pending'
    FOR    ${resource}    IN    @{last_service['resources']}
        ${res_state}=    Set Variable    ${resource['departure']['state']}
        Should Be Equal As Strings    ${res_state}    pending    msg=Expected resource departure.state to be 'pending' but got '${res_state}'
    END

Remove Assignment 2
    [Documentation]    Elimina los recursos asignados a un servicio de salida programada y verifica que la lista de recursos quede vacía.

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/clearServiceResources/${service_id}?community=6654ae4eba54fe502d4e4187&type=scheduled_departure
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200

    ${resources}=    Set Variable    ${response.json()}[resources]
    Should Be Empty    ${resources}
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s
Cancel reservation After Resources
    [Documentation]    Cancela una reserva existente de un pasajero en un servicio con recursos ya asignados, validando que la operación se realice correctamente.

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"_id":"65e5d25bb23585cc1d6720b4","communities":[{"confirmed":true,"_id":"6757581a0045ccd021173bea","communityId":"6654ae4eba54fe502d4e4187","isAdmin":false,"isStudent":false,"custom":[{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e7","key":"rut","value":"190778045"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e8","key":"address","value":"Brown Sur 48, 7760066 Ñuñoa, Región Metropolitana, Chile"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e9","key":"coordinates","value":"-33.45584580063265,-70.5919211272842"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1ea","key":"Color","value":"Color"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1eb","key":"Animal","value":"Animal2"}],"privateBus":{"odd":{"canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false,"providers":[]},"validation":{"external":{"required":true}},"enabled":true,"favoriteRoutes":[],"suggestedRoutes":["66954794b24db9885e5aed7e","66cc94821125fb1232f990a1","668456ea56270b3e81594b60","6798bd8be494cc12a9d737d4"],"_id":"6757581a0045ccd021173bf0","oDDServices":[{"canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false,"providers":["653fd68233d83952fafcd4be"],"_id":"67cb1f0956535c5b75cba9a8","name":"Taxis Nico"}]},"createdAt":"2024-12-09T20:50:34.207Z","updatedAt":"2025-03-07T16:30:01.698Z"}],"emails":[{"fromCommunity":false,"_id":"65e5d25bb23585cc1d6720b5","email":"florencia+paulina@allrideapp.com","validationToken":"cd2d45a0c96c46f51a837537c0779c4f0321d71b0b1f9462df6faa2607e2021a7ad6a8944a31624c71972ca0e1c33a2911d9971e77dbfe6fa0289061a97bcde7","active":true}],"name":"Paulina Pasajero","custom":[{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e7","key":"rut","value":"190778045"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e8","key":"address","value":"Brown Sur 48, 7760066 Ñuñoa, Región Metropolitana, Chile"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e9","key":"coordinates","value":"-33.45584580063265,-70.5919211272842"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1ea","key":"Color","value":"Color"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1eb","key":"Animal","value":"Animal2"}],"validated":false,"reservationId":"hasReservation","seat":"22"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/service/removeReservation/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    json=${parsed_json}
    ...    headers=${headers}