*** Settings ***
Library     WebSocketClient
Library     BuiltIn
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../Variables/variablesStage.robot


*** Variables ***
#------------------------DEBE SER DEPARTURE TOKEN, NO RTL-----------------------------------------#
${TOKEN}            d39b2cd278ccdb8e15bd587d386935b2e727876e2ec225044de7ef7858d6f9a0e26378c14a48bd8a997f129ff7bf73843dce49bbcec490c478ae5dcf948e81b8
${URL}              ws://stage.allrideapp.com/socket.io/?token=${TOKEN}&EIO=3&transport=websocket
${LATITUDE}         -33.40783132925352
${LONGITUDE}        -70.56331367840907
${NEW_LATITUDE}     -34.40274888966042
${NEW_LONGITUDE}    -70.85938591407319
${IS_FULL}          false
${IS_PANICKING}     false
${CAPACITY}         4
${SPEED}            50.5
${STAGE_URL}            https://stage.allrideapp.com


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

        ${end_date_tomorrow}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_tomorrow}
    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}

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


1 hours local 
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}


Get Driver Token
    [Documentation]    Se obtiene el token del conductor
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad2}&driverId=66d1dca1bc357f32ce162d1c

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


#------------------------Guardar distancia en REGULARES----------------------------------##
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
    ...    url=/api/v2/pb/driver/departure
    ...    data={"communityId":"${idComunidad2}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"68b9b3d9135fbc4265e376c3","capacity":46,"busCode":"Codigo1","driverCode":"142142","vehicleId":"67b5f76fb5c11f24f63fe29d","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken}
    Log    ${code}
    Set Global Variable    ${departureToken}
    Set Global Variable    ${access_token}

*** Test Cases ***
Three Full Laps In Segments (5s pacing)
    # 1) Inicia la salida y obtiene ${access_token} (tu keyword existente)
    # 2) Define tramos como listas "lat,lon"
    ${TRAMO_A}=    Create List
    ...    -34.41212945007269,-70.85422675459023
    ...    -34.41102503370746,-70.85368108555384
    ...    -34.41085884988376,-70.85371657703962
    ...    -34.41023922088965,-70.8525179206524
    ...    -34.41001390011297,-70.85110684416829
    ...    -34.40983865019779,-70.84993094709375

    ${TRAMO_B}=    Create List
    ...    -34.40888520980337,-70.8490866811272
    ...    -34.40779613615711,-70.84855563082763
    ...    -34.40799642662148,-70.84865425445612
    ...    -34.40732044435621,-70.84832803784448
    ...    -34.406550569021356,-70.84840390217329
    ...    -34.406137462248914,-70.84825217351981

    ${TRAMO_C}=    Create List
    ...    -34.406137462248914,-70.84825217351981
    ...    -34.406550569021356,-70.84840390217329
    ...    -34.40732044435621,-70.84832803784448
    ...    -34.40799642662148,-70.84865425445612
    ...    -34.40779613615711,-70.84855563082763
    ...    -34.40888520980337,-70.8490866811272

    ${TRAMO_D}=    Create List
    ...    -34.40983865019779,-70.84993094709375
    ...    -34.41001390011297,-70.85110684416829
    ...    -34.41023922088965,-70.8525179206524
    ...    -34.41085884988376,-70.85371657703962
    ...    -34.41102503370746,-70.85368108555384
    ...    -34.41212945007269,-70.85422675459023

    # 3) Ejecuta 3 vueltas: A → B → C → D (con 5s entre posiciones)
    FOR    ${LAP}    IN RANGE    1    4
        Log    ==== VUELTA ${LAP} : TRAMO A ====
        ${URL_with_token}=    Set Variable    wss://stage.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
        ${ws}=    Connect    ${URL_with_token}
        Send    ${ws}    40/pbDriver?token=${access_token}
        Sleep    2s
        ${r1}=    Recv Data    ${ws}
        Send    ${ws}    42/pbDriver,["join"]
        Sleep    2s
        ${r2}=    Recv Data    ${ws}
        FOR    ${p}    IN    @{TRAMO_A}
            ${parts}=    Split String    ${p}    ,
            ${lat}=    Convert To Number    ${parts}[0]
            ${lon}=    Convert To Number    ${parts}[1]
            ${payload}=    Set Variable    42/pbDriver,["newPosition",{"latitude": ${lat}, "longitude": ${lon}, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
            Send    ${ws}    ${payload}
            Sleep    5s
            ${r}=    Recv Data    ${ws}
            Log    (A): ${r}
        END

        Log    ==== VUELTA ${LAP} : TRAMO B ====
        ${ws}=    Connect    ${URL_with_token}
        Send    ${ws}    40/pbDriver?token=${access_token}
        Sleep    2s
        ${r1}=    Recv Data    ${ws}
        Send    ${ws}    42/pbDriver,["join"]
        Sleep    2s
        ${r2}=    Recv Data    ${ws}
        FOR    ${p}    IN    @{TRAMO_B}
            ${parts}=    Split String    ${p}    ,
            ${lat}=    Convert To Number    ${parts}[0]
            ${lon}=    Convert To Number    ${parts}[1]
            ${payload}=    Set Variable    42/pbDriver,["newPosition",{"latitude": ${lat}, "longitude": ${lon}, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
            Send    ${ws}    ${payload}
            Sleep    5s
            ${r}=    Recv Data    ${ws}
            Log    (B): ${r}
        END

        Log    ==== VUELTA ${LAP} : TRAMO C ====
        ${ws}=    Connect    ${URL_with_token}
        Send    ${ws}    40/pbDriver?token=${access_token}
        Sleep    2s
        ${r1}=    Recv Data    ${ws}
        Send    ${ws}    42/pbDriver,["join"]
        Sleep    2s
        ${r2}=    Recv Data    ${ws}
        FOR    ${p}    IN    @{TRAMO_C}
            ${parts}=    Split String    ${p}    ,
            ${lat}=    Convert To Number    ${parts}[0]
            ${lon}=    Convert To Number    ${parts}[1]
            ${payload}=    Set Variable    42/pbDriver,["newPosition",{"latitude": ${lat}, "longitude": ${lon}, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
            Send    ${ws}    ${payload}
            Sleep    5s
            ${r}=    Recv Data    ${ws}
            Log    (C): ${r}
        END

        Log    ==== VUELTA ${LAP} : TRAMO D ====
        ${ws}=    Connect    ${URL_with_token}
        Send    ${ws}    40/pbDriver?token=${access_token}
        Sleep    2s
        ${r1}=    Recv Data    ${ws}
        Send    ${ws}    42/pbDriver,["join"]
        Sleep    2s
        ${r2}=    Recv Data    ${ws}
        FOR    ${p}    IN    @{TRAMO_D}
            ${parts}=    Split String    ${p}    ,
            ${lat}=    Convert To Number    ${parts}[0]
            ${lon}=    Convert To Number    ${parts}[1]
            ${payload}=    Set Variable    42/pbDriver,["newPosition",{"latitude": ${lat}, "longitude": ${lon}, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
            Send    ${ws}    ${payload}
            Sleep    5s
            ${r}=    Recv Data    ${ws}
            Log    (D): ${r}
        END
    END

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

       ${json}=    Set Variable    ${response.json()}
    ${trails}=    Set Variable    ${json}[trail]

    #✅ Validar que existe al menos un trail
    Should Not Be Empty    ${trails}    ❌ Expected at least one trail, but none were found.

    #✅ Validar que el primer trail tenga round = 1
    ${first_trail}=    Get From List    ${trails}    0
    Should Be Equal As Numbers    ${first_trail}[round]    1
    ...    msg=❌ Expected first trail round to be 1 but got "${first_trail}[round]"

    #✅ Validar que exista un segundo trail
    Run Keyword And Continue On Failure
    ...    Length Should Be    ${trails}    2
    ...    ❌ Only one trail was found, expected at least 2 to properly count rounds.

    #✅ Validar que el segundo trail tenga round = 2 (si existe)
    Run Keyword If    ${len(${trails})} > 1
    ...    Should Be Equal As Numbers    ${trails}[1][round]    2
    ...    msg=❌ Expected second trail round to be 2 but got "${trails}[1][round]"
    

