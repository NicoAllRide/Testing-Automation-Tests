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

Round Full Online
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    ${el1} =    Set Variable     xpath=(//android.widget.ImageView[@resource-id="com.allride.buses:id/navigation_bar_item_icon_view"])[2]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}
    ${el4} =    Set Variable     id=com.allride.buses:id/searchRoute
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}
    ${el5} =    Set Variable     id=com.allride.buses:id/searchRoute
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}
    Input Text    ${el5}    h
    ${el6} =    Set Variable     id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}
    ${el3} =    Set Variable     id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}
    ${el4} =    Set Variable     id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}
    ${el5} =    Set Variable     id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}

        Sleep    3s

    Set Location    -33.486270000000005    -70.51867
    Sleep    3s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48633    -70.51873
    Sleep    2s
    Set Location    -33.486360000000005    -70.51877
    Sleep    2s
    Set Location    -33.486430000000006    -70.51881
    Sleep    2s
    Set Location    -33.48688    -70.51907
    Sleep    2s
    Set Location    -33.48718    -70.51925
    Sleep    2s
    Set Location    -33.48724    -70.51929000000001
    Sleep    2s
    Set Location    -33.487410000000004    -70.51938000000001
    Sleep    2s
    Set Location    -33.48753    -70.51942000000001
    Sleep    2s
    Set Location    -33.48758    -70.51943
    Sleep    2s
    Set Location    -33.48778    -70.51944
    Sleep    2s
    Set Location    -33.48787    -70.51942000000001
    Sleep    2s
    Set Location    -33.48794    -70.51938000000001
    Sleep    2s
    Set Location    -33.487970000000004    -70.51932000000001
    Sleep    2s
    Set Location    -33.48798    -70.51929000000001
    Sleep    2s
    Set Location    -33.488040000000005    -70.51929000000001
    Sleep    2s
    Set Location    -33.488400000000006    -70.51916
    Sleep    2s
    Set Location    -33.488580000000006    -70.51905000000001
    Sleep    2s
    Set Location    -33.488730000000004    -70.51892000000001
    Sleep    2s
    Set Location    -33.488800000000005    -70.51885
    Sleep    2s
    Set Location    -33.48886    -70.51881
    Sleep    2s
    Set Location    -33.48897    -70.51874000000001
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489110000000004    -70.51830000000001
    Sleep    2s
    Set Location    -33.48912    -70.51823
    Sleep    2s
    Set Location    -33.489160000000005    -70.51806
    Sleep    2s
    Set Location    -33.48921    -70.51791
    Sleep    2s
    Set Location    -33.48924    -70.51779
    Sleep    2s
    Set Location    -33.48924    -70.51765
    Sleep    2s
    Set Location    -33.489200000000004    -70.51747
    Sleep    2s
    Set Location    -33.48917    -70.51738
    Sleep    2s
    Set Location    -33.48913    -70.5172
    Sleep    2s
    Set Location    -33.489070000000005    -70.51700000000001
    Sleep    2s
    Set Location    -33.48901    -70.51679
    Sleep    2s
    Set Location    -33.48901    -70.51671
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.489470000000004    -70.51619000000001
    Sleep    2s
    Set Location    -33.489670000000004    -70.51615000000001
    Sleep    2s
    Set Location    -33.48996    -70.51616
    Sleep    2s
    Set Location    -33.48996    -70.51616
    Sleep    2s
    Set Location    -33.48997    -70.51617
    Sleep    2s
    Set Location    -33.48998    -70.51618
    Sleep    2s
    Set Location    -33.489990000000006    -70.51620000000001
    Sleep    2s
    Set Location    -33.49    -70.51621
    Sleep    2s
    Set Location    -33.49002    -70.51621
    Sleep    2s
    Set Location    -33.490030000000004    -70.51622
    Sleep    2s
    Set Location    -33.490050000000004    -70.51622
    Sleep    2s
    Set Location    -33.49006    -70.51621
    Sleep    2s
    Set Location    -33.490080000000006    -70.51621
    Sleep    2s
    Set Location    -33.49009    -70.51620000000001
    Sleep    2s
    Set Location    -33.490100000000005    -70.51619000000001
    Sleep    2s
    Set Location    -33.490100000000005    -70.51617
    Sleep    2s
    Set Location    -33.49011    -70.51616
    Sleep    2s
    Set Location    -33.490120000000005    -70.51615000000001
    Sleep    2s
    Set Location    -33.490120000000005    -70.51613
    Sleep    2s
    Set Location    -33.490120000000005    -70.51611000000001
    Sleep    2s
    Set Location    -33.49011    -70.51609
    Sleep    2s
    Set Location    -33.490170000000006    -70.51605
    Sleep    2s
    Set Location    -33.490230000000004    -70.51595
    Sleep    2s
    Set Location    -33.490300000000005    -70.51585
    Sleep    2s
    Set Location    -33.49035    -70.51574000000001
    Sleep    2s
    Set Location    -33.490410000000004    -70.51555
    Sleep    2s
    Set Location    -33.490640000000006    -70.51499000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51489000000001
    Sleep    2s
    Set Location    -33.49073    -70.51483
    Sleep    2s
    Set Location    -33.49076    -70.5147
    Sleep    2s
    Set Location    -33.490750000000006    -70.5146
    Sleep    2s
    Set Location    -33.49074    -70.51459000000001
    Sleep    2s
    Set Location    -33.490680000000005    -70.51453000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51441000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51422000000001
    Sleep    2s
    Set Location    -33.490770000000005    -70.51388
    Sleep    2s
    Set Location    -33.4908    -70.51382000000001
    Sleep    2s
    Set Location    -33.49085    -70.51375
    Sleep    2s
    Set Location    -33.49094    -70.51368000000001
    Sleep    2s
    Set Location    -33.49101    -70.51364000000001
    Sleep    2s
    Set Location    -33.49121    -70.51354
    Sleep    2s
    Set Location    -33.49138    -70.51342000000001
    Sleep    2s
    Set Location    -33.49143    -70.51338000000001
    Sleep    2s
    Set Location    -33.491490000000006    -70.51335
    Sleep    2s
    Set Location    -33.491530000000004    -70.51333000000001
    Sleep    2s
    Set Location    -33.491620000000005    -70.51332000000001
    Sleep    2s
    Set Location    -33.491690000000006    -70.51333000000001
    Sleep    2s
    Set Location    -33.49176    -70.51337000000001
    Sleep    2s
    Set Location    -33.491800000000005    -70.5134
    Sleep    2s
    Set Location    -33.491910000000004    -70.51349
    Sleep    2s
    Set Location    -33.49194    -70.51351000000001
    Sleep    2s
    Set Location    -33.49201    -70.51356000000001
    Sleep    2s
    Set Location    -33.4921    -70.51358
    Sleep    2s
    Set Location    -33.49215    -70.51358
    Sleep    2s
    Set Location    -33.49226    -70.51356000000001
    Sleep    2s
    Set Location    -33.4924    -70.51349
    Sleep    2s
    Set Location    -33.49255    -70.51332000000001
    Sleep    2s
    Set Location    -33.492610000000006    -70.51320000000001
    Sleep    2s
    Set Location    -33.49273    -70.51304
    Sleep    2s
    Set Location    -33.492850000000004    -70.51293000000001
    Sleep    2s
    Set Location    -33.49268    -70.51310000000001
    Sleep    2s
    Set Location    -33.49257    -70.51328000000001
    Sleep    2s
    Set Location    -33.492470000000004    -70.51343
    Sleep    2s
    Set Location    -33.49231    -70.51354
    Sleep    2s
    Set Location    -33.49222    -70.51357
    Sleep    2s
    Set Location    -33.492110000000004    -70.51358
    Sleep    2s
    Set Location    -33.492050000000006    -70.51357
    Sleep    2s
    Set Location    -33.49197    -70.51354
    Sleep    2s
    Set Location    -33.49193    -70.51351000000001
    Sleep    2s
    Set Location    -33.491870000000006    -70.51345
    Sleep    2s
    Set Location    -33.491780000000006    -70.51338000000001
    Sleep    2s
    Set Location    -33.49172    -70.51334
    Sleep    2s
    Set Location    -33.49166    -70.51332000000001
    Sleep    2s
    Set Location    -33.491580000000006    -70.51332000000001
    Sleep    2s
    Set Location    -33.491490000000006    -70.51334
    Sleep    2s
    Set Location    -33.49147    -70.51336
    Sleep    2s
    Set Location    -33.49141    -70.5134
    Sleep    2s
    Set Location    -33.491330000000005    -70.51345
    Sleep    2s
    Set Location    -33.49116    -70.51357
    Sleep    2s
    Set Location    -33.490990000000004    -70.51365000000001
    Sleep    2s
    Set Location    -33.490930000000006    -70.51369000000001
    Sleep    2s
    Set Location    -33.4908    -70.51381
    Sleep    2s
    Set Location    -33.49078    -70.51385
    Sleep    2s
    Set Location    -33.49071    -70.51406
    Sleep    2s
    Set Location    -33.490660000000005    -70.51422000000001
    Sleep    2s
    Set Location    -33.49067    -70.51448
    Sleep    2s
    Set Location    -33.490680000000005    -70.51453000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51489000000001
    Sleep    2s
    Set Location    -33.4906    -70.51514
    Sleep    2s
    Set Location    -33.490320000000004    -70.51563
    Sleep    2s
    Set Location    -33.49022    -70.51576
    Sleep    2s
    Set Location    -33.49013    -70.51587
    Sleep    2s
    Set Location    -33.49006    -70.51597000000001
    Sleep    2s
    Set Location    -33.490030000000004    -70.51604
    Sleep    2s
    Set Location    -33.490030000000004    -70.51604
    Sleep    2s
    Set Location    -33.490010000000005    -70.51604
    Sleep    2s
    Set Location    -33.49    -70.51605
    Sleep    2s
    Set Location    -33.48962    -70.51607
    Sleep    2s
    Set Location    -33.48946    -70.51608
    Sleep    2s
    Set Location    -33.48924    -70.51610000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51614000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51614000000001
    Sleep    2s
    Set Location    -33.48901    -70.51619000000001
    Sleep    2s
    Set Location    -33.48901    -70.51624000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51629000000001
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.48901    -70.51671
    Sleep    2s
    Set Location    -33.48901    -70.51679
    Sleep    2s
    Set Location    -33.489070000000005    -70.51700000000001
    Sleep    2s
    Set Location    -33.48913    -70.5172
    Sleep    2s
    Set Location    -33.48917    -70.51738
    Sleep    2s
    Set Location    -33.489200000000004    -70.51747
    Sleep    2s
    Set Location    -33.48924    -70.51765
    Sleep    2s
    Set Location    -33.48924    -70.51779
    Sleep    2s
    Set Location    -33.48921    -70.51791
    Sleep    2s
    Set Location    -33.489160000000005    -70.51806
    Sleep    2s
    Set Location    -33.48912    -70.51823
    Sleep    2s
    Set Location    -33.489110000000004    -70.51830000000001
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.48897    -70.51874000000001
    Sleep    2s
    Set Location    -33.48886    -70.51881
    Sleep    2s
    Set Location    -33.488800000000005    -70.51885
    Sleep    2s
    Set Location    -33.488730000000004    -70.51892000000001
    Sleep    2s
    Set Location    -33.488580000000006    -70.51905000000001
    Sleep    2s
    Set Location    -33.488400000000006    -70.51916
    Sleep    2s
    Set Location    -33.488040000000005    -70.51929000000001
    Sleep    2s
    Set Location    -33.48798    -70.51929000000001
    Sleep    2s
    Set Location    -33.48792    -70.51928000000001
    Sleep    2s
    Set Location    -33.48729    -70.51897000000001
    Sleep    2s
    Set Location    -33.48666    -70.51859
    Sleep    2s
    Set Location    -33.486520000000006    -70.5185
    Sleep    2s
    Set Location    -33.486520000000006    -70.5185
    Sleep    2s
    Set Location    -33.486520000000006    -70.51862000000001
    Sleep    2s
    Set Location    -33.48646    -70.51864
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48633    -70.51873
    Sleep    2s
    Set Location    -33.486360000000005    -70.51877
    Sleep    2s
    Set Location    -33.486380000000004    -70.51878
    Sleep    2s
Round Full Offline
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    ${el1} =    Set Variable     xpath=(//android.widget.ImageView[@resource-id="com.allride.buses:id/navigation_bar_item_icon_view"])[2]
    Click Element    ${el1}

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Sleep    5s

    Swipe    ${775}    ${2230}    ${867}    ${195}

    ${el4} =    Set Variable     id=com.allride.buses:id/searchRoute
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}
    ${el5} =    Set Variable     id=com.allride.buses:id/searchRoute
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}
    Input Text    ${el5}    h
    ${el6} =    Set Variable     id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}
    ${el3} =    Set Variable     id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}
    ${el4} =    Set Variable     id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}
    ${el5} =    Set Variable     id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}

    Sleep    3s

    Set Location    -33.486270000000005    -70.51867
    Sleep    3s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48633    -70.51873
    Sleep    2s
    Set Location    -33.486360000000005    -70.51877
    Sleep    2s
    Set Location    -33.486430000000006    -70.51881
    Sleep    2s
    Set Location    -33.48688    -70.51907
    Sleep    2s
    Set Location    -33.48718    -70.51925
    Sleep    2s
    Set Location    -33.48724    -70.51929000000001
    Sleep    2s
    Set Location    -33.487410000000004    -70.51938000000001
    Sleep    2s
    Set Location    -33.48753    -70.51942000000001
    Sleep    2s
    Set Location    -33.48758    -70.51943
    Sleep    2s
    Set Location    -33.48778    -70.51944
    Sleep    2s
    Set Location    -33.48787    -70.51942000000001
    Sleep    2s
    Set Location    -33.48794    -70.51938000000001
    Sleep    2s
    Set Location    -33.487970000000004    -70.51932000000001
    Sleep    2s
    Set Location    -33.48798    -70.51929000000001
    Sleep    2s
    Set Location    -33.488040000000005    -70.51929000000001
    Sleep    2s
    Set Location    -33.488400000000006    -70.51916
    Sleep    2s
    Set Location    -33.488580000000006    -70.51905000000001
    Sleep    2s
    Set Location    -33.488730000000004    -70.51892000000001
    Sleep    2s
    Set Location    -33.488800000000005    -70.51885
    Sleep    2s
    Set Location    -33.48886    -70.51881
    Sleep    2s
    Set Location    -33.48897    -70.51874000000001
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489110000000004    -70.51830000000001
    Sleep    2s
    Set Location    -33.48912    -70.51823
    Sleep    2s
    Set Location    -33.489160000000005    -70.51806
    Sleep    2s
    Set Location    -33.48921    -70.51791
    Sleep    2s
    Set Location    -33.48924    -70.51779
    Sleep    2s
    Set Location    -33.48924    -70.51765
    Sleep    2s
    Set Location    -33.489200000000004    -70.51747
    Sleep    2s
    Set Location    -33.48917    -70.51738
    Sleep    2s
    Set Location    -33.48913    -70.5172
    Sleep    2s
    Set Location    -33.489070000000005    -70.51700000000001
    Sleep    2s
    Set Location    -33.48901    -70.51679
    Sleep    2s
    Set Location    -33.48901    -70.51671
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.489470000000004    -70.51619000000001
    Sleep    2s
    Set Location    -33.489670000000004    -70.51615000000001
    Sleep    2s
    Set Location    -33.48996    -70.51616
    Sleep    2s
    Set Location    -33.48996    -70.51616
    Sleep    2s
    Set Location    -33.48997    -70.51617
    Sleep    2s
    Set Location    -33.48998    -70.51618
    Sleep    2s
    Set Location    -33.489990000000006    -70.51620000000001
    Sleep    2s
    Set Location    -33.49    -70.51621
    Sleep    2s
    Set Location    -33.49002    -70.51621
    Sleep    2s
    Set Location    -33.490030000000004    -70.51622
    Sleep    2s
    Set Location    -33.490050000000004    -70.51622
    Sleep    2s
    Set Location    -33.49006    -70.51621
    Sleep    2s
    Set Location    -33.490080000000006    -70.51621
    Sleep    2s
    Set Location    -33.49009    -70.51620000000001
    Sleep    2s
    Set Location    -33.490100000000005    -70.51619000000001
    Sleep    2s
    Set Location    -33.490100000000005    -70.51617
    Sleep    2s
    Set Location    -33.49011    -70.51616
    Sleep    2s
    Set Location    -33.490120000000005    -70.51615000000001
    Sleep    2s
    Set Location    -33.490120000000005    -70.51613
    Sleep    2s
    Set Location    -33.490120000000005    -70.51611000000001
    Sleep    2s
    Set Location    -33.49011    -70.51609
    Sleep    2s
    Set Location    -33.490170000000006    -70.51605
    Sleep    2s
    Set Location    -33.490230000000004    -70.51595
    Sleep    2s
    Set Location    -33.490300000000005    -70.51585
    Sleep    2s
    Set Location    -33.49035    -70.51574000000001
    Sleep    2s
    Set Location    -33.490410000000004    -70.51555
    Sleep    2s
    Set Location    -33.490640000000006    -70.51499000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51489000000001
    Sleep    2s
    Set Location    -33.49073    -70.51483
    Sleep    2s
    Set Location    -33.49076    -70.5147
    Sleep    2s
    Set Location    -33.490750000000006    -70.5146
    Sleep    2s
    Set Location    -33.49074    -70.51459000000001
    Sleep    2s
    Set Location    -33.490680000000005    -70.51453000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51441000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51422000000001
    Sleep    2s
    Set Location    -33.490770000000005    -70.51388
    Sleep    2s
    Set Location    -33.4908    -70.51382000000001
    Sleep    2s
    Set Location    -33.49085    -70.51375
    Sleep    2s
    Set Location    -33.49094    -70.51368000000001
    Sleep    2s
    Set Location    -33.49101    -70.51364000000001
    Sleep    2s
    Set Location    -33.49121    -70.51354
    Sleep    2s
    Set Location    -33.49138    -70.51342000000001
    Sleep    2s
    Set Location    -33.49143    -70.51338000000001
    Sleep    2s
    Set Location    -33.491490000000006    -70.51335
    Sleep    2s
    Set Location    -33.491530000000004    -70.51333000000001
    Sleep    2s
    Set Location    -33.491620000000005    -70.51332000000001
    Sleep    2s
    Set Location    -33.491690000000006    -70.51333000000001
    Sleep    2s
    Set Location    -33.49176    -70.51337000000001
    Sleep    2s
    Set Location    -33.491800000000005    -70.5134
    Sleep    2s
    Set Location    -33.491910000000004    -70.51349
    Sleep    2s
    Set Location    -33.49194    -70.51351000000001
    Sleep    2s
    Set Location    -33.49201    -70.51356000000001
    Sleep    2s
    Set Location    -33.4921    -70.51358
    Sleep    2s
    Set Location    -33.49215    -70.51358
    Sleep    2s
    Set Location    -33.49226    -70.51356000000001
    Sleep    2s
    Set Location    -33.4924    -70.51349
    Sleep    2s
    Set Location    -33.49255    -70.51332000000001
    Sleep    2s
    Set Location    -33.492610000000006    -70.51320000000001
    Sleep    2s
    Set Location    -33.49273    -70.51304
    Sleep    2s
    Set Location    -33.492850000000004    -70.51293000000001
    Sleep    2s
    Set Location    -33.49268    -70.51310000000001
    Sleep    2s
    Set Location    -33.49257    -70.51328000000001
    Sleep    2s
    Set Location    -33.492470000000004    -70.51343
    Sleep    2s
    Set Location    -33.49231    -70.51354
    Sleep    2s
    Set Location    -33.49222    -70.51357
    Sleep    2s
    Set Location    -33.492110000000004    -70.51358
    Sleep    2s
    Set Location    -33.492050000000006    -70.51357
    Sleep    2s
    Set Location    -33.49197    -70.51354
    Sleep    2s
    Set Location    -33.49193    -70.51351000000001
    Sleep    2s
    Set Location    -33.491870000000006    -70.51345
    Sleep    2s
    Set Location    -33.491780000000006    -70.51338000000001
    Sleep    2s
    Set Location    -33.49172    -70.51334
    Sleep    2s
    Set Location    -33.49166    -70.51332000000001
    Sleep    2s
    Set Location    -33.491580000000006    -70.51332000000001
    Sleep    2s
    Set Location    -33.491490000000006    -70.51334
    Sleep    2s
    Set Location    -33.49147    -70.51336
    Sleep    2s
    Set Location    -33.49141    -70.5134
    Sleep    2s
    Set Location    -33.491330000000005    -70.51345
    Sleep    2s
    Set Location    -33.49116    -70.51357
    Sleep    2s
    Set Location    -33.490990000000004    -70.51365000000001
    Sleep    2s
    Set Location    -33.490930000000006    -70.51369000000001
    Sleep    2s
    Set Location    -33.4908    -70.51381
    Sleep    2s
    Set Location    -33.49078    -70.51385
    Sleep    2s
    Set Location    -33.49071    -70.51406
    Sleep    2s
    Set Location    -33.490660000000005    -70.51422000000001
    Sleep    2s
    Set Location    -33.49067    -70.51448
    Sleep    2s
    Set Location    -33.490680000000005    -70.51453000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51489000000001
    Sleep    2s
    Set Location    -33.4906    -70.51514
    Sleep    2s
    Set Location    -33.490320000000004    -70.51563
    Sleep    2s
    Set Location    -33.49022    -70.51576
    Sleep    2s
    Set Location    -33.49013    -70.51587
    Sleep    2s
    Set Location    -33.49006    -70.51597000000001
    Sleep    2s
    Set Location    -33.490030000000004    -70.51604
    Sleep    2s
    Set Location    -33.490030000000004    -70.51604
    Sleep    2s
    Set Location    -33.490010000000005    -70.51604
    Sleep    2s
    Set Location    -33.49    -70.51605
    Sleep    2s
    Set Location    -33.48962    -70.51607
    Sleep    2s
    Set Location    -33.48946    -70.51608
    Sleep    2s
    Set Location    -33.48924    -70.51610000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51614000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51614000000001
    Sleep    2s
    Set Location    -33.48901    -70.51619000000001
    Sleep    2s
    Set Location    -33.48901    -70.51624000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51629000000001
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.48901    -70.51671
    Sleep    2s
    Set Location    -33.48901    -70.51679
    Sleep    2s
    Set Location    -33.489070000000005    -70.51700000000001
    Sleep    2s
    Set Location    -33.48913    -70.5172
    Sleep    2s
    Set Location    -33.48917    -70.51738
    Sleep    2s
    Set Location    -33.489200000000004    -70.51747
    Sleep    2s
    Set Location    -33.48924    -70.51765
    Sleep    2s
    Set Location    -33.48924    -70.51779
    Sleep    2s
    Set Location    -33.48921    -70.51791
    Sleep    2s
    Set Location    -33.489160000000005    -70.51806
    Sleep    2s
    Set Location    -33.48912    -70.51823
    Sleep    2s
    Set Location    -33.489110000000004    -70.51830000000001
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.48897    -70.51874000000001
    Sleep    2s
    Set Location    -33.48886    -70.51881
    Sleep    2s
    Set Location    -33.488800000000005    -70.51885
    Sleep    2s
    Set Location    -33.488730000000004    -70.51892000000001
    Sleep    2s
    Set Location    -33.488580000000006    -70.51905000000001
    Sleep    2s
    Set Location    -33.488400000000006    -70.51916
    Sleep    2s
    Set Location    -33.488040000000005    -70.51929000000001
    Sleep    2s
    Set Location    -33.48798    -70.51929000000001
    Sleep    2s
    Set Location    -33.48792    -70.51928000000001
    Sleep    2s
    Set Location    -33.48729    -70.51897000000001
    Sleep    2s
    Set Location    -33.48666    -70.51859
    Sleep    2s
    Set Location    -33.486520000000006    -70.5185
    Sleep    2s
    Set Location    -33.486520000000006    -70.5185
    Sleep    2s
    Set Location    -33.486520000000006    -70.51862000000001
    Sleep    2s
    Set Location    -33.48646    -70.51864
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48633    -70.51873
    Sleep    2s
    Set Location    -33.486360000000005    -70.51877
    Sleep    2s
    Set Location    -33.486380000000004    -70.51878
    Sleep    2s

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


Full Online Except Second Time On First Stop
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

    ${el1} =    Set Variable     xpath=(//android.widget.ImageView[@resource-id="com.allride.buses:id/navigation_bar_item_icon_view"])[2]
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}
    ${el4} =    Set Variable     id=com.allride.buses:id/searchRoute
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}
    ${el5} =    Set Variable     id=com.allride.buses:id/searchRoute
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}
    Input Text    ${el5}    h
    ${el6} =    Set Variable     id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}
    ${el3} =    Set Variable     id=com.allride.buses:id/buttonSecondary
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}
    ${el4} =    Set Variable     id=com.allride.buses:id/lastUsedVehicleText
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}
    ${el5} =    Set Variable     id=com.allride.buses:id/startButton
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}

    #----------------------------------------------------------------------------------#
    #INICIO PRIMERA PARADA
    #----------------------------------------------------------------------------------#
    Sleep    3s
    Set Location    -33.486270000000005    -70.51867
    Sleep    3s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48633    -70.51873
    Sleep    2s
    Set Location    -33.486360000000005    -70.51877
    Sleep    2s
    Set Location    -33.486430000000006    -70.51881
    Sleep    2s
    Set Location    -33.48688    -70.51907
    Sleep    2s
    Set Location    -33.48718    -70.51925
    Sleep    2s
    Set Location    -33.48724    -70.51929000000001
    Sleep    2s
    Set Location    -33.487410000000004    -70.51938000000001
    Sleep    2s
    Set Location    -33.48753    -70.51942000000001
    Sleep    2s
    Set Location    -33.48758    -70.51943
    Sleep    2s
    Set Location    -33.48778    -70.51944
    Sleep    2s
    Set Location    -33.48787    -70.51942000000001
    Sleep    2s
    Set Location    -33.48794    -70.51938000000001
    Sleep    2s
    Set Location    -33.487970000000004    -70.51932000000001
    Sleep    2s
    Set Location    -33.48798    -70.51929000000001
    Sleep    2s
    Set Location    -33.488040000000005    -70.51929000000001
    Sleep    2s
    Set Location    -33.488400000000006    -70.51916
    Sleep    2s
    Set Location    -33.488580000000006    -70.51905000000001
    Sleep    2s
    Set Location    -33.488730000000004    -70.51892000000001
    Sleep    2s
    Set Location    -33.488800000000005    -70.51885
    Sleep    2s
    Set Location    -33.48886    -70.51881
    Sleep    2s
    Set Location    -33.48897    -70.51874000000001
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489110000000004    -70.51830000000001
    Sleep    2s
    Set Location    -33.48912    -70.51823
    Sleep    2s
    Set Location    -33.489160000000005    -70.51806
    Sleep    2s
    Set Location    -33.48921    -70.51791
    Sleep    2s
    Set Location    -33.48924    -70.51779
    Sleep    2s
    Set Location    -33.48924    -70.51765
    Sleep    2s
    Set Location    -33.489200000000004    -70.51747
    Sleep    2s
    Set Location    -33.48917    -70.51738
    Sleep    2s
    Set Location    -33.48913    -70.5172
    Sleep    2s
    Set Location    -33.489070000000005    -70.51700000000001
    Sleep    2s
    Set Location    -33.48901    -70.51679
    Sleep    2s
    Set Location    -33.48901    -70.51671
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.489470000000004    -70.51619000000001
    Sleep    2s
    Set Location    -33.489670000000004    -70.51615000000001
    Sleep    2s
    Set Location    -33.48996    -70.51616
    Sleep    2s
    Set Location    -33.48996    -70.51616
    Sleep    2s
    Set Location    -33.48997    -70.51617
    Sleep    2s
    Set Location    -33.48998    -70.51618
    Sleep    2s
    Set Location    -33.489990000000006    -70.51620000000001
    Sleep    2s
    Set Location    -33.49    -70.51621
    Sleep    2s
    Set Location    -33.49002    -70.51621
    Sleep    2s
    Set Location    -33.490030000000004    -70.51622
    Sleep    2s
    Set Location    -33.490050000000004    -70.51622
    Sleep    2s
    Set Location    -33.49006    -70.51621
    Sleep    2s
    Set Location    -33.490080000000006    -70.51621
    Sleep    2s
    Set Location    -33.49009    -70.51620000000001
    Sleep    2s
    Set Location    -33.490100000000005    -70.51619000000001
    Sleep    2s
    Set Location    -33.490100000000005    -70.51617
    Sleep    2s
    Set Location    -33.49011    -70.51616
    Sleep    2s
    Set Location    -33.490120000000005    -70.51615000000001
    Sleep    2s
    Set Location    -33.490120000000005    -70.51613
    Sleep    2s
    Set Location    -33.490120000000005    -70.51611000000001
    Sleep    2s
    Set Location    -33.49011    -70.51609
    Sleep    2s
    Set Location    -33.490170000000006    -70.51605
    Sleep    2s
    Set Location    -33.490230000000004    -70.51595
    Sleep    2s
    Set Location    -33.490300000000005    -70.51585
    Sleep    2s
    Set Location    -33.49035    -70.51574000000001
    Sleep    2s
    Set Location    -33.490410000000004    -70.51555
    Sleep    2s
    Set Location    -33.490640000000006    -70.51499000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51489000000001
    Sleep    2s
    Set Location    -33.49073    -70.51483
    Sleep    2s
    Set Location    -33.49076    -70.5147
    Sleep    2s
    Set Location    -33.490750000000006    -70.5146
    Sleep    2s
    Set Location    -33.49074    -70.51459000000001
    Sleep    2s
    Set Location    -33.490680000000005    -70.51453000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51441000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51422000000001
    Sleep    2s
    Set Location    -33.490770000000005    -70.51388
    Sleep    2s
    Set Location    -33.4908    -70.51382000000001
    Sleep    2s
    Set Location    -33.49085    -70.51375
    Sleep    2s
    Set Location    -33.49094    -70.51368000000001
    Sleep    2s
    Set Location    -33.49101    -70.51364000000001
    Sleep    2s
    Set Location    -33.49121    -70.51354
    Sleep    2s
    Set Location    -33.49138    -70.51342000000001
    Sleep    2s
    Set Location    -33.49143    -70.51338000000001
    Sleep    2s
    Set Location    -33.491490000000006    -70.51335
    Sleep    2s
    Set Location    -33.491530000000004    -70.51333000000001
    Sleep    2s
    Set Location    -33.491620000000005    -70.51332000000001
    Sleep    2s
    Set Location    -33.491690000000006    -70.51333000000001
    Sleep    2s
    Set Location    -33.49176    -70.51337000000001
    Sleep    2s
    Set Location    -33.491800000000005    -70.5134
    Sleep    2s
    Set Location    -33.491910000000004    -70.51349
    Sleep    2s
    Set Location    -33.49194    -70.51351000000001
    Sleep    2s
    Set Location    -33.49201    -70.51356000000001
    Sleep    2s
    Set Location    -33.4921    -70.51358
    Sleep    2s
    Set Location    -33.49215    -70.51358
    Sleep    2s
    Set Location    -33.49226    -70.51356000000001
    Sleep    2s
    Set Location    -33.4924    -70.51349
    Sleep    2s
    Set Location    -33.49255    -70.51332000000001
    Sleep    2s
    Set Location    -33.492610000000006    -70.51320000000001
    Sleep    2s
    Set Location    -33.49273    -70.51304
    Sleep    2s
    Set Location    -33.492850000000004    -70.51293000000001
    Sleep    2s
    Set Location    -33.49268    -70.51310000000001
    Sleep    2s
    Set Location    -33.49257    -70.51328000000001
    Sleep    2s
    Set Location    -33.492470000000004    -70.51343
    Sleep    2s
    Set Location    -33.49231    -70.51354
    Sleep    2s
    Set Location    -33.49222    -70.51357
    Sleep    2s
    Set Location    -33.492110000000004    -70.51358
    Sleep    2s
    Set Location    -33.492050000000006    -70.51357
    Sleep    2s
    Set Location    -33.49197    -70.51354
    Sleep    2s
    Set Location    -33.49193    -70.51351000000001
    Sleep    2s
    Set Location    -33.491870000000006    -70.51345
    Sleep    2s
    Set Location    -33.491780000000006    -70.51338000000001
    Sleep    2s
    Set Location    -33.49172    -70.51334
    Sleep    2s
    Set Location    -33.49166    -70.51332000000001
    Sleep    2s
    Set Location    -33.491580000000006    -70.51332000000001
    Sleep    2s
    Set Location    -33.491490000000006    -70.51334
    Sleep    2s
    Set Location    -33.49147    -70.51336
    Sleep    2s
    Set Location    -33.49141    -70.5134
    Sleep    2s
    Set Location    -33.491330000000005    -70.51345
    Sleep    2s
    Set Location    -33.49116    -70.51357
    Sleep    2s
    Set Location    -33.490990000000004    -70.51365000000001
    Sleep    2s
    Set Location    -33.490930000000006    -70.51369000000001
    Sleep    2s
    Set Location    -33.4908    -70.51381
    Sleep    2s
    Set Location    -33.49078    -70.51385
    Sleep    2s
    Set Location    -33.49071    -70.51406
    Sleep    2s
    Set Location    -33.490660000000005    -70.51422000000001
    Sleep    2s
    Set Location    -33.49067    -70.51448
    Sleep    2s
    Set Location    -33.490680000000005    -70.51453000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51489000000001
    Sleep    2s
    Set Location    -33.4906    -70.51514
    Sleep    2s
    Set Location    -33.490320000000004    -70.51563
    Sleep    2s
    Set Location    -33.49022    -70.51576
    Sleep    2s
    Set Location    -33.49013    -70.51587
    Sleep    2s
    Set Location    -33.49006    -70.51597000000001
    Sleep    2s
    Set Location    -33.490030000000004    -70.51604
    Sleep    2s
    Set Location    -33.490030000000004    -70.51604
    Sleep    2s
    Set Location    -33.490010000000005    -70.51604
    Sleep    2s
    Set Location    -33.49    -70.51605
    Sleep    2s
    Set Location    -33.48962    -70.51607
    Sleep    2s
    Set Location    -33.48946    -70.51608
    Sleep    2s
    Set Location    -33.48924    -70.51610000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51614000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51614000000001
    Sleep    2s
    Set Location    -33.48901    -70.51619000000001
    Sleep    2s
    Set Location    -33.48901    -70.51624000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51629000000001
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.48901    -70.51671
    Sleep    2s
    Set Location    -33.48901    -70.51679
    Sleep    2s
    Set Location    -33.489070000000005    -70.51700000000001
    Sleep    2s
    Set Location    -33.48913    -70.5172
    Sleep    2s
    Set Location    -33.48917    -70.51738
    Sleep    2s
    Set Location    -33.489200000000004    -70.51747
    Sleep    2s
    Set Location    -33.48924    -70.51765
    Sleep    2s
    Set Location    -33.48924    -70.51779
    Sleep    2s
    Set Location    -33.48921    -70.51791
    Sleep    2s
    Set Location    -33.489160000000005    -70.51806
    Sleep    2s
    Set Location    -33.48912    -70.51823
    Sleep    2s
    Set Location    -33.489110000000004    -70.51830000000001
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.48897    -70.51874000000001
    Sleep    2s
    Set Location    -33.48886    -70.51881
    Sleep    2s
    Set Location    -33.488800000000005    -70.51885
    Sleep    2s
    Set Location    -33.488730000000004    -70.51892000000001
    Sleep    2s
    Set Location    -33.488580000000006    -70.51905000000001
    Sleep    2s
    Set Location    -33.488400000000006    -70.51916
    Sleep    2s
    Set Location    -33.488040000000005    -70.51929000000001
    Sleep    2s

#----------------------------------------------------------------------------------#
    #INICIO MODO AVION
#----------------------------------------------------------------------------------#

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Sleep    5s

    Swipe    ${775}    ${2230}    ${867}    ${195}

#-------------------------------------------------------------------------------------#    
    Set Location    -33.48798    -70.51929000000001
    Sleep    2s
    Set Location    -33.48792    -70.51928000000001
    Sleep    2s
    Set Location    -33.48729    -70.51897000000001
    Sleep    2s
    Set Location    -33.48666    -70.51859
    Sleep    2s
    Set Location    -33.486520000000006    -70.5185
    Sleep    2s
    Set Location    -33.486520000000006    -70.5185
    Sleep    2s
    Set Location    -33.486520000000006    -70.51862000000001
    Sleep    2s
    Set Location    -33.48646    -70.51864
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48633    -70.51873
    Sleep    2s
    Set Location    -33.486360000000005    -70.51877
    Sleep    2s
    Set Location    -33.486380000000004    -70.51878
    Sleep    2s


#----------------------------------------------------------------------------------#
    #INICIO PRIMERA PARADA
#----------------------------------------------------------------------------------#
    Set Location    -33.486270000000005    -70.51867
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48633    -70.51873
    Sleep    2s
    Set Location    -33.486360000000005    -70.51877
    Sleep    2s
    Set Location    -33.486430000000006    -70.51881
    Sleep    2s
    Set Location    -33.48688    -70.51907
    Sleep    2s
    Set Location    -33.48718    -70.51925
    Sleep    2s
    Set Location    -33.48724    -70.51929000000001
    Sleep    2s
    Set Location    -33.487410000000004    -70.51938000000001
    Sleep    2s
    Set Location    -33.48753    -70.51942000000001
    Sleep    2s
    Set Location    -33.48758    -70.51943
    Sleep    2s
    Set Location    -33.48778    -70.51944
    Sleep    2s

#----------------------------------------------------------------------------------#
    #TERMINO MODO AVION
#----------------------------------------------------------------------------------#

    Execute Script    mobile: openNotifications

    ${el6}=    Set Variable
    ...    xpath=//android.widget.TextView[@resource-id="com.android.systemui:id/tile_label" and @text="Modo de avión"]
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    Sleep    5s

    Swipe    ${775}    ${2230}    ${867}    ${195}
    Set Location    -33.48787    -70.51942000000001
    Sleep    2s
    Set Location    -33.48794    -70.51938000000001
    Sleep    2s
    Set Location    -33.487970000000004    -70.51932000000001
    Sleep    2s
    Set Location    -33.48798    -70.51929000000001
    Sleep    2s
    Set Location    -33.488040000000005    -70.51929000000001
    Sleep    2s
    Set Location    -33.488400000000006    -70.51916
    Sleep    2s
    Set Location    -33.488580000000006    -70.51905000000001
    Sleep    2s
    Set Location    -33.488730000000004    -70.51892000000001
    Sleep    2s
    Set Location    -33.488800000000005    -70.51885
    Sleep    2s
    Set Location    -33.48886    -70.51881
    Sleep    2s
    Set Location    -33.48897    -70.51874000000001
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489110000000004    -70.51830000000001
    Sleep    2s
    Set Location    -33.48912    -70.51823
    Sleep    2s
    Set Location    -33.489160000000005    -70.51806
    Sleep    2s
    Set Location    -33.48921    -70.51791
    Sleep    2s
    Set Location    -33.48924    -70.51779
    Sleep    2s
    Set Location    -33.48924    -70.51765
    Sleep    2s
    Set Location    -33.489200000000004    -70.51747
    Sleep    2s
    Set Location    -33.48917    -70.51738
    Sleep    2s
    Set Location    -33.48913    -70.5172
    Sleep    2s
    Set Location    -33.489070000000005    -70.51700000000001
    Sleep    2s
    Set Location    -33.48901    -70.51679
    Sleep    2s
    Set Location    -33.48901    -70.51671
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.489470000000004    -70.51619000000001
    Sleep    2s
    Set Location    -33.489670000000004    -70.51615000000001
    Sleep    2s
    Set Location    -33.48996    -70.51616
    Sleep    2s
    Set Location    -33.48996    -70.51616
    Sleep    2s
    Set Location    -33.48997    -70.51617
    Sleep    2s
    Set Location    -33.48998    -70.51618
    Sleep    2s
    Set Location    -33.489990000000006    -70.51620000000001
    Sleep    2s
    Set Location    -33.49    -70.51621
    Sleep    2s
    Set Location    -33.49002    -70.51621
    Sleep    2s
    Set Location    -33.490030000000004    -70.51622
    Sleep    2s
    Set Location    -33.490050000000004    -70.51622
    Sleep    2s
    Set Location    -33.49006    -70.51621
    Sleep    2s
    Set Location    -33.490080000000006    -70.51621
    Sleep    2s
    Set Location    -33.49009    -70.51620000000001
    Sleep    2s
    Set Location    -33.490100000000005    -70.51619000000001
    Sleep    2s
    Set Location    -33.490100000000005    -70.51617
    Sleep    2s
    Set Location    -33.49011    -70.51616
    Sleep    2s
    Set Location    -33.490120000000005    -70.51615000000001
    Sleep    2s
    Set Location    -33.490120000000005    -70.51613
    Sleep    2s
    Set Location    -33.490120000000005    -70.51611000000001
    Sleep    2s
    Set Location    -33.49011    -70.51609
    Sleep    2s
    Set Location    -33.490170000000006    -70.51605
    Sleep    2s
    Set Location    -33.490230000000004    -70.51595
    Sleep    2s
    Set Location    -33.490300000000005    -70.51585
    Sleep    2s
    Set Location    -33.49035    -70.51574000000001
    Sleep    2s
    Set Location    -33.490410000000004    -70.51555
    Sleep    2s
    Set Location    -33.490640000000006    -70.51499000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51489000000001
    Sleep    2s
    Set Location    -33.49073    -70.51483
    Sleep    2s
    Set Location    -33.49076    -70.5147
    Sleep    2s
    Set Location    -33.490750000000006    -70.5146
    Sleep    2s
    Set Location    -33.49074    -70.51459000000001
    Sleep    2s
    Set Location    -33.490680000000005    -70.51453000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51441000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51422000000001
    Sleep    2s
    Set Location    -33.490770000000005    -70.51388
    Sleep    2s
    Set Location    -33.4908    -70.51382000000001
    Sleep    2s
    Set Location    -33.49085    -70.51375
    Sleep    2s
    Set Location    -33.49094    -70.51368000000001
    Sleep    2s
    Set Location    -33.49101    -70.51364000000001
    Sleep    2s
    Set Location    -33.49121    -70.51354
    Sleep    2s
    Set Location    -33.49138    -70.51342000000001
    Sleep    2s
    Set Location    -33.49143    -70.51338000000001
    Sleep    2s
    Set Location    -33.491490000000006    -70.51335
    Sleep    2s
    Set Location    -33.491530000000004    -70.51333000000001
    Sleep    2s
    Set Location    -33.491620000000005    -70.51332000000001
    Sleep    2s
    Set Location    -33.491690000000006    -70.51333000000001
    Sleep    2s
    Set Location    -33.49176    -70.51337000000001
    Sleep    2s
    Set Location    -33.491800000000005    -70.5134
    Sleep    2s
    Set Location    -33.491910000000004    -70.51349
    Sleep    2s
    Set Location    -33.49194    -70.51351000000001
    Sleep    2s
    Set Location    -33.49201    -70.51356000000001
    Sleep    2s
    Set Location    -33.4921    -70.51358
    Sleep    2s
    Set Location    -33.49215    -70.51358
    Sleep    2s
    Set Location    -33.49226    -70.51356000000001
    Sleep    2s
    Set Location    -33.4924    -70.51349
    Sleep    2s
    Set Location    -33.49255    -70.51332000000001
    Sleep    2s
    Set Location    -33.492610000000006    -70.51320000000001
    Sleep    2s
    Set Location    -33.49273    -70.51304
    Sleep    2s
    Set Location    -33.492850000000004    -70.51293000000001
    Sleep    2s
    Set Location    -33.49268    -70.51310000000001
    Sleep    2s
    Set Location    -33.49257    -70.51328000000001
    Sleep    2s
    Set Location    -33.492470000000004    -70.51343
    Sleep    2s
    Set Location    -33.49231    -70.51354
    Sleep    2s
    Set Location    -33.49222    -70.51357
    Sleep    2s
    Set Location    -33.492110000000004    -70.51358
    Sleep    2s
    Set Location    -33.492050000000006    -70.51357
    Sleep    2s
    Set Location    -33.49197    -70.51354
    Sleep    2s
    Set Location    -33.49193    -70.51351000000001
    Sleep    2s
    Set Location    -33.491870000000006    -70.51345
    Sleep    2s
    Set Location    -33.491780000000006    -70.51338000000001
    Sleep    2s
    Set Location    -33.49172    -70.51334
    Sleep    2s
    Set Location    -33.49166    -70.51332000000001
    Sleep    2s
    Set Location    -33.491580000000006    -70.51332000000001
    Sleep    2s
    Set Location    -33.491490000000006    -70.51334
    Sleep    2s
    Set Location    -33.49147    -70.51336
    Sleep    2s
    Set Location    -33.49141    -70.5134
    Sleep    2s
    Set Location    -33.491330000000005    -70.51345
    Sleep    2s
    Set Location    -33.49116    -70.51357
    Sleep    2s
    Set Location    -33.490990000000004    -70.51365000000001
    Sleep    2s
    Set Location    -33.490930000000006    -70.51369000000001
    Sleep    2s
    Set Location    -33.4908    -70.51381
    Sleep    2s
    Set Location    -33.49078    -70.51385
    Sleep    2s
    Set Location    -33.49071    -70.51406
    Sleep    2s
    Set Location    -33.490660000000005    -70.51422000000001
    Sleep    2s
    Set Location    -33.49067    -70.51448
    Sleep    2s
    Set Location    -33.490680000000005    -70.51453000000001
    Sleep    2s
    Set Location    -33.490660000000005    -70.51489000000001
    Sleep    2s
    Set Location    -33.4906    -70.51514
    Sleep    2s
    Set Location    -33.490320000000004    -70.51563
    Sleep    2s
    Set Location    -33.49022    -70.51576
    Sleep    2s
    Set Location    -33.49013    -70.51587
    Sleep    2s
    Set Location    -33.49006    -70.51597000000001
    Sleep    2s
    Set Location    -33.490030000000004    -70.51604
    Sleep    2s
    Set Location    -33.490030000000004    -70.51604
    Sleep    2s
    Set Location    -33.490010000000005    -70.51604
    Sleep    2s
    Set Location    -33.49    -70.51605
    Sleep    2s
    Set Location    -33.48962    -70.51607
    Sleep    2s
    Set Location    -33.48946    -70.51608
    Sleep    2s
    Set Location    -33.48924    -70.51610000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51614000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51614000000001
    Sleep    2s
    Set Location    -33.48901    -70.51619000000001
    Sleep    2s
    Set Location    -33.48901    -70.51624000000001
    Sleep    2s
    Set Location    -33.489050000000006    -70.51629000000001
    Sleep    2s
    Set Location    -33.489070000000005    -70.5163
    Sleep    2s
    Set Location    -33.48901    -70.51671
    Sleep    2s
    Set Location    -33.48901    -70.51679
    Sleep    2s
    Set Location    -33.489070000000005    -70.51700000000001
    Sleep    2s
    Set Location    -33.48913    -70.5172
    Sleep    2s
    Set Location    -33.48917    -70.51738
    Sleep    2s
    Set Location    -33.489200000000004    -70.51747
    Sleep    2s
    Set Location    -33.48924    -70.51765
    Sleep    2s
    Set Location    -33.48924    -70.51779
    Sleep    2s
    Set Location    -33.48921    -70.51791
    Sleep    2s
    Set Location    -33.489160000000005    -70.51806
    Sleep    2s
    Set Location    -33.48912    -70.51823
    Sleep    2s
    Set Location    -33.489110000000004    -70.51830000000001
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.489140000000006    -70.51867
    Sleep    2s
    Set Location    -33.48897    -70.51874000000001
    Sleep    2s
    Set Location    -33.48886    -70.51881
    Sleep    2s
    Set Location    -33.488800000000005    -70.51885
    Sleep    2s
    Set Location    -33.488730000000004    -70.51892000000001
    Sleep    2s
    Set Location    -33.488580000000006    -70.51905000000001
    Sleep    2s
    Set Location    -33.488400000000006    -70.51916
    Sleep    2s
    Set Location    -33.488040000000005    -70.51929000000001
    Sleep    2s
    Set Location    -33.48798    -70.51929000000001
    Sleep    2s
    Set Location    -33.48792    -70.51928000000001
    Sleep    2s
    Set Location    -33.48729    -70.51897000000001
    Sleep    2s
    Set Location    -33.48666    -70.51859
    Sleep    2s
    Set Location    -33.486520000000006    -70.5185
    Sleep    2s
    Set Location    -33.486520000000006    -70.5185
    Sleep    2s
    Set Location    -33.486520000000006    -70.51862000000001
    Sleep    2s
    Set Location    -33.48646    -70.51864
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48631    -70.51867
    Sleep    2s
    Set Location    -33.48633    -70.51873
    Sleep    2s
    Set Location    -33.486360000000005    -70.51877
    Sleep    2s
    Set Location    -33.486380000000004    -70.51878
    Sleep    2s