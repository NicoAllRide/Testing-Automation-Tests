*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../../../Variables/variablesStage.robot


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

Time + 1 Hour
    ${date}    Get Current Date    time_zone=UTC    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}


Verify Open RDD in Community
    Skip
        # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/superadmin/communities/${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=     Set variable    ${response.json()}
    ${enabled}=    Set Variable     ${responseJson}[custom][realTimeTransportSystem][buses][oDDServices][0][userRequests][freeRequests][enabled]
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    
    Should Be Equal As Strings    ${enabled}   True

Get Places
        ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/places/list?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}
Create RDD As Admin
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd?community=${idComunidad}

    ...    data={"superCommunityId":"653fd68233d83952fafcd4be","adminId":"66d75c62a1b7bc9a1dd231c6","adminName":"Soporte AllRide","oddSimpleFlow":false,"state":"pendingDriverAssignment","name":"RDD action on stop","oddType":"Taxis Coni y Nico","placeLat":-34.4111,"placeLon":-70.8537,"serviceCost":0,"calculatedCosts":{},"apportionByParams":[],"direction":"out","comments":"","serviceDate":"${formatted_one_hour_later}","extraMinutes":0,"estimatedArrival":"${r_estimated_arrival1}","reservations":[{"manuallyBooked":true,"userId":"65e8e076337a90a35ba6e8dd","stopId":"65e975a20bdb0bb5d4008898","placeId":null,"order":2,"estimatedArrival":"2025-07-17T20:35:30.000Z","distances":{"fromPrevious":110413,"toNext":1732,"distanceToLocation":1732,"pctToLocation":0.014707380863421759}},{"manuallyBooked":true,"userId":"65e092afca7842b1032f12e2","stopId":"654054d62d5b0119311ae116","placeId":null,"order":0,"estimatedArrival":"2025-07-17T19:00:00.000Z","distances":{"fromPrevious":0,"toNext":5619,"distanceToLocation":117764,"pctToLocation":1}},{"manuallyBooked":true,"userId":"67a231824e4333dad7f36f75","stopId":"653ffde9f90509541a749e18","placeId":null,"order":1,"estimatedArrival":"2025-07-17T19:13:30.000Z","distances":{"fromPrevious":5619,"toNext":110413,"distanceToLocation":112145,"pctToLocation":0.952285927787779}}],"waypoints":[[-70.78127,-33.53278],[-70.78187000000001,-33.53273],[-70.78214000000001,-33.53298],[-70.78391,-33.53418],[-70.78754,-33.536660000000005],[-70.7912,-33.53922],[-70.79151,-33.53954],[-70.79091000000001,-33.5401],[-70.78971,-33.54117],[-70.78827000000001,-33.542440000000006],[-70.78926,-33.5431],[-70.79019000000001,-33.54377],[-70.79103,-33.54442],[-70.79225000000001,-33.545280000000005],[-70.79266000000001,-33.545590000000004],[-70.79249,-33.54572],[-70.79157000000001,-33.54657],[-70.79055000000001,-33.54751],[-70.78996000000001,-33.54788],[-70.78862000000001,-33.54905],[-70.79088,-33.550610000000006],[-70.79537,-33.55371],[-70.79554,-33.55393],[-70.7954,-33.554170000000006],[-70.79511000000001,-33.55438],[-70.79278000000001,-33.55637],[-70.78927,-33.559050000000006],[-70.78606,-33.56157],[-70.78426,-33.56295],[-70.78295,-33.56389],[-70.78149,-33.562490000000004],[-70.7814,-33.562270000000005],[-70.78085,-33.5623],[-70.78066000000001,-33.56199],[-70.78054,-33.562000000000005],[-70.78049,-33.56222],[-70.78054,-33.562000000000005],[-70.78066000000001,-33.56199],[-70.78085,-33.5623],[-70.78134,-33.56214],[-70.78122,-33.56183],[-70.78107,-33.56147],[-70.78062,-33.56033],[-70.7795,-33.55903],[-70.77926000000001,-33.55874],[-70.77883,-33.55754],[-70.77839,-33.55639],[-70.77835,-33.55621],[-70.77773,-33.55646],[-70.77586000000001,-33.55711],[-70.77583,-33.55713],[-70.77575,-33.55715],[-70.77561,-33.557210000000005],[-70.77532000000001,-33.557300000000005],[-70.77439000000001,-33.55762],[-70.77291000000001,-33.55811],[-70.76689,-33.56022],[-70.76491,-33.560900000000004],[-70.76324000000001,-33.560970000000005],[-70.76198000000001,-33.561460000000004],[-70.75973,-33.56224],[-70.7594,-33.562020000000004],[-70.75895000000001,-33.56148],[-70.75840000000001,-33.560810000000004],[-70.7564,-33.558530000000005],[-70.75508,-33.55706],[-70.75394,-33.55575],[-70.75362000000001,-33.55595],[-70.75298000000001,-33.55644],[-70.75044000000001,-33.55839],[-70.74965,-33.559000000000005],[-70.74497000000001,-33.56262],[-70.74264000000001,-33.56436],[-70.73556,-33.5687],[-70.73047000000001,-33.571780000000004],[-70.72992,-33.571360000000006],[-70.72967,-33.57081],[-70.72903000000001,-33.569210000000005],[-70.72845000000001,-33.56777],[-70.72827000000001,-33.56767],[-70.72657000000001,-33.567690000000006],[-70.72569,-33.56787],[-70.72436,-33.56786],[-70.7222,-33.56772],[-70.71811000000001,-33.56752],[-70.71650000000001,-33.567510000000006],[-70.71537000000001,-33.56739],[-70.7123,-33.567240000000005],[-70.71192,-33.56736],[-70.71201,-33.56797],[-70.71222,-33.569250000000004],[-70.71283000000001,-33.57271],[-70.7132,-33.573980000000006],[-70.71374,-33.57743],[-70.71404000000001,-33.58001],[-70.71408000000001,-33.58113],[-70.71406,-33.58223],[-70.71453000000001,-33.58639],[-70.71598,-33.59801],[-70.71676000000001,-33.60428],[-70.71692,-33.60645],[-70.71683,-33.60822],[-70.7166,-33.61027],[-70.71592000000001,-33.61497],[-70.7137,-33.6302],[-70.71259,-33.637660000000004],[-70.71188000000001,-33.6426],[-70.7116,-33.64484],[-70.71163,-33.64643],[-70.71205,-33.64808],[-70.71386000000001,-33.65236],[-70.71593,-33.65704],[-70.71973000000001,-33.66559],[-70.72279,-33.6728],[-70.72563000000001,-33.679410000000004],[-70.7261,-33.6807],[-70.72632,-33.681920000000005],[-70.72647,-33.68484],[-70.72644000000001,-33.68553],[-70.72602,-33.688100000000006],[-70.72540000000001,-33.69005],[-70.72316000000001,-33.69698],[-70.72264000000001,-33.69868],[-70.72242,-33.70028],[-70.72256,-33.70212],[-70.7227,-33.70271],[-70.72321000000001,-33.70517],[-70.72453,-33.710350000000005],[-70.72616000000001,-33.716660000000005],[-70.72667000000001,-33.71855],[-70.72781,-33.72101],[-70.72994,-33.725280000000005],[-70.73196,-33.72927],[-70.73529,-33.735820000000004],[-70.73737000000001,-33.74009],[-70.73829,-33.74327],[-70.73941,-33.74805],[-70.74010000000001,-33.75112],[-70.74087,-33.755860000000006],[-70.74264000000001,-33.766580000000005],[-70.74459,-33.77854],[-70.74956,-33.808490000000006],[-70.75317000000001,-33.830600000000004],[-70.75338,-33.83214],[-70.75332,-33.832950000000004],[-70.75258000000001,-33.836020000000005],[-70.75013000000001,-33.84619],[-70.74812,-33.85483],[-70.74775000000001,-33.85882],[-70.74747,-33.859930000000006],[-70.74714,-33.860530000000004],[-70.74559,-33.86205],[-70.74256000000001,-33.864630000000005],[-70.74225000000001,-33.86504],[-70.74162000000001,-33.866400000000006],[-70.73767000000001,-33.87892],[-70.73646000000001,-33.882830000000006],[-70.73521000000001,-33.89139],[-70.73433,-33.89715],[-70.7342,-33.89875],[-70.73433,-33.900110000000005],[-70.73464,-33.90117],[-70.73494000000001,-33.9024],[-70.73491,-33.90312],[-70.73447,-33.9044],[-70.7338,-33.905300000000004],[-70.7316,-33.90742],[-70.72821,-33.910520000000005],[-70.72563000000001,-33.912980000000005],[-70.72495,-33.914010000000005],[-70.72465000000001,-33.915200000000006],[-70.72474000000001,-33.91695],[-70.72512,-33.91903],[-70.72499,-33.92004],[-70.72476,-33.92063],[-70.72375000000001,-33.921980000000005],[-70.72003000000001,-33.92443],[-70.71888000000001,-33.92531],[-70.71801,-33.926230000000004],[-70.71696,-33.92815],[-70.71639,-33.929280000000006],[-70.7146,-33.932930000000006],[-70.71262,-33.93721],[-70.71238000000001,-33.93871],[-70.71215000000001,-33.94205],[-70.71198000000001,-33.94505],[-70.71237,-33.94736],[-70.71347,-33.951950000000004],[-70.71355000000001,-33.953100000000006],[-70.71339,-33.954240000000006],[-70.7128,-33.956050000000005],[-70.71075,-33.96125],[-70.70649,-33.97233],[-70.70306000000001,-33.98106],[-70.70231000000001,-33.98306],[-70.70101000000001,-33.98695],[-70.70108,-33.990210000000005],[-70.70138,-33.99398],[-70.70248000000001,-34.00489],[-70.70370000000001,-34.0168],[-70.70508000000001,-34.03051],[-70.7056,-34.03401],[-70.70632,-34.0356],[-70.70718000000001,-34.03661],[-70.70819,-34.03743],[-70.71049000000001,-34.03851],[-70.71324,-34.03947],[-70.71443000000001,-34.0399],[-70.71855000000001,-34.04139],[-70.72498,-34.04366],[-70.72658000000001,-34.04424],[-70.72958000000001,-34.04589],[-70.73288000000001,-34.04787],[-70.73613,-34.04981],[-70.73817000000001,-34.050790000000006],[-70.74669,-34.053540000000005],[-70.74894,-34.054460000000006],[-70.7505,-34.05547],[-70.75157,-34.056400000000004],[-70.75330000000001,-34.058690000000006],[-70.7557,-34.06271],[-70.7596,-34.0689],[-70.76164,-34.0718],[-70.76251,-34.07285],[-70.77195,-34.082770000000004],[-70.77406,-34.08532],[-70.77484000000001,-34.086960000000005],[-70.77689000000001,-34.09313],[-70.77860000000001,-34.09843],[-70.77962000000001,-34.10177],[-70.77992,-34.10418],[-70.78034000000001,-34.11188],[-70.78066000000001,-34.11723],[-70.78153,-34.12163],[-70.78331,-34.12896],[-70.78548,-34.13819],[-70.78695,-34.14426],[-70.78772000000001,-34.146460000000005],[-70.78893000000001,-34.149010000000004],[-70.79144000000001,-34.15428],[-70.79272,-34.157050000000005],[-70.79346000000001,-34.15926],[-70.79390000000001,-34.16143],[-70.79408000000001,-34.164910000000006],[-70.79404000000001,-34.165620000000004],[-70.79341000000001,-34.16919],[-70.78959,-34.182950000000005],[-70.78775,-34.18938],[-70.78539,-34.198260000000005],[-70.78503,-34.201010000000004],[-70.78487000000001,-34.20563],[-70.78507,-34.20819],[-70.78589000000001,-34.211240000000004],[-70.7881,-34.21587],[-70.79247000000001,-34.22477],[-70.79312,-34.22668],[-70.79321,-34.22894],[-70.79282,-34.23067],[-70.79212000000001,-34.232530000000004],[-70.79194000000001,-34.234120000000004],[-70.79205,-34.23509],[-70.79303,-34.237320000000004],[-70.79461,-34.24015],[-70.79574000000001,-34.2421],[-70.79857000000001,-34.24707],[-70.80594,-34.26001],[-70.81633000000001,-34.27806],[-70.82137,-34.28689],[-70.82215000000001,-34.28857],[-70.82249,-34.29023],[-70.82352,-34.29544],[-70.82645000000001,-34.30995],[-70.82979,-34.32001],[-70.83322000000001,-34.330270000000006],[-70.83510000000001,-34.335890000000006],[-70.83575,-34.33744],[-70.83958000000001,-34.3442],[-70.84298000000001,-34.35015],[-70.84688,-34.35692],[-70.85213,-34.36607],[-70.87008,-34.397310000000004],[-70.87209,-34.40068],[-70.87319000000001,-34.40236],[-70.87364000000001,-34.40238],[-70.87387000000001,-34.402060000000006],[-70.87373000000001,-34.401810000000005],[-70.872,-34.401810000000005],[-70.86663,-34.40241],[-70.86243,-34.40279],[-70.85940000000001,-34.403040000000004],[-70.85891000000001,-34.40249],[-70.85822,-34.401590000000006],[-70.85865000000001,-34.401680000000006],[-70.85896000000001,-34.40178],[-70.85932000000001,-34.40193],[-70.85999000000001,-34.40195],[-70.8602,-34.401920000000004],[-70.86052000000001,-34.402370000000005],[-70.86080000000001,-34.402860000000004],[-70.85961,-34.403020000000005],[-70.85802000000001,-34.40319],[-70.85725000000001,-34.4033],[-70.85693,-34.403380000000006],[-70.85761000000001,-34.40424],[-70.85888,-34.405640000000005],[-70.85955,-34.406600000000005],[-70.8583,-34.40697],[-70.85414,-34.40818],[-70.85308,-34.408530000000006],[-70.85332000000001,-34.409400000000005],[-70.85340000000001,-34.409710000000004],[-70.85372000000001,-34.41085],[-70.85381000000001,-34.41107]],"estimatedDistance":117764,"startLocation":{"lat":-33.532782,"lon":-70.7812735,"loc":[-70.7812735,-33.532782],"placeId":null,"stopId":"654054d62d5b0119311ae116","referencePoint":true},"endLocation":{"lat":-34.4111,"lon":-70.8537,"loc":[-70.8537,-34.4111],"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"placeWaitTime":0,"reason":"","linkedDeparture":null,"linkedDepartures":[],"reservationsToLink":[],"cabify":{"productId":null},"asap":false,"isEmergency":false,"isPastService":false,"communityId":"","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","serviceHour":"2025-07-17T19:00:00.627Z","placeName":"Hospital Rengo","placeLongName":"Hospital Rengo","hourIsDepartureOrArrival":"departure","roundedDistance":"117.76","travelTime":6003,"originalEstimatedArrival":"","originalServiceDate":"","originalTravelTime":6003,"adjustmentFactor":1,"totalReservations":3}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${rddId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddId}
    ${json}=    Set Variable    ${response.json()}

      # Validar que el estado sea pendingDriverAssignment
    Should Be Equal As Strings    ${json}[state]    pendingDriverAssignment
    ...    msg=❌ Expected state to be 'pendingDriverAssignment' but got '${json}[state]'

    # Validar que oddType sea el correcto
    Should Be Equal As Strings    ${json}[oddType]    Taxis Coni y Nico
    ...    msg=❌ Expected oddType to be 'Taxis Coni y Nico' but got '${json}[oddType]'

    # Validar que isLimitedODD esté vacío o no definido
    Run Keyword And Ignore Error    Should Not Contain    ${json}    isLimitedODD

    # Validar que sharing esté activado
    Should Be True    ${json}[sharing]
    ...    msg=❌ Sharing should be enabled

    # Validar que restrictPassengers.enabled esté en false
    
    ${reservationLenght}=    Get Length    ${response.json()}[reservations]
    # Validar cantidad de reservas (3 en este caso)
    Length Should Be    ${json}[reservations]    3
    ...    msg=❌ Expected 3 reservations but found ${reservationLenght}
    # Validar estado histórico
    Should Be Equal As Strings    ${json}[stateHistory][0][state]    created
    Should Be Equal As Strings    ${json}[stateHistory][1][state]    pendingDriverAssignment
    ...    msg=❌ Unexpected states in stateHistory

    # Validar estimatedDistance no sea 0
    Should Not Be Equal As Integers    ${json}[estimatedDistance]    0
    ...    msg=❌ Estimated distance should not be 0

Login User With Email(Obtain Token)
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




Assign Driver
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/assignDriver/${rddId}?community=${idComunidad}
    ...    data={"driver":{"driverId":"${driverId}","driverCode":"${driverCode}"},"drivers":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
Assign Vehicle
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/assignVehicle/${rddId}?community=${idComunidad}
    ...    data={"vehicleId":"${vehicleId}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

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

Driver Accept Service
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/acceptOrReject/${rddId}
    ...    data={"state":"accepted"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
Start Departure 
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/oddepartures/start/${rddId}
    ...    data={"startLat":"-33.41952308267422","startLon":"-70.6314178632461"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken}
    Log    ${code}
     Set Global Variable    ${departureToken}


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



Get Current Time
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/currentTime

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${departureToken}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
Get RDD Stops As Driver
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/oddepartures/stops/${rddId}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenDriver}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

Validate With QR(Kratos)
    Set Log Level    TRACE

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeKratos}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}


Action On Stop 2
    [Documentation]    The "Complete Stop" button should set the current reservation to "done" and leave the remaining reservations in "pending"
    Set Log Level    TRACE

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/oddepartures/action/653ffde9f90509541a749e18
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    ${json}=    Set Variable    ${response.json()}

    ${reservations}=    Set Variable    ${json}[reservations]

    ${reserva_order_0}=    Evaluate    [r for r in ${reservations} if r["order"] == 0][0]
    Should Be Equal As Strings    ${reserva_order_0}[state]    done
    ...    msg=❌ La reserva con order 0 debería estar en estado "done" pero está en "${reserva_order_0}[state]}"

    ${reserva_order_1}=    Evaluate    [r for r in ${reservations} if r["order"] == 1][0]
    Should Be Equal As Strings    ${reserva_order_1}[state]    done
    ...    msg=❌ La reserva con order 1 debería estar en estado "done" pero está en "${reserva_order_1}[state]}"

    ${reserva_order_2}=    Evaluate    [r for r in ${reservations} if r["order"] == 2][0]
    Should Be Equal As Strings    ${reserva_order_2}[state]    pending
    ...    msg=❌ La reserva con order 2 debería estar en estado "pending" pero está en "${reserva_order_2}[state]}"


Validate With QR(Nico)
    Set Log Level    TRACE

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeNico}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}


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

Get Stadistics
    [Documentation]    The number of reservations with status "done" should be 3, and there should be 2 validations
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/departure/end/statistics/${rddId}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenDriver}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.content}

    ${json}=    Set Variable    ${response.json()}

    Should Be Equal As Integers    ${json["reservationsInDone"]}    3
    ...    msg=Expected 3 reservations in 'done' state, but got ${json["reservationsInDone"]}

    Should Be Equal As Integers    ${json["validations"]}    2
    ...    msg=Expected 2 validation, but got ${json["validations"]}