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

Time + 2 Hour
    ${date}    Get Current Date    time_zone=UTC    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    2 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Get Next Monday At 14 CLT (UTC 18)
    # Obtener fecha actual en UTC
    ${now}=    Get Current Date    time_zone=UTC

    # Obtener día actual de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
    ${weekday}=    Convert Date    ${now}    result_format=%w
    ${weekday}=    Convert To Integer    ${weekday}

    # Calcular días hasta el próximo lunes
    ${days_until_monday}=    Evaluate    (8 - ${weekday}) if ${weekday} != 1 else 7

    # Sumar días para obtener el próximo lunes
    ${next_monday}=    Add Time To Date    ${now}    ${days_until_monday} days
    Set Global Variable    ${next_monday}

    # Obtener solo la fecha y combinarla con hora 18:00:00 UTC (14:00 hora Chile UTC-4)
    ${next_monday_date}=    Convert Date    ${next_monday}    result_format=%Y-%m-%d
    ${next_monday_at_18}=    Set Variable    ${next_monday_date}T18:00:00.000000Z

    Log    Próximo lunes a las 14:00 CLT (UTC 18:00): ${next_monday_at_18}
    Set Global Variable    ${next_monday_at_18}
    Set Global Variable    ${next_monday_date}

Get Next 4 Mondays At 14 CLT (UTC 18)
    # Obtener fecha actual en UTC
    ${now}=    Get Current Date    time_zone=UTC
    ${weekday}=    Convert Date    ${now}    result_format=%w
    ${weekday}=    Convert To Integer    ${weekday}
    ${days_until_monday}=    Evaluate    (8 - ${weekday}) if ${weekday} != 1 else 7
    ${first_monday}=    Add Time To Date    ${now}    ${days_until_monday} days

    # Lunes 1
    ${monday1_date}=    Convert Date    ${first_monday}    result_format=%Y-%m-%d
    ${next_monday_1_at_18}=    Set Variable    ${monday1_date}T18:00:00.000000Z
    Set Global Variable    ${next_monday_1_at_18}    ${next_monday_1_at_18}
    Log    Lunes 1: ${next_monday_1_at_18}

    # Lunes 2
    ${monday2}=    Add Time To Date    ${first_monday}    7 days
    ${monday2_date}=    Convert Date    ${monday2}    result_format=%Y-%m-%d
    ${next_monday_2_at_18}=    Set Variable    ${monday2_date}T18:00:00.000000Z
    Set Global Variable    ${next_monday_2_at_18}    ${next_monday_2_at_18}
    Log    Lunes 2: ${next_monday_2_at_18}

    # Lunes 3
    ${monday3}=    Add Time To Date    ${first_monday}    14 days
    ${monday3_date}=    Convert Date    ${monday3}    result_format=%Y-%m-%d
    ${next_monday_3_at_18}=    Set Variable    ${monday3_date}T18:00:00.000000Z
    Set Global Variable    ${next_monday_3_at_18}    ${next_monday_3_at_18}
    Log    Lunes 3: ${next_monday_3_at_18}

    # Lunes 4
    ${monday4}=    Add Time To Date    ${first_monday}    21 days
    ${monday4_date}=    Convert Date    ${monday4}    result_format=%Y-%m-%d
    ${next_monday_4_at_18}=    Set Variable    ${monday4_date}T18:00:00.000000Z
    Set Global Variable    ${next_monday_4_at_18}    ${next_monday_4_at_18}
    Log    Lunes 4: ${next_monday_4_at_18}


Get Next Wednesday At 14 CLT (UTC 18)
    # Obtener fecha actual en UTC
    ${now}=    Get Current Date    time_zone=UTC

    # Obtener día actual de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
    ${weekday}=    Convert Date    ${now}    result_format=%w
    ${weekday}=    Convert To Integer    ${weekday}

    # Calcular días hasta el próximo miércoles (3)
    ${days_until_wednesday}=    Evaluate    (10 - ${weekday}) if ${weekday} != 3 else 7

    # Sumar días para obtener el próximo miércoles
    ${next_wednesday}=    Add Time To Date    ${now}    ${days_until_wednesday} days

    # Obtener solo la fecha y combinarla con hora 18:00:00 UTC (14:00 hora Chile UTC-4)
    ${next_wednesday_date}=    Convert Date    ${next_wednesday}    result_format=%Y-%m-%d
    ${next_wednesday_at_18}=    Set Variable    ${next_wednesday_date}T18:00:00.000000Z

    Log    Próximo miércoles a las 14:00 CLT (UTC 18:00): ${next_wednesday_at_18}
    Set Global Variable    ${next_wednesday_at_18}

Get Next Thursday At 18 CLT (UTC 22)
    # Obtener fecha actual en UTC
    ${now}=    Get Current Date    time_zone=UTC

    # Obtener día actual de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
    ${weekday}=    Convert Date    ${now}    result_format=%w
    ${weekday}=    Convert To Integer    ${weekday}

    # Calcular días hasta el próximo jueves (4)
    ${days_until_thursday}=    Evaluate    (11 - ${weekday}) if ${weekday} != 5 else 7

    # Sumar días para obtener el próximo jueves
    ${next_thursday}=    Add Time To Date    ${now}    ${days_until_thursday} days

    # Obtener solo la fecha y combinarla con hora 22:00:00 UTC (18:00 hora Chile UTC-4)
    ${next_thursday_date}=    Convert Date    ${next_thursday}    result_format=%Y-%m-%d
    ${next_thursday_at_22}=    Set Variable    ${next_thursday_date}T22:00:00.000000Z

    Log    Próximo jueves a las 18:00 CLT (UTC 22:00): ${next_thursday_at_22}
    Set Global Variable    ${next_thursday_at_22}

Login User With Email(Obtain Token)
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+limitadanico@allrideapp.com","password":"Lolowerty21@"}
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


Get Providers (Should be two)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"6852fa6a402dddfa16b72eee","stopId":"6862e536e036e36d0ebc80c3","lat":"-34.40302280653645","lon":"-70.83805069327354","loc":["-70.83805069327354","-34.40302280653645"],"address":"Dirección personalizada Los Césares 905Rengo, Chile","isUserStop":true},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/providers/6654ae4eba54fe502d4e4187
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    # Length Should Be   ${response.json()}    2 



Create ODD Limited As User(Restricted:userLocation)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"6852fa6a402dddfa16b72eee","stopId":"6862e536e036e36d0ebc80c3","lat":"-34.40302280653645","lon":"-70.83805069327354","loc":["-70.83805069327354","-34.40302280653645"],"address":"Dirección personalizada Los Césares 905Rengo, Chile","isUserStop":true},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico","comments":"","serviceDate":"${next_monday_at_18}","name":"Solicitud Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=    Set Variable    ${response.json()}

    ${oddId}=   Set Variable     ${json}[_id]
    Set Global Variable    ${oddId}

    # Verifica que el estado del ODD sea "waitingForCreation"
    Should Be Equal As Strings    ${json}[state]    waitingForCreation
    ...    msg=❌ Expected state to be 'waitingForCreation' but got '${json}[state]'

    # Verifica que el tipo de ODD sea "Limitada Nico"
    Should Be Equal As Strings    ${json}[oddType]    Limitada Nico
    ...    msg=❌ Expected oddType to be 'Limitada Nico' but got '${json}[oddType]'

    # Verifica que isLimited en oDDInfo sea True
    Should Be True    ${json}[oDDInfo][isLimited]
    ...    msg=❌ Expected oDDInfo.isLimited to be True but got ${json}[oDDInfo][isLimited]

    # Verifica que isLimitedODD esté en True
    Should Be True    ${json}[isLimitedODD]
    ...    msg=❌ Expected isLimitedODD to be True but got ${json}[isLimitedODD]

    # Verifica que haya una sola reserva

    # Verifica que la reserva no esté validada
    Should Be Equal As Strings    ${json}[reservations][0][validated]    False
    ...    msg=❌ Reservation should not be validated

    # Verifica que joined sea False
    Should Be Equal As Strings    ${json}[reservations][0][joined]    False
    ...    msg=❌ Reservation should not be joined

    # Verifica que approvedByDriver sea True
    Should Be Equal As Strings    ${json}[reservations][0][approvedByDriver]    True
    ...    msg=❌ Reservation should be approved by driver

    # Verifica que stopId exista en la reserva
    Should Contain    ${json}[reservations][0]    stopId
    ...    msg=❌ Reservation is missing stopId

    # Verifica que placeId en endLocation no sea null
    Should Not Be Empty    ${json}[endLocation][placeId]
    ...    msg=❌ placeId in endLocation should not be null

    # Verifica que isLimited en endLocation sea True
    Should Be True    ${json}[endLocation][isLimited]
    ...    msg=❌ endLocation.isLimited should be True but got ${json}[endLocation][isLimited]

    # Verifica que el startLocation tenga referencePoint en True
    Should Be True    ${json}[startLocation][referencePoint]
    ...    msg=❌ startLocation.referencePoint should be True but got ${json}[startLocation][referencePoint]

Create Same ODD Limited As User(Should Fail 409)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"6852fa6a402dddfa16b72eee","stopId":"6862e536e036e36d0ebc80c3","lat":"-34.40302280653645","lon":"-70.83805069327354","loc":["-70.83805069327354","-34.40302280653645"],"address":"Dirección personalizada Los Césares 905Rengo, Chile","isUserStop":true},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico","comments":"","serviceDate":"${next_monday_at_18}","name":"Solicitud Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  Run Keyword And Expect Error     HTTPError: 409 Client Error: Conflict for url: https://stage.allrideapp.com/api/v1/pb/user/oddepartures/6654ae4eba54fe502d4e4187  Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Create Limited ODD (Invalid day outside allowed configuration, should Fail 410)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"6852fa6a402dddfa16b72eee","stopId":"6862e536e036e36d0ebc80c3","lat":"-34.40302280653645","lon":"-70.83805069327354","loc":["-70.83805069327354","-34.40302280653645"],"address":"Dirección personalizada Los Césares 905Rengo, Chile","isUserStop":true},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico","comments":"","serviceDate":"${next_wednesday_at_18}","name":"Solicitud Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=     Run Keyword And Expect Error   HTTPError: 410 Client Error: Gone for url: https://stage.allrideapp.com/api/v1/pb/user/oddepartures/6654ae4eba54fe502d4e4187    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Create Limited ODD (Invalid origin stop outside allowed configuration, should Fail 409)
    [Documentation]    Debe fallar con error 410 al crear RDD sin parada de usuario como origen
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"6654d4c8713b9a5184cfe1de","stopId":"6654d4c8713b9a5184cfe1df","lat":"-34.396547","lon":"-70.781935","loc":["-70.781935","-34.396547"],"address":"Media luna cerrillos","isUserStop":false},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico","comments":"","serviceDate":"${next_monday_at_18}","name":"Solicitud Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  Run Keyword And Expect Error     HTTPError: 409 Client Error: Conflict for url: https://stage.allrideapp.com/api/v1/pb/user/oddepartures/6654ae4eba54fe502d4e4187  Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Process ODD (CI Table)
    Set Log Level    TRACE
    [Documentation]    Procesar RDD
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"superCommunityId":"68542c2a3a0d319ed31a72a6","adminId":"66d75c62a1b7bc9a1dd231c6","adminName":"Soporte AllRide","oddSimpleFlow":false,"state":"pendingDriverAssignment","name":"Solicitud de Limitada Nico","oddType":"Limitada Nico","placeLat":-34.4111,"placeLon":-70.8537,"serviceCost":0,"calculatedCosts":{},"apportionByParams":[],"direction":"in","comments":"","serviceDate":"${next_monday_date}T17:55:21.000Z","extraMinutes":0,"estimatedArrival":"${next_monday_at_18}","reservations":[{"manuallyBooked":true,"userId":"6862e490e036e36d0ebc7dc4","stopId":"6862e536e036e36d0ebc80c3","placeId":null,"order":0,"estimatedArrival":"${next_monday_date}T17:55:21.000Z","distances":{"fromPrevious":0,"toNext":1993,"distanceToLocation":1993,"pctToLocation":1}}],"waypoints":[[-70.83805000000001,-34.40301],[-70.84125,-34.4025],[-70.84184,-34.402390000000004],[-70.84241,-34.40229],[-70.84303,-34.402260000000005],[-70.84376,-34.40229],[-70.84433,-34.402390000000004],[-70.84458000000001,-34.402440000000006],[-70.84540000000001,-34.402640000000005],[-70.8456,-34.402680000000004],[-70.84599,-34.40272],[-70.84715,-34.40279],[-70.84736000000001,-34.402800000000006],[-70.84736000000001,-34.40283],[-70.84737000000001,-34.4029],[-70.84742,-34.40297],[-70.84789,-34.40336],[-70.84813000000001,-34.40353],[-70.84913,-34.404270000000004],[-70.85003,-34.40502],[-70.85045000000001,-34.405460000000005],[-70.85126000000001,-34.406200000000005],[-70.85182,-34.40679],[-70.85251000000001,-34.4076],[-70.85308,-34.408530000000006],[-70.85337000000001,-34.409600000000005],[-70.85367000000001,-34.410720000000005],[-70.85381000000001,-34.41107]],"estimatedDistance":1993,"startLocation":{"lat":-34.40302280653645,"lon":-70.83805069327354,"loc":[-70.83805069327354,-34.40302280653645],"placeId":null,"stopId":"6862e536e036e36d0ebc80c3"},"endLocation":{"lat":-34.4111,"lon":-70.8537,"loc":[-70.8537,-34.4111],"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","referencePoint":true},"placeWaitTime":0,"linkedDeparture":"${oddId}","linkedDepartures":[],"reservationsToLink":[{"userId":"6862e490e036e36d0ebc7dc4","departureId":"${oddId}"}],"cabify":{"productId":null},"asap":false,"isEmergency":false,"isPastService":false,"communityId":"6654ae4eba54fe502d4e4187","serviceHour":"","placeName":"Hospital Rengo","placeLongName":"Hospital Rengo","hourIsDepartureOrArrival":"arrival","roundedDistance":"1.99","travelTime":279,"originalEstimatedArrival":"","originalServiceDate":"","originalTravelTime":279,"adjustmentFactor":1,"totalReservations":1,"arrivalDate":"${next_monday_at_18}"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=       Post On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd?community=6654ae4eba54fe502d4e4187
    ...    json=${parsed_json}
    ...    headers=${headers}
    
    ${json}=    Set Variable    ${response.json()}
    ${oddId_procceced}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${oddId_procceced}

      # Estado actual debe ser 'pendingDriverAssignment'
    Should Be Equal As Strings    ${json}[state]    pendingDriverAssignment
    ...    msg=❌ Expected state to be 'pendingDriverAssignment' but got '${json}[state]'


    # La reserva fue creada manualmente
    Should Be True    ${json}[reservations][0][manuallyBooked]
    ...    msg=❌ Reservation must be marked as manually booked

    # La reserva fue aprobada por el conductor
    Should Be True    ${json}[reservations][0][approvedByDriver]
    ...    msg=❌ Reservation must be approved by driver

    # oddType debe ser 'Limitada Nico'
    Should Be Equal As Strings    ${json}[oddType]    Limitada Nico
    ...    msg=❌ Expected oddType to be 'Limitada Nico' but got '${json}[oddType]'

    # Verifica que haya coordenadas en waypoints
    Should Not Be Empty    ${json}[waypoints][coordinates]
    ...    msg=❌ Expected non-empty waypoints coordinates

    # Verifica que estimatedDistance no sea 0
    Should Not Be Equal As Numbers    ${json}[estimatedDistance]    0
    ...    msg=❌ estimatedDistance should not be 0

    # Validar que el adminId no esté vacío
    Should Not Be Empty    ${json}[adminId]
    ...    msg=❌ adminId should not be empty

    # Primer estado debe ser 'created'
    Should Be Equal As Strings    ${response.json()}[stateHistory][0][state]    created
    ...    msg=❌ First state should be 'created' but got '${json}[stateHistory][0][state]'

    # Segundo estado debe ser 'pendingDriverAssignment'
    Should Be Equal As Strings    ${response.json()}[stateHistory][1][state]    pendingDriverAssignment
    ...    msg=❌ Second state should be 'pendingDriverAssignment' but got '${json}[stateHistory][1][state]'

    # Verifica que ambos estados tengan adminId
    Should Not Be Empty    ${response.json()}[stateHistory][0][adminId]
    ...    msg=❌ First state missing adminId

    Should Not Be Empty    ${response.json()}[stateHistory][1][adminId]
    ...    msg=❌ Second state missing adminId

Cancel ODD from admin

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)https://stage.allrideapp.com/api/v1/admin/pb/odd/cancel/6863ff704193d3bf454699e1?community=6654ae4eba54fe502d4e4187
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/cancel/${oddId}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=   Set Variable    ${response.json()}
    
    # Verifica que el estado final sea "canceled"
    Should Be Equal As Strings    ${json}[state]    canceled
    ...    msg=❌ Expected state to be 'canceled' but got '${json}[state]'

    # Verifica que isLimited esté en True dentro de oDDInfo
    Should Be True    ${json}[oDDInfo][isLimited]
    ...    msg=❌ oDDInfo.isLimited should be True but got ${json}[oDDInfo][isLimited]

    # Verifica que isLimitedODD también esté en True
    Should Be True    ${json}[isLimitedODD]
    ...    msg=❌ isLimitedODD should be True but got ${json}[isLimitedODD]

    # Verifica que la reserva no esté validada
    Should Be Equal As Strings    ${json}[reservations][0][validated]    False
    ...    msg=❌ Reservation should not be validated

    # Verifica que la reserva no esté unida (joined=False)
    Should Be Equal As Strings    ${json}[reservations][0][joined]    False
    ...    msg=❌ Reservation should not be joined

    # Verifica que approvedByDriver sea True
    Should Be Equal As Strings    ${json}[reservations][0][approvedByDriver]    True
    ...    msg=❌ Reservation should be approved by driver

    # Verifica que el stopId exista en la reserva
    Should Contain    ${json}[reservations][0]    stopId
    ...    msg=❌ Reservation is missing stopId

    # Verifica que el placeId en endLocation no sea null
    Should Not Be Empty    ${json}[endLocation][placeId]
    ...    msg=❌ placeId in endLocation should not be null

    # Verifica que endLocation esté marcado como limitado
    Should Be True    ${json}[endLocation][isLimited]
    ...    msg=❌ endLocation.isLimited should be True but got ${json}[endLocation][isLimited]

    # Verifica que startLocation tenga referencePoint=True
    Should Be True    ${json}[startLocation][referencePoint]
    ...    msg=❌ startLocation.referencePoint should be True but got ${json}[startLocation][referencePoint]

Cancel new ODD from admin

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)https://stage.allrideapp.com/api/v1/admin/pb/odd/cancel/6863ff704193d3bf454699e1?community=6654ae4eba54fe502d4e4187
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/cancel/${oddId_procceced}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=   Set Variable    ${response.json()}


#------------------------Combinación de paradas--------------------------------#

Create ODD Limited As User(multiple dates) correct stop, should pass
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"asap":false,"direction":"","endLocation":{"address":"Hospital Rengo Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"multipleRequests":[{"isEmergency":false,"isExclusive":false,"selectedLabels":["Acercamiento a parada de origen Troncal"],"serviceDate":"${next_monday_1_at_18}"},{"isEmergency":false,"isExclusive":false,"selectedLabels":["Acercamiento a parada de origen Troncal"],"serviceDate":"${next_monday_2_at_18}"},{"isEmergency":false,"isExclusive":false,"selectedLabels":["Acercamiento a parada de origen Troncal"],"serviceDate":"${next_monday_3_at_18}"},{"isEmergency":false,"isExclusive":false,"selectedLabels":["Acercamiento a parada de origen Troncal"],"serviceDate":"${next_monday_4_at_18}"}],"name":"Reserva de nico places","oddType":"Limitada Nico","startLocation":{"address":"Dirección personalizada Diego de Almagro 430 Rancagua, Chile","isUserStop":true,"lat":"-34.17303901547532","loc":["-34.17303901547532","-70.72759497910738"],"lon":"-70.72759497910738","placeId":"686545116a2451384d1f630d"}}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
  
    ${json}=    Set Variable    ${response.json()}
    ${odd_1}=    Set Variable     ${json}[0][_id]
    ${odd_2}=    Set Variable     ${json}[1][_id]
    ${odd_3}=    Set Variable     ${json}[2][_id]
    ${odd_4}=    Set Variable     ${json}[3][_id]

    Set Global Variable    ${odd_1}
    Set Global Variable    ${odd_2}
    Set Global Variable    ${odd_3}
    Set Global Variable    ${odd_4}

    FOR    ${odd}    IN    @{json}
        ${odd_id}=    Get From Dictionary    ${odd}    _id
        ${state}=     Get From Dictionary    ${odd}    state
        ${history}=   Get From Dictionary    ${odd}    stateHistory
        ${states}=    Create List
        FOR    ${item}    IN    @{history}
            ${status}=    Get From Dictionary    ${item}    state
            Append To List    ${states}    ${status}
        END
        ${reservas}=    Get From Dictionary    ${odd}    reservations
        ${reserva_1}=   Get From List    ${reservas}    0
        ${reserva_id}=  Get From Dictionary    ${reserva_1}    _id

        Should Be Equal As Strings    ${state}    waitingForCreation
        ...    msg=❌ ODD ${odd_id}: estado incorrecto, se esperaba 'waitingForCreation' y se obtuvo '${state}'
        Should Contain    ${states}    created
        ...    msg=❌ ODD ${odd_id}: no contiene estado 'created' en stateHistory
        Should Contain    ${states}    waitingForCreation
        ...    msg=❌ ODD ${odd_id}: no contiene estado 'waitingForCreation' en stateHistory
        Should Not Be Empty    ${reserva_id}
        ...    msg=❌ ODD ${odd_id}: la reserva no tiene _id
        Log To Console    ✅ Validación completada para ODD ${odd_id}
    END
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

##Cancel ODD multiple stops and stopsId
Create ODD Limited As User(multiple dates) same request, should fail 409
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"asap":false,"direction":"","endLocation":{"address":"Hospital Rengo Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"multipleRequests":[{"isEmergency":false,"isExclusive":false,"selectedLabels":["Acercamiento a parada de origen Troncal"],"serviceDate":"${next_monday_1_at_18}"},{"isEmergency":false,"isExclusive":false,"selectedLabels":["Acercamiento a parada de origen Troncal"],"serviceDate":"${next_monday_2_at_18}"},{"isEmergency":false,"isExclusive":false,"selectedLabels":["Acercamiento a parada de origen Troncal"],"serviceDate":"${next_monday_3_at_18}"},{"isEmergency":false,"isExclusive":false,"selectedLabels":["Acercamiento a parada de origen Troncal"],"serviceDate":"${next_monday_4_at_18}"}],"name":"Reserva de nico places","oddType":"Limitada Nico","startLocation":{"address":"Dirección personalizada Diego de Almagro 430 Rancagua, Chile","isUserStop":true,"lat":"-34.17303901547532","loc":["-34.17303901547532","-70.72759497910738"],"lon":"-70.72759497910738","placeId":"686545116a2451384d1f630d"}}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  Run Keyword And Expect Error     HTTPError: 409 Client Error: Conflict for url: https://stage.allrideapp.com/api/v1/pb/user/oddepartures/6654ae4eba54fe502d4e4187    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

#Verificar odds compatibles para procesar, en este caso deberían ser las 4 que se crearon, siempre y cuando tengan estado por procesar

Check compatible limited odd
    skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/compatibleLimitedODDs/?community=6654ae4eba54fe502d4e4187&startLocation=null&endLocation=6654d4acba54fe502d4e6b6b&oddType=Limitada%20Nico&oddDirection=in&departureOrArrival=arrival&serviceDate=${next_monday_1_at_18}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Length Should Be    ${response}    1
    ...    msg=❌ Expected only one matching ODD. More than one was found, which means services that shouldn't apply are being included.

    ${json}=    Set Variable    ${response.json()}
    
    # Verifica que el estado actual sea 'waitingForCreation'
    Should Be Equal As Strings    ${json}[state]    waitingForCreation
    ...    msg=❌ Se esperaba estado 'waitingForCreation' pero se obtuvo '${json}[state]'

    # Verifica que el tipo de ODD sea 'Limitada Nico'
    Should Be Equal As Strings    ${json}[oddType]    Limitada Nico
    ...    msg=❌ Se esperaba oddType 'Limitada Nico' pero se obtuvo '${json}[oddType]'

    # Verifica que isLimited en oDDInfo sea True
    Should Be True    ${json}[oDDInfo][isLimited]
    ...    msg=❌ Se esperaba oDDInfo.isLimited en True pero se obtuvo ${json}[oDDInfo][isLimited]

    # Verifica que isLimitedODD esté en True
    Should Be True    ${json}[isLimitedODD]
    ...    msg=❌ Se esperaba isLimitedODD en True pero se obtuvo ${json}[isLimitedODD]

    # Verifica que haya una sola reserva
    Length Should Be    ${json}[reservations]    1
    ...    msg=❌ Se esperaba 1 reserva pero se encontró ${len(${json}[reservations])}

    # Verifica que la reserva no esté validada
    Should Be Equal As Strings    ${json}[reservations][0][validated]    False
    ...    msg=❌ La reserva no debería estar validada

    # Verifica que joined sea False
    Should Be Equal As Strings    ${json}[reservations][0][joined]    False
    ...    msg=❌ La reserva no debería estar unida (joined = False)

    # Verifica que approvedByDriver sea True
    Should Be True    ${json}[reservations][0][approvedByDriver]
    ...    msg=❌ La reserva debería estar aprobada por el conductor

    # Verifica que el usuario venga con nombre
    Should Not Be Empty    ${json}[reservations][0][userId][name]
    ...    msg=❌ Se esperaba un nombre de usuario en userId.name

    # Verifica que el stopId exista en la reserva
    Should Contain    ${json}[reservations][0]    stopId
    ...    msg=❌ La reserva no contiene stopId

    # Verifica que placeId en endLocation no sea null
    Should Not Be Empty    ${json}[endLocation][placeId]
    ...    msg=❌ placeId en endLocation no debería estar vacío

    # Verifica que isLimited en endLocation sea True
    Should Be True    ${json}[endLocation][isLimited]
    ...    msg=❌ endLocation.isLimited debería ser True pero se obtuvo ${json}[endLocation][isLimited]

    # Verifica que el startLocation tenga referencePoint en True
    Should Be True    ${json}[startLocation][referencePoint]
    ...    msg=❌ startLocation.referencePoint debería ser True pero se obtuvo ${json}[startLocation][referencePoint]

    # Validaciones del stateHistory
    Length Should Be    ${json}[stateHistory]    2
    ...    msg=❌ El historial de estados debería tener 2 entradas

    Should Be Equal As Strings    ${json}[stateHistory][0][state]    created
    ...    msg=❌ El primer estado debería ser 'created' pero fue '${json}[stateHistory][0][state]'

    Should Be Equal As Strings    ${json}[stateHistory][1][state]    waitingForCreation
    ...    msg=❌ El segundo estado debería ser 'waitingForCreation' pero fue '${json}[stateHistory][1][state]'

Cancel ODD from admin (multiple1)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)https://stage.allrideapp.com/api/v1/admin/pb/odd/cancel/6863ff704193d3bf454699e1?community=6654ae4eba54fe502d4e4187
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/cancel/${odd_1}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
Cancel ODD from admin (multiple2)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)https://stage.allrideapp.com/api/v1/admin/pb/odd/cancel/6863ff704193d3bf454699e1?community=6654ae4eba54fe502d4e4187
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/cancel/${odd_2}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
Cancel ODD from admin (multiple3)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)https://stage.allrideapp.com/api/v1/admin/pb/odd/cancel/6863ff704193d3bf454699e1?community=6654ae4eba54fe502d4e4187
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/cancel/${odd_3}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
Cancel ODD from admin (multiple4)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)https://stage.allrideapp.com/api/v1/admin/pb/odd/cancel/6863ff704193d3bf454699e1?community=6654ae4eba54fe502d4e4187
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/cancel/${odd_4}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
