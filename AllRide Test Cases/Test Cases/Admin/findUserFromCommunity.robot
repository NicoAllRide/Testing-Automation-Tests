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



Generate Random 10 Digit Value
    ${random_value1}=    Evaluate    "".join([str(random.randint(0,9)) for _ in range(10)])    random
    Log    Valor aleatorio generado: ${random_value1}
    Set Global Variable    ${random_value1}

1 hours local 
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}


Create new service in the selected route
    [Documentation]     Crear un nuevo servicio en la ruta 66f310608e6c377a3f43968e, si no se encuentra el servicio creado se ejecuta un Fatal error
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/routes/66f310608e6c377a3f43968e?community=6654ae4eba54fe502d4e4187
    ...    data={"_id":"66f310608e6c377a3f43968e","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["66f310608e6c377a3f43968e"],"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":["66ccdf58193998eca49014c3"],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":true,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"name":"Flujo Tickets Auxiliar","shapeId":"6654d514713b9a5184cfe21e","description":"Flujo Tickets Auxiliar","extraInfo":"","color":"652525","legOptions":[],"ownerIds":[{"_id":"66954794b24db9885e5aed83","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[{"_id":"66faba3063836b24c20ecabb","position":1,"distance":290.2660419534011,"lat":-34.408530000000006,"lon":-70.85308,"loc":[-70.85308,-34.408530000000006]},{"_id":"66faba3063836b24c20ecabc","position":2,"distance":488.1040403831149,"lat":-34.40699,"lon":-70.852,"loc":[-70.852,-34.40699]},{"_id":"66faba3063836b24c20ecabd","position":3,"distance":781.9113593811135,"lat":-34.40496,"lon":-70.84995,"loc":[-70.84995,-34.40496]},{"_id":"66faba3063836b24c20ecabe","position":4,"distance":1104.6940260856932,"lat":-34.40296,"lon":-70.84740000000001,"loc":[-70.84740000000001,-34.40296]},{"_id":"66faba3063836b24c20ecabf","position":5,"distance":1122.8597601245997,"lat":-34.402800000000006,"lon":-70.84736000000001,"loc":[-70.84736000000001,-34.402800000000006]},{"_id":"66faba3063836b24c20ecac0","position":6,"distance":1292.2891375798047,"lat":-34.40267,"lon":-70.84552000000001,"loc":[-70.84552000000001,-34.40267]},{"_id":"66faba3063836b24c20ecac1","position":7,"distance":1459.1985795046444,"lat":-34.40229,"lon":-70.84376,"loc":[-70.84376,-34.40229]},{"_id":"66faba3063836b24c20ecac2","position":8,"distance":1583.0555768914546,"lat":-34.40229,"lon":-70.84241,"loc":[-70.84241,-34.40229]},{"_id":"66faba3063836b24c20ecac3","position":9,"distance":2238.7794491503846,"lat":-34.40344,"lon":-70.8354,"loc":[-70.8354,-34.40344]},{"_id":"66faba3063836b24c20ecac4","position":10,"distance":2367.730135581892,"lat":-34.40379,"lon":-70.83406000000001,"loc":[-70.83406000000001,-34.40379]},{"_id":"66faba3063836b24c20ecac5","position":11,"distance":2813.2702156190876,"lat":-34.40545,"lon":-70.82964000000001,"loc":[-70.82964000000001,-34.40545]},{"_id":"66faba3063836b24c20ecac6","position":12,"distance":2907.937653439918,"lat":-34.405660000000005,"lon":-70.82864000000001,"loc":[-70.82864000000001,-34.405660000000005]},{"_id":"66faba3063836b24c20ecac7","position":13,"distance":3103.8542952895764,"lat":-34.40598,"lon":-70.82654000000001,"loc":[-70.82654000000001,-34.40598]},{"_id":"66faba3063836b24c20ecac8","position":14,"distance":3399.7333701489256,"lat":-34.406130000000005,"lon":-70.82332000000001,"loc":[-70.82332000000001,-34.406130000000005]},{"_id":"66faba3063836b24c20ecac9","position":15,"distance":3777.3304160935245,"lat":-34.40782,"lon":-70.81975,"loc":[-70.81975,-34.40782]},{"_id":"66faba3063836b24c20ecaca","position":16,"distance":4027.852872329667,"lat":-34.409060000000004,"lon":-70.81747,"loc":[-70.81747,-34.409060000000004]},{"_id":"66faba3063836b24c20ecacb","position":17,"distance":4262.946941118368,"lat":-34.40968,"lon":-70.81502,"loc":[-70.81502,-34.40968]},{"_id":"66faba3063836b24c20ecacc","position":18,"distance":4331.54548643874,"lat":-34.40997,"lon":-70.81436000000001,"loc":[-70.81436000000001,-34.40997]},{"_id":"66faba3063836b24c20ecacd","position":19,"distance":4470.011462521272,"lat":-34.41068,"lon":-70.81312000000001,"loc":[-70.81312000000001,-34.41068]},{"_id":"66faba3063836b24c20ecace","position":20,"distance":4569.730370049159,"lat":-34.41037,"lon":-70.8121,"loc":[-70.8121,-34.41037]},{"_id":"66faba3063836b24c20ecacf","position":21,"distance":4885.998380967774,"lat":-34.40916,"lon":-70.80898,"loc":[-70.80898,-34.40916]},{"_id":"66faba3063836b24c20ecad0","position":22,"distance":5117.696468148955,"lat":-34.40769,"lon":-70.80719,"loc":[-70.80719,-34.40769]},{"_id":"66faba3063836b24c20ecad1","position":23,"distance":5264.734491572538,"lat":-34.406670000000005,"lon":-70.80617000000001,"loc":[-70.80617000000001,-34.406670000000005]},{"_id":"66faba3063836b24c20ecad2","position":24,"distance":5425.207136314769,"lat":-34.405620000000006,"lon":-70.80497000000001,"loc":[-70.80497000000001,-34.405620000000006]},{"_id":"66faba3063836b24c20ecad3","position":25,"distance":5509.906626643151,"lat":-34.40527,"lon":-70.80415,"loc":[-70.80415,-34.40527]},{"_id":"66faba3063836b24c20ecad4","position":26,"distance":5600.221898860165,"lat":-34.40466,"lon":-70.8035,"loc":[-70.8035,-34.40466]},{"_id":"66faba3063836b24c20ecad5","position":27,"distance":5755.68153334114,"lat":-34.404250000000005,"lon":-70.80188000000001,"loc":[-70.80188000000001,-34.404250000000005]},{"_id":"66faba3063836b24c20ecad6","position":28,"distance":5915.319583664183,"lat":-34.40424,"lon":-70.80014,"loc":[-70.80014,-34.40424]},{"_id":"66faba3063836b24c20ecad7","position":29,"distance":6007.047842778099,"lat":-34.40404,"lon":-70.79917,"loc":[-70.79917,-34.40404]},{"_id":"66faba3063836b24c20ecad8","position":30,"distance":6182.3341417231395,"lat":-34.40551,"lon":-70.79848000000001,"loc":[-70.79848000000001,-34.40551]},{"_id":"66faba3063836b24c20ecad9","position":31,"distance":6367.330377715924,"lat":-34.40664,"lon":-70.79700000000001,"loc":[-70.79700000000001,-34.40664]},{"_id":"66faba3063836b24c20ecada","position":32,"distance":6527.46821540092,"lat":-34.407920000000004,"lon":-70.7962,"loc":[-70.7962,-34.407920000000004]},{"_id":"66faba3063836b24c20ecadb","position":33,"distance":7287.353626388585,"lat":-34.404030000000006,"lon":-70.78939000000001,"loc":[-70.78939000000001,-34.404030000000006]},{"_id":"66faba3063836b24c20ecadc","position":34,"distance":7845.43322025191,"lat":-34.40109,"lon":-70.78446000000001,"loc":[-70.78446000000001,-34.40109]},{"_id":"66faba3063836b24c20ecadd","position":35,"distance":7882.902565797689,"lat":-34.40119,"lon":-70.78407,"loc":[-70.78407,-34.40119]},{"_id":"66faba3063836b24c20ecade","position":36,"distance":8083.244366156947,"lat":-34.40008,"lon":-70.78235000000001,"loc":[-70.78235000000001,-34.40008]},{"_id":"66faba3063836b24c20ecadf","position":37,"distance":8151.255642391474,"lat":-34.399550000000005,"lon":-70.78272000000001,"loc":[-70.78272000000001,-34.399550000000005]},{"_id":"66faba3063836b24c20ecae0","position":38,"distance":8242.744317444498,"lat":-34.39882,"lon":-70.78226000000001,"loc":[-70.78226000000001,-34.39882]},{"_id":"66faba3063836b24c20ecae1","position":39,"distance":8448.184416414158,"lat":-34.397040000000004,"lon":-70.78166,"loc":[-70.78166,-34.397040000000004]},{"_id":"66faba3063836b24c20ecae2","position":40,"distance":8467.636269238845,"lat":-34.39687,"lon":-70.78171,"loc":[-70.78171,-34.39687]},{"_id":"66faba3063836b24c20ecae3","position":41,"distance":8609.810198718747,"lat":-34.39578,"lon":-70.78252,"loc":[-70.78252,-34.39578]},{"_id":"66faba3063836b24c20ecae4","position":42,"distance":8702.762775926865,"lat":-34.395430000000005,"lon":-70.78160000000001,"loc":[-70.78160000000001,-34.395430000000005]},{"_id":"66faba3063836b24c20ecae5","position":43,"distance":8729.30555711264,"lat":-34.395250000000004,"lon":-70.78141000000001,"loc":[-70.78141000000001,-34.395250000000004]},{"_id":"66faba3063836b24c20ecae6","position":44,"distance":8771.583165938728,"lat":-34.3949,"lon":-70.78123000000001,"loc":[-70.78123000000001,-34.3949]}],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","routeCost":10,"ticketCost":100,"timeOnRoute":14,"distance":9,"distanceInMeters":8784,"createdAt":"2024-09-24T19:17:52.759Z","updatedAt":"2025-01-03T20:05:48.776Z","__v":221,"rating":{"enabled":false,"withValidation":false},"hasBarrier":false,"minimumTimeToForceDeparture":{"amount":5,"enabled":false,"unit":"minutes"},"DNIValidation":{"enabled":false},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"roundOrder":[],"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"useServiceReservations":true}
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
    [Documentation]    Iniciar la creación de servicios
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
    Sleep    10s


Create User
    [Documentation]    Crear código de enrolamiento al crear un usuario
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/communityValidationUsers/?community=6654ae4eba54fe502d4e4187
    ...    data={"community":"6654ae4eba54fe502d4e4187","values":[{"key":"rut","value":"1938473829","public":true,"check":true},{"key":"coordinates","value":"","public":false,"check":false},{"key":"address","value":"","public":true,"check":false},{"key":"Color","value":"Negro","public":true,"check":false},{"key":"Animal","value":"Perro","public":true,"check":false},{"key":"Empresa","value":"AllRide","public":true,"check":false}],"validated":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${usersFound}=    Set Variable   ${response.json()}

Create User part 2
    [Documentation]    Crear usuario con código de enrolamiento recientemente creado
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/users/createUser?community=6654ae4eba54fe502d4e4187
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","country":"cl","name":"Usuario QA Eliminar","customValidation":{"rut":"1938473829","address":"","coordinates":"","Color":"Negro","Animal":"Perro","Empresa":"AllRide"},"phoneNumber":null,"validationId":"683f31a1c0385302510120f9"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${userId}=    Set Variable   ${response.json()}[correct][0][_id]

    Set Global Variable    ${userId}




Find User (Usuario QA Eliminar)
    [Documentation]    Buscar al usuario recién creado
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/support/users/list?search=usuario%20qa%20eliminar
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${userFound_name}=    Set Variable   ${response.json()}[0][name]
    ${userFound_id}=    Set Variable    ${response.json()}[0][_id]
    Should Be Equal As Strings    Usuario QA Eliminar    ${userFound_name}



Get Service Id
    [Documentation]     Obtener servicio creado recientemente, si no se encuentra se ejecuta un fatal error
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad2}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
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

    Sleep    20s
Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id}?community=${idComunidad2}
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId2}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId2}","capacity":"5"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${departureId}=     Set Variable    ${response.json()}[resources][0][departure][departureId]

    Set Global Variable    ${departureId}
    Log    ${code}

    ${departure_capacity}=    Set Variable    ${response.json()}[resources][0][departure][capacity]
    Should Be Equal As Numbers    ${departure_capacity}    46
    ...    msg=❌ 'departure.capacity' should be 46 but was ${departure_capacity}

    ${vehicle_capacity}=    Set Variable    ${response.json()}[resources][0][vehicle][capacity]
    Should Be Equal As Numbers    ${vehicle_capacity}    46
    ...    msg=❌ 'vehicle.capacity' should be 46 but was ${vehicle_capacity}


Get Departure Info (Capacity and Start Capacity)
    Set Log Level    TRACE
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]
    
    
    Should Be Equal As Numbers    ${capacity}    46
    ...    msg=❌ 'capacity' should be 46 but was ${capacity}
    
    Should Be Equal As Strings    ${startCapacity}    46
    ...    msg=❌ 'startCapacity' should be 46 but was ${startCapacity}

Make reservation from admin
    [Documentation]    Se realiza la reserva del usuario desde el admin
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/bookService/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    data={"userId":"${userId}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Get Departure Info After reservations(Capacity and Start Capacity)
    Set Log Level    TRACE
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]
    
    
    Should Be Equal As Numbers    ${capacity}    45
    ...    msg=❌ 'capacity' should be 45 but was ${capacity}
    
        Should Be Equal As Strings    ${startCapacity}    46
    ...    msg=❌ 'startCapacity' should be 46 but was ${startCapacity}
Delete user from allride
    [Documentation]    Se elimina el usuario de AllRide

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/superadmin/user/${userId}
    ...    data={"reason":"qa"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)


Find User (Usuario QA Eliminar)
        [Documentation]    Se busca el usuario recién eliminado, no debería encontrarse

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/support/users/list?search=usuario%20qa%20eliminar
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${userFounds}=    Set Variable    ${response.json()}
    Should Be Empty    ${userFounds}

Get service details(Should not have any reservation after user deletion)
    [Documentation]    Se verifica que no hayan reservas en el servicio recién creado luego de la eliminación del usuario
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/service/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${reservations}=    Set Variable    ${response.json()}[reservations]
    Should Be Empty    ${reservations}    Reservations should be empty after user deletion

Get reservation after user delete in departure
    Set Log Level    TRACE
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    0        Has found a reservation when it should be none

Get Departure Info After user delete(Capacity and Start Capacity)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]
    
    
    Should Be Equal As Numbers    ${capacity}    46
    ...    msg=❌ 'capacity' should be 46 but was ${capacity}
    
        Should Be Equal As Strings    ${startCapacity}    46
    ...    msg=❌ 'startCapacity' should be 46 but was ${startCapacity}

