*** Settings ***
Library     AppiumLibrary
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     RPA.JSON


*** Variables ***
${STAGE_URL}            https://stage.allrideapp.com
${TESTING_URL}          https://testing.allrideapp.com
${endPoint}             /api/v1/admin/pb/routes?community=653fd601f90509541a748683
${driverId}             6582e724938e4e7b3bcf9f0a
${driverCode}           753
${vehicleId}            6553b81315e27f4db2b45935
${vehicleCapacity}      3
${vehicleCode}          1111
${addStopOrder}         /api/v1/admin/pb/stop-time?community=${idComunidad}
${seatReservation}      /api/v1/pb/user/booking
${idNico}               65e8e076337a90a35ba6e8dd
${idKratos}             65e092afca7842b1032f12e2
${idPedro}              654a5148bf3e9410d0bcd39a
${idNaruto}             653ff69df90509541a74988b
${tokenAdmin}           Bearer cb91fc010de72bf97bce8da804b7b1ed896bf0bf12e54034d570937eea068ed2e988a32cfd47af4ccb36bfe97a7d7166b39c72a1a792cb0b8d059b470c9d51cc
${tokenNico}            Bearer 60c0099c85d42b55bb405bd579d1c64f1629b1e879f290e43c235ef6bbfb8cd35da8055b20fefee31e3a11cb6207b9d91f7039a92eb266f587f11479d9f153f2
${tokenPedroPascal}     Bearer 2eacdb42a68ffa12b3d9901816b6b6049b1a65c9232c2112a64c5935002683b35bbf10c046ef9670f529241849999f66c4645956ecb1b0ae2a1de5c3209f9f4b
${tokenKratos}          Bearer fda5651771446906c9a511a066e26b4ef28873fa97ce094f47a2402b4a9a6f652a0032e1a7d3607515d2a873f2bb1eb73033e06c8d1d78e28b725a0537807d6f
${tokenNaruto}          Bearer fc7d6941c41225c2756ac83a2c0898dcae5c0ef2c0c9f5a7779d51fd3753dca60212278ac0f6fa0bf3ff4c77f482c6524eb2c5b8918b4dc4a3d81c7cba010bef
${idComunidad}          653fd601f90509541a748683
${idSuperCommunity}     653fd68233d83952fafcd4be
${shapeId}              658c42cff6f903bbee969242
${idAdmin}              653fd89733d83952fafcd6ca
${assignQty}            2
${cardIdPedro}          ABCDE159753


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
    Set Global Variable    ${end_date_tomorrow2}
    ${expiration_date_qr}=    Set Variable    ${fecha_manana}T14:10:37.968Z
    Set Global Variable    ${expiration_date_qr}

Verify Validations
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${serviceId}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Set Global Variable    ${serviceId}

Offline 1
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    ${el1}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.allride.buses:id/navigation_bar_item_small_label_view" and @text="Regulares"]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2}=    Set Variable    xpath=(//android.widget.Button[@resource-id="com.allride.buses:id/startButton"])[3]
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3}=    Set Variable    id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4}=    Set Variable    id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5}=    Set Variable    id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    ${el7}=    Set Variable    xpath=//android.widget.TextView[@text="VALIDAR"]
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    Sleep    20s

    ${el8}=    Set Variable    accessibility_id=Atrás
    Wait Until Element Is Visible    ${el8}
    Click Element    ${el8}

    ${el9}=    Set Variable    id=com.allride.buses:id/stopTripButton
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10}=    Set Variable    id=com.allride.buses:id/titleButtonMain
    Wait Until Element Is Visible    ${el10}
    Click Element    ${el10}

    ${el11}=    Set Variable    id=android:id/button1
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}

    Execute Script    mobile: openNotifications

    ${el12}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el12}
    Click Element    ${el12}

    Swipe    ${722}    ${2236}    ${764}    ${686}

    Sleep    10s

Verify Validation Offline 1
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${offline_1_Id}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Should Be Equal As Integers    ${validations}    1
    Should Not Be Equal As Strings    ${Offline_1_Id}    ${serviceId}

    Set Global Variable    ${offline_1_Id}

Offline 2
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    ${el1}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.allride.buses:id/navigation_bar_item_small_label_view" and @text="Regulares"]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2}=    Set Variable    xpath=(//android.widget.Button[@resource-id="com.allride.buses:id/startButton"])[3]
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3}=    Set Variable    id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4}=    Set Variable    id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5}=    Set Variable    id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    ${el7}=    Set Variable    xpath=//android.widget.TextView[@text="VALIDAR"]
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    Sleep    20s

    ${el8}=    Set Variable    accessibility_id=Atrás
    Wait Until Element Is Visible    ${el8}
    Click Element    ${el8}

    Sleep    5s

    Execute Script    mobile: openNotifications
    ${el12}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el12}
    Click Element    ${el12}

    Swipe    ${722}    ${2236}    ${764}    ${686}

    Sleep    5s

    ${el9}=    Set Variable    id=com.allride.buses:id/stopTripButton
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10}=    Set Variable    id=com.allride.buses:id/titleButtonMain
    Wait Until Element Is Visible    ${el10}
    Click Element    ${el10}

    ${el11}=    Set Variable    id=android:id/button1
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}

    Sleep    10s

Verify Validation Offline 2
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${offline_2_Id}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Should Be Equal As Integers    ${validations}    1
    Should Not Be Equal As Strings    ${offline_1_Id}    ${offline_2_Id}

    Set Global Variable    ${offline_2_Id}
Offline 3
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    ${el1}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.allride.buses:id/navigation_bar_item_small_label_view" and @text="Regulares"]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2}=    Set Variable    xpath=(//android.widget.Button[@resource-id="com.allride.buses:id/startButton"])[3]
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3}=    Set Variable    id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4}=    Set Variable    id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5}=    Set Variable    id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}


    ${el7}=    Set Variable    xpath=//android.widget.TextView[@text="VALIDAR"]
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    Sleep    20s

    ${el8}=    Set Variable    accessibility_id=Atrás
    Wait Until Element Is Visible    ${el8}
    Click Element    ${el8}

    Sleep    5s

    Execute Script    mobile: openNotifications
    ${el12}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el12}
    Click Element    ${el12}

    Swipe    ${722}    ${2236}    ${764}    ${686}

    Sleep    5s

    ${el9}=    Set Variable    id=com.allride.buses:id/stopTripButton
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10}=    Set Variable    id=com.allride.buses:id/titleButtonMain
    Wait Until Element Is Visible    ${el10}
    Click Element    ${el10}

    ${el11}=    Set Variable    id=android:id/button1
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

Verify Validation Offline 3
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${offline_3_Id}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Should Be Equal As Integers    ${validations}    1
    Should Not Be Equal As Strings    ${offline_2_Id}    ${offline_3_Id}

    Set Global Variable    ${offline_3_Id}
Offline 4
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    ${el1}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.allride.buses:id/navigation_bar_item_small_label_view" and @text="Regulares"]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2}=    Set Variable    xpath=(//android.widget.Button[@resource-id="com.allride.buses:id/startButton"])[3]
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3}=    Set Variable    id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4}=    Set Variable    id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5}=    Set Variable    id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}


    ${el7}=    Set Variable    xpath=//android.widget.TextView[@text="VALIDAR"]
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    Sleep    20s

    ${el8}=    Set Variable    accessibility_id=Atrás
    Wait Until Element Is Visible    ${el8}
    Click Element    ${el8}

    Sleep    5s

    Sleep    5s

    ${el9}=    Set Variable    id=com.allride.buses:id/stopTripButton
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10}=    Set Variable    id=com.allride.buses:id/titleButtonMain
    Wait Until Element Is Visible    ${el10}
    Click Element    ${el10}

    ${el11}=    Set Variable    id=android:id/button1
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}
    Sleep    10s

Verify Validation Offline 4
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${offline_4_Id}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Should Be Equal As Integers    ${validations}    1
    Should Not Be Equal As Strings    ${offline_3_Id}    ${offline_4_Id}

    Set Global Variable    ${offline_4_Id}


Offline 5
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    ${el1}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.allride.buses:id/navigation_bar_item_small_label_view" and @text="Regulares"]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2}=    Set Variable    xpath=(//android.widget.Button[@resource-id="com.allride.buses:id/startButton"])[3]
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3}=    Set Variable    id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4}=    Set Variable    id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5}=    Set Variable    id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}


    ${el7}=    Set Variable    xpath=//android.widget.TextView[@text="VALIDAR"]
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    Sleep    20s

    ${el8}=    Set Variable    accessibility_id=Atrás
    Wait Until Element Is Visible    ${el8}
    Click Element    ${el8}

    Sleep    5s

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    ${el9}=    Set Variable    id=com.allride.buses:id/stopTripButton
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10}=    Set Variable    id=com.allride.buses:id/titleButtonMain
    Wait Until Element Is Visible    ${el10}
    Click Element    ${el10}

    ${el11}=    Set Variable    id=android:id/button1
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}
    Sleep    10s

Verify Validation Offline 5
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${offline_5_Id}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Should Be Equal As Integers    ${validations}    1
    Should Not Be Equal As Strings    ${offline_4_Id}    ${offline_5_Id}

    Set Global Variable    ${offline_5_Id}

Offline 6
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    ${el1}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.allride.buses:id/navigation_bar_item_small_label_view" and @text="Regulares"]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2}=    Set Variable    xpath=(//android.widget.Button[@resource-id="com.allride.buses:id/startButton"])[3]
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3}=    Set Variable    id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4}=    Set Variable    id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5}=    Set Variable    id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}


    ${el7}=    Set Variable    xpath=//android.widget.TextView[@text="VALIDAR"]
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    Sleep    20s

    ${el8}=    Set Variable    accessibility_id=Atrás
    Wait Until Element Is Visible    ${el8}
    Click Element    ${el8}

    Sleep    5s

    ${el9}=    Set Variable    id=com.allride.buses:id/stopTripButton
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10}=    Set Variable    id=com.allride.buses:id/titleButtonMain
    Wait Until Element Is Visible    ${el10}
    Click Element    ${el10}

    ${el11}=    Set Variable    id=android:id/button1
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}
    Sleep    10s

	Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s
Verify Validation Offline 6
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${offline_6_Id}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Should Be Equal As Integers    ${validations}    1
    Should Not Be Equal As Strings    ${offline_5_Id}    ${offline_6_Id}

    Set Global Variable    ${offline_6_Id}
Offline 7
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    ${el1}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.allride.buses:id/navigation_bar_item_small_label_view" and @text="Regulares"]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2}=    Set Variable    xpath=(//android.widget.Button[@resource-id="com.allride.buses:id/startButton"])[3]
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3}=    Set Variable    id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4}=    Set Variable    id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5}=    Set Variable    id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}

   Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    ${el7}=    Set Variable    xpath=//android.widget.TextView[@text="VALIDAR"]
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    Sleep    20s

    ${el8}=    Set Variable    accessibility_id=Atrás
    Wait Until Element Is Visible    ${el8}
    Click Element    ${el8}

	Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    Sleep    5s

    ${el9}=    Set Variable    id=com.allride.buses:id/stopTripButton
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10}=    Set Variable    id=com.allride.buses:id/titleButtonMain
    Wait Until Element Is Visible    ${el10}
    Click Element    ${el10}

    ${el11}=    Set Variable    id=android:id/button1
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}
    Sleep    10s

	Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s
Verify Validation Offline 7
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${offline_7_Id}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Should Be Equal As Integers    ${validations}    1
    Should Not Be Equal As Strings    ${offline_6_Id}    ${offline_7_Id}

    Set Global Variable    ${offline_7_Id}
Offline 8
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    ${el1}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.allride.buses:id/navigation_bar_item_small_label_view" and @text="Regulares"]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2}=    Set Variable    xpath=(//android.widget.Button[@resource-id="com.allride.buses:id/startButton"])[3]
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3}=    Set Variable    id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4}=    Set Variable    id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5}=    Set Variable    id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}

   Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    ${el7}=    Set Variable    xpath=//android.widget.TextView[@text="VALIDAR"]
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    Sleep    20s

    ${el8}=    Set Variable    accessibility_id=Atrás
    Wait Until Element Is Visible    ${el8}
    Click Element    ${el8}

	Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    Sleep    10s

    Sleep    5s

    ${el9}=    Set Variable    id=com.allride.buses:id/stopTripButton
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10}=    Set Variable    id=com.allride.buses:id/titleButtonMain
    Wait Until Element Is Visible    ${el10}
    Click Element    ${el10}

    ${el11}=    Set Variable    id=android:id/button1
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}
    Sleep    10s

	Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Swipe    ${775}    ${2230}    ${867}    ${195}

    ${el13} =    Set Variable     id=com.allride.buses:id/buttonAcceptStatistics
    Wait Until Element Is Visible    ${el13}
    Click Element    ${el1}

    Sleep    10s
Verify Validation Offline 8
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v1/admin/pb/departures/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"2024-03-04T03:00:00.000Z","endDate":"${end_date_tomorrow2}","searchAll":"","route":"0","label":"","driver":"0","vehicleId":"","active":null,"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null,"onlyInternal":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departures}=    Set Variable    ${response.json()}[departures]
    ${offline_8_Id}=    Set Variable    ${departures}[0][_id]
    ${validations}=    Set Variable    ${departures}[0][validations]

    Should Be Equal As Integers    ${validations}    1
    Should Not Be Equal As Strings    ${offline_7_Id}    ${offline_8_Id}

    Set Global Variable    ${offline_8_Id}



