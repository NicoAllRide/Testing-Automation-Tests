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
Verify Join Services in Community
        # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/superadmin/communities/${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=     Set variable    ${response.json()}
    ${enabled}=    Set Variable     ${responseJson}[custom][realTimeTransportSystem][buses][oDDServices][0][userRequests][joinDepartures][enabled]
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    
    Should Be Equal As Strings    ${enabled}   True

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

Create RDD As User(Nico)
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"oddType":"Taxis Coni y Nico","name":"Solicitud y comprobación RDD Abierto RF","direction":"in","comments":"Conducir con precaución","serviceDate":"${today_date}T20:00:00.000Z","startLocation":{"placeId":"655d11d88a5a1a1ff0328466","lat":"-33.3908833","lon":"-70.54620129999999","loc":["-70.54620129999999","-33.3908833"],"address":"Alto Las Condes Avenida Presidente Kennedy Lateral, Las Condes, Chile"},"endLocation":{"lat":"-33.409873","lon":"-70.5673477","loc":["-70.5673477","-33.409873"],"address":"Mall Apumanque Avenida Manquehue Sur, Las Condes, Chile","placeId":"655d11f68a5a1a1ff03284b1"}}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${TokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${rddId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddId}
Create RDD As User(Pedro)
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"oddType":"Taxis Coni y Nico","name":"Solicitud y comprobación RDD Abierto RF","direction":"in","comments":"Conducir con precaución","serviceDate":"${today_date}T20:40:00.000Z","startLocation":{"placeId":"655d11d88a5a1a1ff0328466","lat":"-33.3908833","lon":"-70.54620129999999","loc":["-70.54620129999999","-33.3908833"],"address":"Alto Las Condes Avenida Presidente Kennedy Lateral, Las Condes, Chile"},"endLocation":{"lat":"-33.409873","lon":"-70.5673477","loc":["-70.5673477","-33.409873"],"address":"Mall Apumanque Avenida Manquehue Sur, Las Condes, Chile","placeId":"655d11f68a5a1a1ff03284b1"}}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenPedroPascal}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${rddIdPedro}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddIdPedro}

Verify If RDD Id Nico Equals RDD Pedro(Join)
    Should Not Be Equal As Strings    ${rddId}    ${rddIdPedro}


####################################################
##Get Routes As Driver Pendiente

#######################################################

