*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../../../Variables/variablesTesting.resource


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


Verify Open RDD in Community
        # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/superadmin/communities/${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=     Set variable    ${response.json()}
    ${enabled}=    Set Variable     ${responseJson}[custom][realTimeTransportSystem][buses][oDDServices][0][userRequests][freeRequests][enabled]
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    
    Should Be Equal As Strings    ${enabled}   True
Verify Join RDD Admin Config
        # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/superadmin/communities/${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=     Set variable    ${response.json()}
    ${enabled}=    Set Variable     ${responseJson}[custom][realTimeTransportSystem][buses][oDDSettings][joinNewAdminODDs]

    Should Be Equal As Strings    ${enabled}    True
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
Verify New Users Can RDD Admin Config
        # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/superadmin/communities/${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=     Set variable    ${response.json()}
    ${enabled}=    Set Variable     ${responseJson}[custom][realTimeTransportSystem][buses][oDDSettings][enableToNewUsers][enabled]

    Should Be Equal As Strings    ${enabled}    True
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    

Get Places
        ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/admin/places/list?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}
Create Simplify RDD As Admin
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd?community=${idComunidad}

    ...    data={"superCommunityId":"65d4ab3b8b93abd1456cf0d1","superCommunities":null,"communities":null,"adminId":"6539259749de536fe0930341","adminName":"Soporte AllRide","state":"pendingDriverAssignment","name":"simplify ${today_date}","oddType":"Taxis Coni y Nico","oddSimpleFlow":true,"placeLat":-33.5654,"placeLon":-70.7796,"serviceCost":0,"apportionByParams":[],"direction":"in","comments":"","serviceDate":"${service_date}","extraMinutes":0,"estimatedArrival":"${r_estimated_arrival1}","reservations":[{"userId":"${idNico}","stopId":"662676f29912980e4ea80d57","placeId":null,"order":0,"estimatedArrival":null,"distances":{"fromPrevious":0,"toNext":5778,"distanceToLocation":5778,"pctToLocation":1}}],"waypoints":[[-70.78127,-33.53278],[-70.78187000000001,-33.53273],[-70.78190000000001,-33.532790000000006],[-70.78214000000001,-33.53298],[-70.78323,-33.53371],[-70.78391,-33.53418],[-70.78595,-33.535590000000006],[-70.78636,-33.53584],[-70.78677,-33.53613],[-70.78754,-33.536660000000005],[-70.78819,-33.53714],[-70.78968,-33.538180000000004],[-70.7912,-33.53922],[-70.79113000000001,-33.539280000000005],[-70.79151,-33.53954],[-70.79091000000001,-33.5401],[-70.79032000000001,-33.54061],[-70.78971,-33.54117],[-70.78911000000001,-33.541720000000005],[-70.78827000000001,-33.542440000000006],[-70.78926,-33.5431],[-70.78978000000001,-33.54346],[-70.79016,-33.543710000000004],[-70.79019000000001,-33.54377],[-70.79022,-33.54383],[-70.79032000000001,-33.543910000000004],[-70.79103,-33.54442],[-70.79225000000001,-33.545280000000005],[-70.79266000000001,-33.545590000000004],[-70.79249,-33.54572],[-70.79149000000001,-33.546490000000006],[-70.79157000000001,-33.54657],[-70.79161,-33.546600000000005],[-70.79140000000001,-33.546780000000005],[-70.79131000000001,-33.5469],[-70.79055000000001,-33.54751],[-70.7904,-33.547560000000004],[-70.79009,-33.547810000000005],[-70.78996000000001,-33.54788],[-70.78862000000001,-33.54905],[-70.79088,-33.550610000000006],[-70.79537,-33.55371],[-70.79552000000001,-33.553810000000006],[-70.79554,-33.55393],[-70.79555,-33.554010000000005],[-70.7954,-33.554170000000006],[-70.79519,-33.55431],[-70.79511000000001,-33.55438],[-70.79495,-33.554570000000005],[-70.79485000000001,-33.55467],[-70.79402,-33.55541],[-70.79278000000001,-33.55637],[-70.79152,-33.55734],[-70.79059000000001,-33.558040000000005],[-70.78927,-33.559050000000006],[-70.78808000000001,-33.560010000000005],[-70.78732000000001,-33.560570000000006],[-70.78691,-33.560900000000004],[-70.78606,-33.56157],[-70.78535000000001,-33.562110000000004],[-70.78426,-33.56295],[-70.78323,-33.56376],[-70.78290000000001,-33.564040000000006],[-70.78280000000001,-33.56421],[-70.78278,-33.564400000000006],[-70.78282,-33.56468],[-70.78279,-33.56488],[-70.78267000000001,-33.565070000000006],[-70.78248,-33.565270000000005],[-70.78204000000001,-33.56562],[-70.78184,-33.56568],[-70.78175,-33.56568],[-70.78155000000001,-33.565630000000006],[-70.7814,-33.565540000000006],[-70.78124000000001,-33.56542],[-70.78091,-33.56571],[-70.78026000000001,-33.56627],[-70.78011000000001,-33.56611],[-70.78003000000001,-33.56599],[-70.77995,-33.565870000000004],[-70.77954000000001,-33.56544]],"estimatedDistance":5778,"startLocation":{"lat":-33.532782,"lon":-70.7812735,"loc":[-70.7812735,-33.532782],"stopId":"662676f29912980e4ea80d57","referencePoint":true},"endLocation":{"lat":-33.5654,"lon":-70.7796,"loc":[-70.7796,-33.5654],"placeId":"65d4ad578b93abd1456cf3ea","stopId":"65d4ad578b93abd1456cf3eb"},"placeWaitTime":0,"reason":"","linkedDeparture":null,"reservationsToLink":[],"driverId":null,"driverCode":null,"isPastService":false,"communityId":"","placeId":"65d4ad578b93abd1456cf3ea","stopId":"65d4ad578b93abd1456cf3eb","serviceHour":"${service_date}","placeName":"Ciudad Satelite","placeLongName":"Ciudad Satelite Maipu","hourIsDepartureOrArrival":"departure","roundedDistance":"5.78","travelTime":793,"originalEstimatedArrival":"","originalServiceDate":"","originalTravelTime":793,"adjustmentFactor":1,"totalReservations":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${rddId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddId}

Search Candidate To Join
        Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/searchJoinable?community=${idComunidad}

    ...    data={"superCommunityId":"65d4ab3b8b93abd1456cf0d1","superCommunities":null,"communities":null,"adminId":"6539259749de536fe0930341","adminName":"Soporte AllRide","state":"pendingDriverAssignment","name":"simplify ${today_date}","oddType":"Taxis Coni y Nico","oddSimpleFlow":true,"placeLat":-33.5654,"placeLon":-70.7796,"serviceCost":0,"apportionByParams":[],"direction":"in","comments":"","serviceDate":"${service_date}","extraMinutes":0,"estimatedArrival":"${r_estimated_arrival1}","reservations":[{"userId":"${idPedro}","stopId":"662676f29912980e4ea80d57","placeId":null,"order":0,"estimatedArrival":null,"distances":{"fromPrevious":0,"toNext":5778,"distanceToLocation":5778,"pctToLocation":1}}],"waypoints":[[-70.78127,-33.53278],[-70.78187000000001,-33.53273],[-70.78190000000001,-33.532790000000006],[-70.78214000000001,-33.53298],[-70.78323,-33.53371],[-70.78391,-33.53418],[-70.78595,-33.535590000000006],[-70.78636,-33.53584],[-70.78677,-33.53613],[-70.78754,-33.536660000000005],[-70.78819,-33.53714],[-70.78968,-33.538180000000004],[-70.7912,-33.53922],[-70.79113000000001,-33.539280000000005],[-70.79151,-33.53954],[-70.79091000000001,-33.5401],[-70.79032000000001,-33.54061],[-70.78971,-33.54117],[-70.78911000000001,-33.541720000000005],[-70.78827000000001,-33.542440000000006],[-70.78926,-33.5431],[-70.78978000000001,-33.54346],[-70.79016,-33.543710000000004],[-70.79019000000001,-33.54377],[-70.79022,-33.54383],[-70.79032000000001,-33.543910000000004],[-70.79103,-33.54442],[-70.79225000000001,-33.545280000000005],[-70.79266000000001,-33.545590000000004],[-70.79249,-33.54572],[-70.79149000000001,-33.546490000000006],[-70.79157000000001,-33.54657],[-70.79161,-33.546600000000005],[-70.79140000000001,-33.546780000000005],[-70.79131000000001,-33.5469],[-70.79055000000001,-33.54751],[-70.7904,-33.547560000000004],[-70.79009,-33.547810000000005],[-70.78996000000001,-33.54788],[-70.78862000000001,-33.54905],[-70.79088,-33.550610000000006],[-70.79537,-33.55371],[-70.79552000000001,-33.553810000000006],[-70.79554,-33.55393],[-70.79555,-33.554010000000005],[-70.7954,-33.554170000000006],[-70.79519,-33.55431],[-70.79511000000001,-33.55438],[-70.79495,-33.554570000000005],[-70.79485000000001,-33.55467],[-70.79402,-33.55541],[-70.79278000000001,-33.55637],[-70.79152,-33.55734],[-70.79059000000001,-33.558040000000005],[-70.78927,-33.559050000000006],[-70.78808000000001,-33.560010000000005],[-70.78732000000001,-33.560570000000006],[-70.78691,-33.560900000000004],[-70.78606,-33.56157],[-70.78535000000001,-33.562110000000004],[-70.78426,-33.56295],[-70.78323,-33.56376],[-70.78290000000001,-33.564040000000006],[-70.78280000000001,-33.56421],[-70.78278,-33.564400000000006],[-70.78282,-33.56468],[-70.78279,-33.56488],[-70.78267000000001,-33.565070000000006],[-70.78248,-33.565270000000005],[-70.78204000000001,-33.56562],[-70.78184,-33.56568],[-70.78175,-33.56568],[-70.78155000000001,-33.565630000000006],[-70.7814,-33.565540000000006],[-70.78124000000001,-33.56542],[-70.78091,-33.56571],[-70.78026000000001,-33.56627],[-70.78011000000001,-33.56611],[-70.78003000000001,-33.56599],[-70.77995,-33.565870000000004],[-70.77954000000001,-33.56544]],"estimatedDistance":5778,"startLocation":{"lat":-33.532782,"lon":-70.7812735,"loc":[-70.7812735,-33.532782],"stopId":"662676f29912980e4ea80d57","referencePoint":true},"endLocation":{"lat":-33.5654,"lon":-70.7796,"loc":[-70.7796,-33.5654],"placeId":"65d4ad578b93abd1456cf3ea","stopId":"65d4ad578b93abd1456cf3eb"},"placeWaitTime":0,"reason":"","linkedDeparture":null,"reservationsToLink":[],"driverId":null,"driverCode":null,"isPastService":false,"communityId":"","placeId":"65d4ad578b93abd1456cf3ea","stopId":"65d4ad578b93abd1456cf3eb","serviceHour":"${service_date}","placeName":"Ciudad Satelite","placeLongName":"Ciudad Satelite Maipu","hourIsDepartureOrArrival":"departure","roundedDistance":"5.78","travelTime":793,"originalEstimatedArrival":"","originalServiceDate":"","originalTravelTime":793,"adjustmentFactor":1,"totalReservations":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${candidateId}=    Set Variable    ${response.json()}[candidateODD][_id]
    ${stateHistory}=     Set Variable    ${response.json()}[originalODD][stateHistory][0]
    ${stateHistoryId}=     Set Variable    ${stateHistory}[_id]
    ${stateHistoryState}=     Set Variable    ${stateHistory}[state]
    ${stateHistoryAdminId}=     Set Variable    ${stateHistory}[adminId]
    ${stateHistoryDate}=     Set Variable    ${stateHistory}[date]

    Set Global Variable    ${candidateId}
    Set Global Variable    ${stateHistoryId}
    Set Global Variable    ${stateHistoryState}
    Set Global Variable    ${stateHistoryAdminId}
    Set Global Variable    ${stateHistoryDate}

    
Create RDD To Join

        Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/joinODD?community=653fd601f90509541a748683&candidateDeparture=${candidateId}

    ...    data={"restrictPassengers":{"enabled":false,"passengersMustComply":true,"allowedOnValidation":[],"allowedOnReservation":[],"allowedOnVisibility":[]},"superCommunities":[],"communities":["${idComunidad}"],"assistantIds":[],"active":false,"sharing":false,"disabled":false,"internal":false,"rounds":0,"distance":0,"scheduled":false,"odd":true,"estimatedDistance":0,"extraMinutes":0,"placeWaitTime":0,"hasExternalGPS":false,"allowsServiceSnapshots":false,"allowsNonServiceSnapshots":false,"allowsSnapshots":false,"allowsDistance":false,"usesOfflineCount":false,"_id":"${candidateId}","oDDEmergency":false,"oddSimpleFlow":true,"state":"","stateHistory":[{"_id":"${stateHistoryId}","state":"created","adminId":"${idAdmin}","date":"${stateHistoryDate}"}],"driverId":null,"adminId":"${idAdmin}","driverCode":null,"name":"Join Departure Pedro","reason":"","direction":"in","comments":"","serviceDate":"${today_date}T21:01:00.000Z","reservations":[{"waitTime":0,"validated":false,"fromApp":false,"joined":false,"approvedByDriver":true,"_id":"66184fb35edf58eada319903","userId":"${idPedro}","stopId":"655d11d88a5a1a1ff0328466","placeId":null,"order":0,"estimatedArrival":null,"distances":{"toPrevious":0,"toNext":0,"distanceToLocation":0,"pctToLocation":0}}],"waypoints":{"type":"LineString"},"estimatedArrival":null,"startLocation":{"_id":"66184fb35edf58eada319904","lat":-33.3908833,"lon":-70.54620129999999,"loc":[-70.54620129999999,-33.3908833],"stopId":"655d11d88a5a1a1ff0328466","referencePoint":true},"endLocation":{"_id":"66184fb35edf58eada319905","lat":-33.4098734,"lon":-70.5673477,"loc":[-70.5673477,-33.4098734],"stopId":"655d11d88a5a1a1ff0328464"},"drivers":[],"categories":[],"trail":[],"legs":[],"deviceHistory":[],"apportionByCategories":[],"enabledSeats":[],"customParams":[],"customParamsAtTheEnd":[],"preTripChecklist":[],"oddType":"Taxis Coni y Nico","communityId":"${idComunidad}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${rddIdJoin}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddIdJoin}

####################################################
##Get Routes As Driver Pendiente

#######################################################

