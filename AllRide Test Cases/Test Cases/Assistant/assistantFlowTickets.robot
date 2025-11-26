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
        
Generar Fecha y Hora para JSON
    ${fecha_actual_json}=    Get Current Date    result_format=%b %d, %Y %H:%M:%S
    Log    ${fecha_actual_json}
    Set Global Variable    ${fecha_actual_json}

Generate random UUID (_id validations qrValidations)
    ${uuid_qr}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr}
    Set Global Variable    ${uuid_qr}

1 hours local 
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}



Get Total Tickets
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
# Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Obtiene el tiempo de inicio
    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    
    # Obtiene el tiempo de finalización
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Calcula el tiempo transcurrido (elapsed)
    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}

    # Almacena la respuesta JSON en una variable para poder manipularla
    ${totalTickets}=    Set Variable    ${response.json()}
    Set Global Variable    ${totalTickets}

    Log    La cantidad total de tickets es ${totalTickets}


Assing Tickets(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud POST en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad2}&userId=666078059a5ece0ee6e95904&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    
    # Verifica el código de estado esperado
    Status Should Be    200

    # Obtén el cuerpo de la respuesta como texto
    ${response_body}=    Convert To String    ${response.content}

    # Verifica que el cuerpo no esté vacío
    Should Not Be Empty    ${response_body}       No tickets were assigned, empty body Failing

    # Valida que la respuesta sea un número




Get Assigned Tickets (Nico)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=${idComunidad2}
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
        IF    "${user}[id]" == "666078059a5ece0ee6e95904"    BREAK
        Set Global Variable    ${assignedQtyNico}
    END

    Should Be True    ${assignedQtyNico}==${assignQty}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyNico}


Create new service in the selected route
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/routes/66f310608e6c377a3f43968e?community=6654ae4eba54fe502d4e4187
    ...    data={"_id":"66f310608e6c377a3f43968e","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["66f310608e6c377a3f43968e"],"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":["66ccdf58193998eca49014c3"],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":true,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":true,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"name":"Flujo Tickets Auxiliar","shapeId":"6654d514713b9a5184cfe21e","description":"Flujo Tickets Auxiliar","extraInfo":"","color":"652525","legOptions":[],"ownerIds":[{"_id":"66954794b24db9885e5aed83","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[{"_id":"66faba3063836b24c20ecabb","position":1,"distance":290.2660419534011,"lat":-34.408530000000006,"lon":-70.85308,"loc":[-70.85308,-34.408530000000006]},{"_id":"66faba3063836b24c20ecabc","position":2,"distance":488.1040403831149,"lat":-34.40699,"lon":-70.852,"loc":[-70.852,-34.40699]},{"_id":"66faba3063836b24c20ecabd","position":3,"distance":781.9113593811135,"lat":-34.40496,"lon":-70.84995,"loc":[-70.84995,-34.40496]},{"_id":"66faba3063836b24c20ecabe","position":4,"distance":1104.6940260856932,"lat":-34.40296,"lon":-70.84740000000001,"loc":[-70.84740000000001,-34.40296]},{"_id":"66faba3063836b24c20ecabf","position":5,"distance":1122.8597601245997,"lat":-34.402800000000006,"lon":-70.84736000000001,"loc":[-70.84736000000001,-34.402800000000006]},{"_id":"66faba3063836b24c20ecac0","position":6,"distance":1292.2891375798047,"lat":-34.40267,"lon":-70.84552000000001,"loc":[-70.84552000000001,-34.40267]},{"_id":"66faba3063836b24c20ecac1","position":7,"distance":1459.1985795046444,"lat":-34.40229,"lon":-70.84376,"loc":[-70.84376,-34.40229]},{"_id":"66faba3063836b24c20ecac2","position":8,"distance":1583.0555768914546,"lat":-34.40229,"lon":-70.84241,"loc":[-70.84241,-34.40229]},{"_id":"66faba3063836b24c20ecac3","position":9,"distance":2238.7794491503846,"lat":-34.40344,"lon":-70.8354,"loc":[-70.8354,-34.40344]},{"_id":"66faba3063836b24c20ecac4","position":10,"distance":2367.730135581892,"lat":-34.40379,"lon":-70.83406000000001,"loc":[-70.83406000000001,-34.40379]},{"_id":"66faba3063836b24c20ecac5","position":11,"distance":2813.2702156190876,"lat":-34.40545,"lon":-70.82964000000001,"loc":[-70.82964000000001,-34.40545]},{"_id":"66faba3063836b24c20ecac6","position":12,"distance":2907.937653439918,"lat":-34.405660000000005,"lon":-70.82864000000001,"loc":[-70.82864000000001,-34.405660000000005]},{"_id":"66faba3063836b24c20ecac7","position":13,"distance":3103.8542952895764,"lat":-34.40598,"lon":-70.82654000000001,"loc":[-70.82654000000001,-34.40598]},{"_id":"66faba3063836b24c20ecac8","position":14,"distance":3399.7333701489256,"lat":-34.406130000000005,"lon":-70.82332000000001,"loc":[-70.82332000000001,-34.406130000000005]},{"_id":"66faba3063836b24c20ecac9","position":15,"distance":3777.3304160935245,"lat":-34.40782,"lon":-70.81975,"loc":[-70.81975,-34.40782]},{"_id":"66faba3063836b24c20ecaca","position":16,"distance":4027.852872329667,"lat":-34.409060000000004,"lon":-70.81747,"loc":[-70.81747,-34.409060000000004]},{"_id":"66faba3063836b24c20ecacb","position":17,"distance":4262.946941118368,"lat":-34.40968,"lon":-70.81502,"loc":[-70.81502,-34.40968]},{"_id":"66faba3063836b24c20ecacc","position":18,"distance":4331.54548643874,"lat":-34.40997,"lon":-70.81436000000001,"loc":[-70.81436000000001,-34.40997]},{"_id":"66faba3063836b24c20ecacd","position":19,"distance":4470.011462521272,"lat":-34.41068,"lon":-70.81312000000001,"loc":[-70.81312000000001,-34.41068]},{"_id":"66faba3063836b24c20ecace","position":20,"distance":4569.730370049159,"lat":-34.41037,"lon":-70.8121,"loc":[-70.8121,-34.41037]},{"_id":"66faba3063836b24c20ecacf","position":21,"distance":4885.998380967774,"lat":-34.40916,"lon":-70.80898,"loc":[-70.80898,-34.40916]},{"_id":"66faba3063836b24c20ecad0","position":22,"distance":5117.696468148955,"lat":-34.40769,"lon":-70.80719,"loc":[-70.80719,-34.40769]},{"_id":"66faba3063836b24c20ecad1","position":23,"distance":5264.734491572538,"lat":-34.406670000000005,"lon":-70.80617000000001,"loc":[-70.80617000000001,-34.406670000000005]},{"_id":"66faba3063836b24c20ecad2","position":24,"distance":5425.207136314769,"lat":-34.405620000000006,"lon":-70.80497000000001,"loc":[-70.80497000000001,-34.405620000000006]},{"_id":"66faba3063836b24c20ecad3","position":25,"distance":5509.906626643151,"lat":-34.40527,"lon":-70.80415,"loc":[-70.80415,-34.40527]},{"_id":"66faba3063836b24c20ecad4","position":26,"distance":5600.221898860165,"lat":-34.40466,"lon":-70.8035,"loc":[-70.8035,-34.40466]},{"_id":"66faba3063836b24c20ecad5","position":27,"distance":5755.68153334114,"lat":-34.404250000000005,"lon":-70.80188000000001,"loc":[-70.80188000000001,-34.404250000000005]},{"_id":"66faba3063836b24c20ecad6","position":28,"distance":5915.319583664183,"lat":-34.40424,"lon":-70.80014,"loc":[-70.80014,-34.40424]},{"_id":"66faba3063836b24c20ecad7","position":29,"distance":6007.047842778099,"lat":-34.40404,"lon":-70.79917,"loc":[-70.79917,-34.40404]},{"_id":"66faba3063836b24c20ecad8","position":30,"distance":6182.3341417231395,"lat":-34.40551,"lon":-70.79848000000001,"loc":[-70.79848000000001,-34.40551]},{"_id":"66faba3063836b24c20ecad9","position":31,"distance":6367.330377715924,"lat":-34.40664,"lon":-70.79700000000001,"loc":[-70.79700000000001,-34.40664]},{"_id":"66faba3063836b24c20ecada","position":32,"distance":6527.46821540092,"lat":-34.407920000000004,"lon":-70.7962,"loc":[-70.7962,-34.407920000000004]},{"_id":"66faba3063836b24c20ecadb","position":33,"distance":7287.353626388585,"lat":-34.404030000000006,"lon":-70.78939000000001,"loc":[-70.78939000000001,-34.404030000000006]},{"_id":"66faba3063836b24c20ecadc","position":34,"distance":7845.43322025191,"lat":-34.40109,"lon":-70.78446000000001,"loc":[-70.78446000000001,-34.40109]},{"_id":"66faba3063836b24c20ecadd","position":35,"distance":7882.902565797689,"lat":-34.40119,"lon":-70.78407,"loc":[-70.78407,-34.40119]},{"_id":"66faba3063836b24c20ecade","position":36,"distance":8083.244366156947,"lat":-34.40008,"lon":-70.78235000000001,"loc":[-70.78235000000001,-34.40008]},{"_id":"66faba3063836b24c20ecadf","position":37,"distance":8151.255642391474,"lat":-34.399550000000005,"lon":-70.78272000000001,"loc":[-70.78272000000001,-34.399550000000005]},{"_id":"66faba3063836b24c20ecae0","position":38,"distance":8242.744317444498,"lat":-34.39882,"lon":-70.78226000000001,"loc":[-70.78226000000001,-34.39882]},{"_id":"66faba3063836b24c20ecae1","position":39,"distance":8448.184416414158,"lat":-34.397040000000004,"lon":-70.78166,"loc":[-70.78166,-34.397040000000004]},{"_id":"66faba3063836b24c20ecae2","position":40,"distance":8467.636269238845,"lat":-34.39687,"lon":-70.78171,"loc":[-70.78171,-34.39687]},{"_id":"66faba3063836b24c20ecae3","position":41,"distance":8609.810198718747,"lat":-34.39578,"lon":-70.78252,"loc":[-70.78252,-34.39578]},{"_id":"66faba3063836b24c20ecae4","position":42,"distance":8702.762775926865,"lat":-34.395430000000005,"lon":-70.78160000000001,"loc":[-70.78160000000001,-34.395430000000005]},{"_id":"66faba3063836b24c20ecae5","position":43,"distance":8729.30555711264,"lat":-34.395250000000004,"lon":-70.78141000000001,"loc":[-70.78141000000001,-34.395250000000004]},{"_id":"66faba3063836b24c20ecae6","position":44,"distance":8771.583165938728,"lat":-34.3949,"lon":-70.78123000000001,"loc":[-70.78123000000001,-34.3949]}],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","routeCost":10,"ticketCost":100,"timeOnRoute":14,"distance":9,"distanceInMeters":8784,"createdAt":"2024-09-24T19:17:52.759Z","updatedAt":"2025-01-03T20:05:48.776Z","__v":221,"rating":{"enabled":false,"withValidation":false},"hasBarrier":false,"minimumTimeToForceDeparture":{"amount":5,"enabled":false,"unit":"minutes"},"DNIValidation":{"enabled":false},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"roundOrder":[],"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"useServiceReservations":true}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    Dictionary Should Contain Key    ${response.json()}    _id        No _id Found when service is created. Failing
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
    ${filtered_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '66f310608e6c377a3f43968e']    json

# Ordenamos los servicios filtrados por la fecha de creación en orden descendente
    ${sorted_services}=    Evaluate    sorted(${filtered_services}, key=lambda service: service['createdAt'], reverse=True)    json

# Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services was created in with routeId._id = '66f310608e6c377a3f43968e'. Stopping test"

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

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad2}&driverId=6654cec2ba54fe502d4e6a0a

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    
    Dictionary Should Contain Key    ${response.json()}    accessToken    No accessToken was found in Driver, Failing
    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver1}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver1}

    Log    ${tokenDriver1}
    Log    ${response.content}
Get Driver Token 2
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad2}&driverId=668309b8bb41bfd79a461dc3

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    Dictionary Should Contain Key    ${response.json()}    accessToken    No accessToken was found in Driver, Failing
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
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"6654cec2ba54fe502d4e6a0a"},"drivers":[],"vehicle":{"vehicleId":"666941a7b8d6ea30f9281110","capacity":2},"passengers":[],"departure":null},{"multipleDrivers":false,"driver":{"driverId":"668309b8bb41bfd79a461dc3"},"drivers":[],"vehicle":{"vehicleId":"66d86aafd60f7ada27c56e23","capacity":2},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    
    Dictionary Should Contain Key    ${response.json()}    resources      No resources found in departures, Failing

    ${routeId2} =     Set Variable    ${response.json()}[routeId]
    Should Be Equal As Strings    ${routeId2}    66f310608e6c377a3f43968e        Departures created dont have the selected route, failing
    
    ${resources}=     Set Variable    ${response.json()}[resources]
    Length Should Be    ${resources}    2            There should be 2 departures, but only found ${resources}

    ${departureId_1}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    ${departureId_2}=    Set Variable    ${response.json()}[resources][1][departure][departureId]

    ${reservations}=    Set Variable    ${response.json()}[reservations]
    Length Should Be    ${reservations}    3        There should be 3 reservations but only found ${reservations}

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

    List Should Contain Value    ${response.json()}[0]        accessToken    No accessToken was found in Assistant, Failing
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
    Should Not Be Empty    ${response.json()}

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
    Dictionary Should Contain Key    ${response.json()}    stateHistory        No State History Found in depararture, failing

    ${stateHistory}=    Set Variable    ${response.json()}[stateHistory]
    ${stateHistory3}=    Set Variable    ${stateHistory}[3][state]
    Should Be Equal As Strings    ${stateHistory3}    accepted            State should be accepted but is ${stateHistory3}

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

    Dictionary Should Contain Key    ${response.json()}    stateHistory    No State History Found in depararture, failing

    ${stateHistory}=    Set Variable    ${response.json()}[stateHistory]
    ${stateHistory3}=    Set Variable    ${stateHistory}[3][state]
    Should Be Equal As Strings    ${stateHistory3}    accepted    State should be accepted but is ${stateHistory3}



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
    
    ${lengthResponse}=     Set variable    Get Length    response
    Length Should Be    ${response.json()}    2        There should be 2 active departures, but only found ${lengthResponse}
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
    Should Not Be Empty    ${response.json()}
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
    Should Not Be Empty    ${response.json()}

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
Get User QR(Undefined 1 Should not be able to validate)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["66f5becbf3a0b05c0092e66f"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUser1}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUser1}
    Log    ${qrCodeUser1}
    Log    ${code}
Get User QR(Undefined 2 Should be able to validate has reservation)
    Skip
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

    ${qrCodeUser2}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUser2}
    Log    ${qrCodeUser2}
    Log    ${code}
Get User QR(User Barbara has reservation)
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

Validate With QR Assistant(Pending Assigned1 1 Ticket discounts)
    
    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeNico}", "seatNumber": "1"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    ${validationIdNico}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${validationIdNico}



Get Assigned Tickets After Validation(Nico)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=${idComunidad2}
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
        IF    "${user}[id]" == "666078059a5ece0ee6e95904"    BREAK
        Set Global Variable    ${assignedQtyNico}
    END
    Convert To Integer    ${assignedQtyNico}
    ${assignQtyMinus}=    Evaluate    ${assignQty}-1
    Convert To Integer    ${assignQtyMinus}
    Should Be True    ${assignedQtyNico}==${assignQtyMinus}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyNico}

Get Total Tickets After Validation(Nico)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Obtiene el tiempo de inicio
    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Obtiene el tiempo de finalización
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Calcula el tiempo transcurrido (elapsed)
    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}


    # Almacena la respuesta JSON en una variable para poder manipularla
    ${totalTicketsAfterValidation}=    Set Variable    ${response.json()}
    
    Convert To Integer    ${totalTicketsAfterValidation}
    ${ticketsMinus}    Evaluate    ${totalTickets}-1
    Should Be Equal As Integers    ${totalTicketsAfterValidation}    ${ticketsMinus}
    Log    La cantidad total de tickets es ${totalTicketsAfterValidation}

    Set Global Variable    ${totalTicketsAfterValidation}

Get Movement Historic Nico After Validation
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/movementHistory?community=${idComunidad2}&startDate=${start_date_tickets}&endDate=${end_date_tickets}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}[0]
    Should Be Equal As Strings    ${responseJson}[movementType]    cash        the movementType should be "Cash" due to a recent online validation found "${responseJson}[movementType]" instead
    ${responseQty}=    Evaluate    ${responseJson}[amountOfTickets] == 1
    Log    ${responseQty}
    ${previousQty}=    Evaluate    ${responseJson}[previousTickets] == 2
    Log    ${previousQty}
    ${currentQty}=    Evaluate    ${responseJson}[currentTickets] == 1
    Log    ${currentQty}

Delete Recent Validation
    #SE HACE CON ASSISTANt TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAssistant}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/assistant/departures/validation/${validationIdNico}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Sync Offline Nico, Should discounts another ticket
    Skip
    #SE HACE CON ASSISTANt TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAssistant}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/assistant/offline/sync
    ...    data={"validations":[{"assignedSeat":"1","assistantId":"66ccdf58193998eca49014c3","communityId":"6654ae4eba54fe502d4e4187","createdAt":"${fecha_actual_json}","departureId":"${departureId_1}","_id":"${uuid_qr}","internalId":"${uuid_qr}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-38.743664,"loc":{"float1":-72.61836,"float2":-38.743664},"longitude":-72.61836,"qrCode":"${qrCodeNico}","reason":["offline_validation"],"remainingTickets":0,"routeId":"${scheduleId}","synced":false,"token":"${tokenAssistant}","userId":"666078059a5ece0ee6e95904","validated":true}],"departures":[{"enabledSeats":[{"available":true,"_id":"671a9c938c19602dc1a312d3","seat":"1","userId":"666078059a5ece0ee6e95904"},{"available":true,"_id":"671a9c938c19602dc1a312d4","seat":"2"}],"_id":"${departureId_1}"}],"services":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Validate With QR Barbara(Pending Assigned2 User Dont have tickets)
    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=   Run Keyword and ignore Error    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeUserBarbara}","seatNumber": "2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Status Should Be    403    msg= Status should be 403  
Validate With QR Undefined1(User not certification)
    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  Run Keyword and expect error  HTTPError: 406 Client Error: Not Acceptable for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate   POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeUser1}","seatNumber": "2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Status Should Be    406

Get Active Departure 1 Details 2
    
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/${departureId_1}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
Get Active Departure 2 Details 2
    
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/${departureId_2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200



Check Validations in report to confirm validation webcontrol_failed
    skip
    #SE HACE CON DEPARTURE TOKEN#
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=api/v1/admin/pb/validations/list?community=6654ae4eba54fe502d4e4187&page=1&pageSize=20
    ...    data={"advancedSearch":false,"startDate":"${start_date_today}","endDate":"${end_date_tomorrow}","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"rut","value":""},{"key":"address","value":""},{"key":"coordinates","value":""},{"key":"Color","value":""},{"key":"Animal","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s
    ${lastValidationid}=    Set Variable    ${response.json()}[validations][-1][_id]
    ${lastValidation_state}=    Set Variable    ${response.json()}[validations][-1][validated]
    ${lastValidation_reason1}=    Set Variable    ${response.json()}[validations][-1][reason][0]
    ${lastValidation_reason2}=    Set Variable    ${response.json()}[validations][-1][reason][1]

    Should Be Equal As Strings    ${lastValidation_state}    False
    Should Be Equal As Strings    ${lastValidation_reason1}    ext_web_control
    Should Be Equal As Strings    ${lastValidation_reason2}    no_ticket
    

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

    
Validate Last Validation Across Pages
    skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json

    ${page}=    Set Variable    1
    ${pageSize}=    Set Variable    20
    ${validation_found}=    Set Variable    False

    WHILE    '${validation_found}' == 'False'
        ${response}=    POST On Session
        ...    mysesion
        ...    url=api/v1/admin/pb/validations/list?community=6654ae4eba54fe502d4e4187&page=${page}&pageSize=${pageSize}
        ...    data={"advancedSearch":false,"startDate":"${start_date_today}","endDate":"${end_date_tomorrow}","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"rut","value":""},{"key":"address","value":""},{"key":"coordinates","value":""},{"key":"Color","value":""},{"key":"Animal","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
        ...    headers=${headers}

        # Verifica el código de estado
        ${code}=    Convert To String    ${response.status_code}
        Status Should Be    200

        # Obtiene el número de validaciones en la respuesta
        ${validations}=    Set Variable    ${response.json()}[validations][-1]
        ${num_validations}=    Get Length    ${validations}

        # Recorre las validaciones de la página actual
        FOR    ${validation}    IN    @{validations}
            ${lastValidation_state}=    Set Variable    ${validation}[validated]
            ${lastValidation_reason1}=    Set Variable    ${validation}[reason][0]
            ${lastValidation_id}=    Set Variable    ${validation}[_id]
            ${lastValidation_reason2}=    Set Variable    ${validation}[reason][1]

            Run Keyword If    '${lastValidation_state}' == 'False' AND '${lastValidation_reason1}' == 'ext_web_control' AND '${lastValidation_reason2}' == 'no_ticket'    Set Variable    validation_found    True
        END
        # Si no encontró la validación en la página actual, pasa a la siguiente página
        Run Keyword If    '${validation_found}' == 'False'    Log    No validación encontrada en página ${page}, continuando a la siguiente página.
        Run Keyword If    '${validation_found}' == 'False'    ${page}=    Set Variable    ${page + 1}
        Run Keyword If    '${num_validations}' < ${pageSize}    Set Variable    validation_found    True    # No hay más páginas, detén la búsqueda

    END

    # Log para indicar que se encontró la validación
    Run Keyword If    '${validation_found}' == 'True'    Log    Validación encontrada en la página ${page}.
    Run Keyword If    '${validation_found}' == 'False'    Fail    No se encontró la validación esperada.

#-------------------------------------Link validations with QR code Bus---------------------------------------------# 

Departure Historic
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/departures/history

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
Departure Historic Driver
    Skip
    Set Log Level    TRACE
    # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/departures/history?startDate='2024-09-10'&endDate='2024-09-11'

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer cdd8b4c15feb8aafdbede7c31edc133ede451b0a6c75adf3a37e60c3722110472b28ee51ac37d5321b336b229d1db559631ccee416c53ba996b23f6a4a47733f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200


Route List(Map View)
    Skip
        # CON ESTE ENDPOINT PUEDO SABER CUALES FUERON LINKEADOS Y VALIDADOS
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/pb/assistant/routes

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200



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
