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


Get All Stops
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Get On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/stops/list?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    
    Should Not Be Empty    ${response.json()}    Response was empty, no stops were found


####################################################
##Get Routes As Driver Pendiente

#######################################################


Create Stop manually
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/stops?community=6654ae4eba54fe502d4e4187
    ...    data={"name":"Created Stop RF","description":"Stop created from RF to automate test","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"ownerIds":[{"id":"6654ae4eba54fe502d4e4187","role":"community"}],"categories":["pb"],"lat":-33.458284,"lon":-70.662725,"config":{"options":[],"restricted":false,"stopIds":[]}}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}
    ${stopId}    Set Variable    ${response.json()}[_id]

    Set Global Variable    ${stopId}

    # Basic stop info
    Should Be Equal As Strings    ${json}[name]    Created Stop RF
    ...    msg=❌ Stop name does not match. Found: "${json}[name]"
    Should Be Equal As Strings    ${json}[lat]     -33.458284
    ...    msg=❌ Latitude does not match. Found: "${json}[lat]"
    Should Be Equal As Strings    ${json}[lon]     -70.662725
    ...    msg=❌ Longitude does not match. Found: "${json}[lon]"
    Should Be Equal As Strings    ${json}[loc][0]  -70.662725
    ...    msg=❌ 'loc[0]' (lon) does not match. Found: "${json}[loc][0]"
    Should Be Equal As Strings    ${json}[loc][1]  -33.458284
    ...    msg=❌ 'loc[1]' (lat) does not match. Found: "${json}[loc][1]"
    Should Be Equal As Strings    ${json}[description]    Stop created from RF to automate test
    ...    msg=❌ Description does not match. Found: "${json}[description]"

    # Community and Super Community
    Should Contain    ${json}[communities]         6654ae4eba54fe502d4e4187
    ...    msg=❌ 'communities' does not contain expected ID. Found: "${json}[communities]"
    Should Contain    ${json}[superCommunities]    653fd68233d83952fafcd4be
    ...    msg=❌ 'superCommunities' does not contain expected ID. Found: "${json}[superCommunities]"
    Should Be Equal As Strings    ${json}[communityId]       6654ae4eba54fe502d4e4187
    ...    msg=❌ 'communityId' does not match. Found: "${json}[communityId]"
    Should Be Equal As Strings    ${json}[superCommunityId]  653fd68233d83952fafcd4be
    ...    msg=❌ 'superCommunityId' does not match. Found: "${json}[superCommunityId]"

    # Owner ID structure
    Should Be Equal As Strings    ${json}[ownerIds][0][id]     6654ae4eba54fe502d4e4187
    ...    msg=❌ 'ownerIds[0].id' does not match. Found: "${json}[ownerIds][0][id]"
    Should Be Equal As Strings    ${json}[ownerIds][0][role]   community
    ...    msg=❌ 'ownerIds[0].role' should be 'community'. Found: "${json}[ownerIds][0][role]"

    # Empty/default fields
    Should Be Equal As Strings    ${json}[users]    []
    ...    msg=❌ 'users' list should be empty. Found: "${json}[users]"
    Should Be Equal As Strings    ${json}[categories][0]    pb
    ...    msg=❌ First category should be 'pb'. Found: "${json}[categories][0]"
    Should Be Equal As Strings    ${json}[config][stopIds]    []
    ...    msg=❌ 'config.stopIds' should be empty. Found: "${json}[config][stopIds]"
    Should Be Equal As Strings    ${json}[config][options]    []
    ...    msg=❌ 'config.options' should be empty. Found: "${json}[config][options]"
    Should Be Equal As Strings    ${json}[oDDConfig][stopIds]    []
    ...    msg=❌ 'oDDConfig.stopIds' should be empty. Found: "${json}[oDDConfig][stopIds]"
    Should Be Equal As Strings    ${json}[oDDConfig][options]    []
    ...    msg=❌ 'oDDConfig.options' should be empty. Found: "${json}[oDDConfig][options]"

    # Timestamps
    Should Not Be Empty    ${json}[createdAt]
    ...    msg=❌ 'createdAt' should not be empty. Found: "${json}[createdAt]"
    Should Not Be Empty    ${json}[updatedAt]
    ...    msg=❌ 'updatedAt' should not be empty. Found: "${json}[updatedAt]"


Delete Stop

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/stops/${stopId}?community=6654ae4eba54fe502d4e4187
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}

    # Basic stop info
    Should Be Equal As Strings    ${json}[name]    Created Stop RF
    ...    msg=❌ Stop name mismatch. Found: "${json}[name]"
    Should Be Equal As Strings    ${json}[lat]     -33.458284
    ...    msg=❌ Latitude mismatch. Found: "${json}[lat]"
    Should Be Equal As Strings    ${json}[lon]     -70.662725
    ...    msg=❌ Longitude mismatch. Found: "${json}[lon]"
    Should Be Equal As Strings    ${json}[loc][0]  -70.662725
    ...    msg=❌ loc[0] (lon) mismatch. Found: "${json}[loc][0]"
    Should Be Equal As Strings    ${json}[loc][1]  -33.458284
    ...    msg=❌ loc[1] (lat) mismatch. Found: "${json}[loc][1]"
    Should Be Equal As Strings    ${json}[description]    Stop created from RF to automate test
    ...    msg=❌ Description mismatch. Found: "${json}[description]"

    # Community IDs
    Should Contain    ${json}[communities]         6654ae4eba54fe502d4e4187
    ...    msg=❌ 'communities' missing expected ID. Found: "${json}[communities]"
    Should Contain    ${json}[superCommunities]    653fd68233d83952fafcd4be
    ...    msg=❌ 'superCommunities' missing expected ID. Found: "${json}[superCommunities]"
    Should Be Equal As Strings    ${json}[communityId]       6654ae4eba54fe502d4e4187
    ...    msg=❌ 'communityId' mismatch. Found: "${json}[communityId]"
    Should Be Equal As Strings    ${json}[superCommunityId]  653fd68233d83952fafcd4be
    ...    msg=❌ 'superCommunityId' mismatch. Found: "${json}[superCommunityId]"

    # Ownership
    Should Be Equal As Strings    ${json}[ownerIds][0][id]     6654ae4eba54fe502d4e4187
    ...    msg=❌ Owner ID mismatch. Found: "${json}[ownerIds][0][id]"
    Should Be Equal As Strings    ${json}[ownerIds][0][role]   community
    ...    msg=❌ Owner role mismatch. Found: "${json}[ownerIds][0][role]"

    # Status and config
    Should Be Equal As Strings    ${json}[active]    False
    ...    msg=❌ 'active' should be false. Found: "${json}[active]"
    Should Not Be Empty           ${json}[deletedAt]
    ...    msg=❌ 'deletedAt' should not be empty. Found: "${json}[deletedAt]"

    # Empty/default fields
    Should Be Equal As Strings    ${json}[users]    []
    ...    msg=❌ 'users' should be empty. Found: "${json}[users]"
    Should Be Equal As Strings    ${json}[categories][0]    pb
    ...    msg=❌ First category should be 'pb'. Found: "${json}[categories][0]"
    Should Be Equal As Strings    ${json}[config][stopIds]    []
    ...    msg=❌ config.stopIds should be empty. Found: "${json}[config][stopIds]"
    Should Be Equal As Strings    ${json}[config][options]    []
    ...    msg=❌ config.options should be empty. Found: "${json}[config][options]"
    Should Be Equal As Strings    ${json}[oDDConfig][stopIds]    []
    ...    msg=❌ oDDConfig.stopIds should be empty. Found: "${json}[oDDConfig][stopIds]"
    Should Be Equal As Strings    ${json}[oDDConfig][options]    []
    ...    msg=❌ oDDConfig.options should be empty. Found: "${json}[oDDConfig][options]"

    # Timestamps
    Should Not Be Empty    ${json}[createdAt]
    ...    msg=❌ 'createdAt' is missing. Found: "${json}[createdAt]"
    Should Not Be Empty    ${json}[updatedAt]
    ...    msg=❌ 'updatedAt' is missing. Found: "${json}[updatedAt]"
    Should Not Be Equal As Strings    ${json}[createdAt]    ${json}[updatedAt]
    ...    msg=❌ 'updatedAt' should be different from 'createdAt'. Found: createdAt=${json}[createdAt], updatedAt=${json}[updatedAt]
    
Create Stop (Bulk)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/stops/bulk?community=6654ae4eba54fe502d4e4187
    ...    data=[{"ownerIds":[{"id":"6654ae4eba54fe502d4e4187","role":"community"}],"name":"Create Bulk Stops","lat":"-33.458284","lon":"-70.662725","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":[],"odd":true,"address":"Fantasilandia RDD"},{"ownerIds":[{"id":"6654ae4eba54fe502d4e4187","role":"community"}],"name":"Create Bulk Stops2","lat":"-33.458284","lon":"-70.662725","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":[],"odd":false,"address":"Fantasilandia Normal"}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}
    ${stopId_bulk1}=     Set Variable    ${response.json()}[stopsCreated][0][_id]
    ${stopId_bulk2}=     Set Variable    ${response.json()}[stopsCreated][1][_id]

    Set Global Variable    ${stopId_bulk1}
    Set Global Variable    ${stopId_bulk2}

    # Check no errors occurred
    Should Be Equal As Strings    ${json}[stopsWithErrors]    []
    ...    msg=❌ 'stopsWithErrors' should be empty. Found: "${json}[stopsWithErrors]"

    # Validate stop 1
    ${stop1}=    Set Variable    ${json}[stopsCreated][0]
    Should Be Equal As Strings    ${stop1}[name]    Create Bulk Stops
    ...    msg=❌ Stop 1 name mismatch. Found: "${stop1}[name]"
    Should Be Equal As Strings    ${stop1}[lat]     -33.458284
    ...    msg=❌ Stop 1 latitude mismatch. Found: "${stop1}[lat]"
    Should Be Equal As Strings    ${stop1}[lon]     -70.662725
    ...    msg=❌ Stop 1 longitude mismatch. Found: "${stop1}[lon]"
    Should Be Equal As Strings    ${stop1}[loc][0]  -70.662725
    ...    msg=❌ Stop 1 loc[0] (lon) mismatch. Found: "${stop1}[loc][0]"
    Should Be Equal As Strings    ${stop1}[loc][1]  -33.458284
    ...    msg=❌ Stop 1 loc[1] (lat) mismatch. Found: "${stop1}[loc][1]"
    Should Be Equal As Strings    ${stop1}[address]    Fantasilandia RDD
    ...    msg=❌ Stop 1 address mismatch. Found: "${stop1}[address]"
    Should Be Equal As Strings    ${stop1}[categories][0]    odd
    ...    msg=❌ Stop 1 category mismatch. Found: "${stop1}[categories][0]"
    Should Be Equal As Strings    ${stop1}[communities][0]    6654ae4eba54fe502d4e4187
    ...    msg=❌ Stop 1 community mismatch. Found: "${stop1}[communities]"
    Should Be Equal As Strings    ${stop1}[ownerIds][0][id]   6654ae4eba54fe502d4e4187
    ...    msg=❌ Stop 1 owner ID mismatch. Found: "${stop1}[ownerIds][0][id]"
    Should Be Equal As Strings    ${stop1}[ownerIds][0][role]   community
    ...    msg=❌ Stop 1 owner role mismatch. Found: "${stop1}[ownerIds][0][role]"
    Should Be Equal As Strings    ${stop1}[users]    []
    ...    msg=❌ Stop 1 users should be empty. Found: "${stop1}[users]"
    Should Be Equal As Strings    ${stop1}[oDDConfig][stopIds]    []
    ...    msg=❌ Stop 1 oDDConfig.stopIds should be empty. Found: "${stop1}[oDDConfig][stopIds]"
    Should Be Equal As Strings    ${stop1}[oDDConfig][options]    []
    ...    msg=❌ Stop 1 oDDConfig.options should be empty. Found: "${stop1}[oDDConfig][options]"
    Should Be Equal As Strings    ${stop1}[config][stopIds]    []
    ...    msg=❌ Stop 1 config.stopIds should be empty. Found: "${stop1}[config][stopIds]"
    Should Be Equal As Strings    ${stop1}[config][options]    []
    ...    msg=❌ Stop 1 config.options should be empty. Found: "${stop1}[config][options]"

    # Validate stop 2
    ${stop2}=    Set Variable    ${json}[stopsCreated][1]
    Should Be Equal As Strings    ${stop2}[name]    Create Bulk Stops2
    ...    msg=❌ Stop 2 name mismatch. Found: "${stop2}[name]"
    Should Be Equal As Strings    ${stop2}[lat]     -33.458284
    ...    msg=❌ Stop 2 latitude mismatch. Found: "${stop2}[lat]"
    Should Be Equal As Strings    ${stop2}[lon]     -70.662725
    ...    msg=❌ Stop 2 longitude mismatch. Found: "${stop2}[lon]"
    Should Be Equal As Strings    ${stop2}[loc][0]  -70.662725
    ...    msg=❌ Stop 2 loc[0] (lon) mismatch. Found: "${stop2}[loc][0]"
    Should Be Equal As Strings    ${stop2}[loc][1]  -33.458284
    ...    msg=❌ Stop 2 loc[1] (lat) mismatch. Found: "${stop2}[loc][1]"
    Should Be Equal As Strings    ${stop2}[categories][0]    pb
    ...    msg=❌ Stop 2 category mismatch. Found: "${stop2}[categories][0]"
    Should Be Equal As Strings    ${stop2}[communities][0]    6654ae4eba54fe502d4e4187
    ...    msg=❌ Stop 2 community mismatch. Found: "${stop2}[communities]"
    Should Be Equal As Strings    ${stop2}[ownerIds][0][id]   6654ae4eba54fe502d4e4187
    ...    msg=❌ Stop 2 owner ID mismatch. Found: "${stop2}[ownerIds][0][id]"
    Should Be Equal As Strings    ${stop2}[ownerIds][0][role]   community
    ...    msg=❌ Stop 2 owner role mismatch. Found: "${stop2}[ownerIds][0][role]"
    Should Be Equal As Strings    ${stop2}[users]    []
    ...    msg=❌ Stop 2 users should be empty. Found: "${stop2}[users]"
    Should Be Equal As Strings    ${stop2}[oDDConfig][stopIds]    []
    ...    msg=❌ Stop 2 oDDConfig.stopIds should be empty. Found: "${stop2}[oDDConfig][stopIds]"
    Should Be Equal As Strings    ${stop2}[oDDConfig][options]    []
    ...    msg=❌ Stop 2 oDDConfig.options should be empty. Found: "${stop2}[oDDConfig][options]"
    Should Be Equal As Strings    ${stop2}[config][stopIds]    []
    ...    msg=❌ Stop 2 config.stopIds should be empty. Found: "${stop2}[config][stopIds]"
    Should Be Equal As Strings    ${stop2}[config][options]    []
    ...    msg=❌ Stop 2 config.options should be empty. Found: "${stop2}[config][options]"

Delete Bulk Stop 1

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/stops/${stopId_bulk1}?community=6654ae4eba54fe502d4e4187
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}

    # Status and config
    Should Be Equal As Strings    ${json}[active]    False
    ...    msg=❌ 'active' should be false. Found: "${json}[active]"
    Should Not Be Empty           ${json}[deletedAt]
    ...    msg=❌ 'deletedAt' should not be empty. Found: "${json}[deletedAt]"
Delete Bulk Stop 2

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/stops/${stopId_bulk2}?community=6654ae4eba54fe502d4e4187
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}

    # Status and config
    Should Be Equal As Strings    ${json}[active]    False
    ...    msg=❌ 'active' should be false. Found: "${json}[active]"
    Should Not Be Empty           ${json}[deletedAt]
    ...    msg=❌ 'deletedAt' should not be empty. Found: "${json}[deletedAt]"
