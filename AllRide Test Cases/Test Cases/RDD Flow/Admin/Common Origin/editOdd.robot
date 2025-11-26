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

    ...    data={"superCommunityId":"${idSuperCommunity}","adminId":"${idAdmin}","adminName":"Soporte AllRide","oddSimpleFlow":false,"state":"pendingDriverAssignment","name":"RDD Common Destiny Flow","oddType":"Taxis Coni y Nico","placeLat":-33.4098734,"placeLon":-70.5673477,"serviceCost":null,"apportionByParams":[],"direction":"out","comments":"","serviceDate":"${formatted_one_hour_later}","extraMinutes":0,"estimatedArrival":"${r_estimated_arrival1}","reservations":[{"userId":"${idNico}","stopId":"655d11d88a5a1a1ff0328466","placeId":null,"order":0,"estimatedArrival":"${r_estimated_arrival1}","distances":{"fromPrevious":0,"toNext":4334,"distanceToLocation":4334,"pctToLocation":1}}],"waypoints":[[-70.54732,-33.39116],[-70.54727000000001,-33.39133],[-70.54721,-33.391470000000005],[-70.54716,-33.391540000000006],[-70.54705,-33.39162],[-70.54695000000001,-33.3917],[-70.54689,-33.391780000000004],[-70.54689,-33.39181],[-70.54693,-33.39188],[-70.54698,-33.3919],[-70.54719,-33.39193],[-70.54751,-33.391270000000006],[-70.54761,-33.3911],[-70.54766000000001,-33.390950000000004],[-70.54774,-33.390660000000004],[-70.54785000000001,-33.39038],[-70.54812000000001,-33.38983],[-70.54827,-33.389500000000005],[-70.54875000000001,-33.38969],[-70.54948,-33.389970000000005],[-70.54953,-33.390010000000004],[-70.54971,-33.39011],[-70.55007,-33.39025],[-70.55031000000001,-33.390370000000004],[-70.5505,-33.390480000000004],[-70.55272000000001,-33.39135],[-70.55353000000001,-33.39166],[-70.55436,-33.39193],[-70.55537000000001,-33.392300000000006],[-70.55657000000001,-33.39271],[-70.55855000000001,-33.393370000000004],[-70.56148,-33.394400000000005],[-70.56253000000001,-33.394740000000006],[-70.56457,-33.395480000000006],[-70.56617,-33.39603],[-70.56643000000001,-33.396060000000006],[-70.56678000000001,-33.39616],[-70.56710000000001,-33.39627],[-70.5673,-33.39631],[-70.56773000000001,-33.396460000000005],[-70.56902000000001,-33.396910000000005],[-70.56936,-33.39705],[-70.57007,-33.397310000000004],[-70.5706,-33.39745],[-70.57089,-33.397560000000006],[-70.57161,-33.397830000000006],[-70.57183,-33.39777],[-70.5719,-33.39772],[-70.57194000000001,-33.39764],[-70.57193000000001,-33.39746],[-70.5719,-33.397360000000006],[-70.57187,-33.397310000000004],[-70.57182,-33.39728],[-70.57173,-33.397270000000006],[-70.57153000000001,-33.397330000000004],[-70.57133,-33.39791],[-70.57121000000001,-33.398250000000004],[-70.57106,-33.398500000000006],[-70.57043,-33.40035],[-70.56976,-33.40227],[-70.56971,-33.402390000000004],[-70.56920000000001,-33.40377],[-70.56885000000001,-33.40473],[-70.56839000000001,-33.406040000000004],[-70.56824,-33.406420000000004],[-70.56827000000001,-33.406560000000006],[-70.56826000000001,-33.40666],[-70.56773000000001,-33.407790000000006],[-70.56759000000001,-33.408150000000006],[-70.56728000000001,-33.40885],[-70.56711,-33.409330000000004],[-70.56695,-33.40979]],"estimatedDistance":4334,"startLocation":{"lat":-33.3908833,"lon":-70.54620129999999,"loc":[-70.54620129999999,-33.3908833],"placeId":null,"stopId":"655d11d88a5a1a1ff0328466"},"endLocation":{"lat":-33.4098734,"lon":-70.5673477,"loc":[-70.5673477,-33.4098734],"placeId":null,"stopId":"655d11d88a5a1a1ff0328464","referencePoint":true},"placeWaitTime":0,"reason":"","linkedDeparture":null,"reservationsToLink":[],"isPastService":false,"communityId":"","placeId":null,"stopId":"655d11d88a5a1a1ff0328464","serviceHour":"","placeName":"Mall Apumanque Avenida Manquehue Sur, Las Condes, Chile","placeLongName":"Mall Apumanque Avenida Manquehue Sur, Las Condes, Chile","hourIsDepartureOrArrival":"arrival","roundedDistance":"4.33","travelTime":529,"originalEstimatedArrival":"","originalServiceDate":"","originalTravelTime":529,"adjustmentFactor":1,"totalReservations":1,"arrivalDate":"${arrival_date}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${rddId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddId}


####################################################
##Get Routes As Driver Pendiente

#######################################################

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

Get ODD Details
    [Documentation]     Verifica que la solicitud ODD tenga driver y vehicle
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/odd/${rddId}?community=653fd601f90509541a748683&populate=true
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=    Set Variable    ${response.json()}
    Should Contain    ${json}    driverId    msg=❌ 'driverId' key is missing in the JSON response
    Should Contain    ${json}    vehicleId   msg=❌ 'vehicleId' key is missing in the JSON response
Edit ODD
    [Documentation]     Verifica que la solicitud ODD tenga driver y vehicle después de la edición
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/${rddId}?community=653fd601f90509541a748683
    ...    data={"superCommunityId":"653fd68233d83952fafcd4be","adminId":{"_id":"66d75c62a1b7bc9a1dd231c6","communities":[{"_id":"66d75c62a1b7bc9a1dd231c7","communityId":"653fd601f90509541a748683","confirmed":true,"isAdmin":true,"createdAt":"2024-09-03T18:58:42.313Z","updatedAt":"2024-09-03T18:58:42.313Z"}],"name":"Nico Super Admin 3","username":"nicolas+superadmin3@allrideapp.com"},"adminName":"Soporte AllRide","oddSimpleFlow":false,"state":"pending","name":"RDD Common Destiny Flow","oddType":"Taxis Coni y Nico","placeLat":-33.3908833,"placeLon":-70.54620129999999,"serviceCost":0,"calculatedCosts":{},"apportionByParams":[],"direction":"out","comments":"","serviceDate":"2025-06-16T13:15:39.000Z","extraMinutes":0,"estimatedArrival":"2025-06-16T14:45:57.000Z","reservations":[{"manuallyBooked":true,"userId":"65e8e076337a90a35ba6e8dd","stopId":"65e975a20bdb0bb5d4008898","placeId":null,"order":1,"estimatedArrival":"2025-06-16T14:45:57.000Z","distances":{"fromPrevious":132475,"toNext":0,"distanceToLocation":132475,"pctToLocation":1}}],"waypoints":[[-70.54604,-33.39123],[-70.54690000000001,-33.391510000000004],[-70.54685,-33.39168],[-70.54689,-33.39184],[-70.54698,-33.3919],[-70.54719,-33.39193],[-70.54751,-33.391270000000006],[-70.54766000000001,-33.390950000000004],[-70.54785000000001,-33.39038],[-70.54820000000001,-33.38965],[-70.54827,-33.389500000000005],[-70.54875000000001,-33.38969],[-70.54971,-33.39011],[-70.55201000000001,-33.391070000000006],[-70.55657000000001,-33.39271],[-70.57026,-33.397510000000004],[-70.57887000000001,-33.400890000000004],[-70.58358000000001,-33.40289],[-70.58597,-33.404140000000005],[-70.58887,-33.404650000000004],[-70.5908,-33.40518],[-70.59673000000001,-33.407270000000004],[-70.59841,-33.40791],[-70.59964000000001,-33.40813],[-70.60343,-33.40822],[-70.60518,-33.40845],[-70.60597,-33.409060000000004],[-70.60663000000001,-33.409760000000006],[-70.60696,-33.410740000000004],[-70.60719,-33.412600000000005],[-70.60770000000001,-33.415130000000005],[-70.60851000000001,-33.416540000000005],[-70.60974,-33.41781],[-70.61318,-33.420500000000004],[-70.6152,-33.421240000000004],[-70.61763,-33.42194],[-70.61914,-33.42239],[-70.62086000000001,-33.423190000000005],[-70.62188,-33.423950000000005],[-70.623,-33.425360000000005],[-70.62331,-33.42613],[-70.62392000000001,-33.42792],[-70.62456,-33.42927],[-70.62608,-33.431270000000005],[-70.62768000000001,-33.432790000000004],[-70.62952,-33.43394],[-70.63383,-33.435880000000004],[-70.63451,-33.435950000000005],[-70.63636000000001,-33.43567],[-70.63979,-33.434870000000004],[-70.64687,-33.43323],[-70.65178,-33.43206],[-70.65504,-33.431340000000006],[-70.65637000000001,-33.43088],[-70.65718000000001,-33.43043],[-70.65913,-33.42978],[-70.66007,-33.429],[-70.66096,-33.428650000000005],[-70.66146,-33.4287],[-70.66222,-33.429030000000004],[-70.66260000000001,-33.42933],[-70.66282000000001,-33.42991],[-70.66261,-33.43045],[-70.66169000000001,-33.4311],[-70.66095,-33.43215],[-70.66074,-33.432930000000006],[-70.66065,-33.43397],[-70.66029,-33.436460000000004],[-70.65990000000001,-33.43977],[-70.66048,-33.44279],[-70.66079,-33.444810000000004],[-70.66072000000001,-33.445710000000005],[-70.6603,-33.447700000000005],[-70.65936,-33.450630000000004],[-70.65835000000001,-33.454150000000006],[-70.65791,-33.455040000000004],[-70.65731000000001,-33.45568],[-70.65688,-33.45653],[-70.65677000000001,-33.45745],[-70.65696000000001,-33.458800000000004],[-70.65709000000001,-33.460150000000006],[-70.65695000000001,-33.462250000000004],[-70.65650000000001,-33.46981],[-70.65638000000001,-33.4714],[-70.65478,-33.47397],[-70.65464,-33.474380000000004],[-70.65464,-33.47542],[-70.65507000000001,-33.47652],[-70.65574000000001,-33.47816],[-70.65684,-33.48037],[-70.66218,-33.4917],[-70.66552,-33.498830000000005],[-70.67614,-33.52118],[-70.67977,-33.52846],[-70.6846,-33.537510000000005],[-70.68612,-33.5403],[-70.68731000000001,-33.541650000000004],[-70.69697000000001,-33.54768],[-70.70670000000001,-33.553610000000006],[-70.70919,-33.55489],[-70.71018000000001,-33.55604],[-70.71048,-33.556540000000005],[-70.71063000000001,-33.557280000000006],[-70.71054000000001,-33.55957],[-70.71208,-33.56927],[-70.71333,-33.577400000000004],[-70.71499,-33.590070000000004],[-70.71629,-33.60079],[-70.71682000000001,-33.604710000000004],[-70.71690000000001,-33.60699],[-70.7167,-33.60967],[-70.71491,-33.62192],[-70.71355000000001,-33.63111],[-70.71208,-33.641130000000004],[-70.71157000000001,-33.64533],[-70.71171000000001,-33.646910000000005],[-70.71237,-33.648860000000006],[-70.71474,-33.654360000000004],[-70.71678,-33.65908],[-70.72023,-33.66675],[-70.72351,-33.67443],[-70.72499,-33.67784],[-70.72616000000001,-33.68099],[-70.72651,-33.683980000000005],[-70.72642,-33.685860000000005],[-70.72594000000001,-33.688370000000006],[-70.72556,-33.689550000000004],[-70.72481,-33.69196],[-70.72279,-33.6982],[-70.72252,-33.69941],[-70.72239,-33.70075],[-70.72265,-33.702510000000004],[-70.72311,-33.704660000000004],[-70.72352000000001,-33.70644],[-70.72537000000001,-33.7136],[-70.72687,-33.719080000000005],[-70.72886000000001,-33.723150000000004],[-70.73275000000001,-33.730880000000006],[-70.73467000000001,-33.73452],[-70.73566000000001,-33.736700000000006],[-70.73773,-33.741020000000006],[-70.74022000000001,-33.75182],[-70.74332000000001,-33.77074],[-70.74788000000001,-33.79845],[-70.75166,-33.82126],[-70.75338,-33.832330000000006],[-70.75283,-33.835],[-70.75194,-33.838660000000004],[-70.7497,-33.84794],[-70.74841,-33.853300000000004],[-70.74783000000001,-33.85792],[-70.74773,-33.858940000000004],[-70.74738,-33.860110000000006],[-70.74645000000001,-33.86133],[-70.74296000000001,-33.86422],[-70.74210000000001,-33.86526],[-70.73825000000001,-33.877050000000004],[-70.73662,-33.882250000000006],[-70.73561000000001,-33.88841],[-70.73478,-33.894380000000005],[-70.73423000000001,-33.89804],[-70.73421,-33.898990000000005],[-70.73442,-33.90046],[-70.73495000000001,-33.902640000000005],[-70.73472000000001,-33.903890000000004],[-70.73428000000001,-33.90469],[-70.73339,-33.905730000000005],[-70.72859000000001,-33.91021],[-70.72675000000001,-33.911860000000004],[-70.72526,-33.91344],[-70.72486,-33.91422],[-70.72463,-33.91541],[-70.72463,-33.916160000000005],[-70.72498,-33.918490000000006],[-70.72511,-33.919340000000005],[-70.72492000000001,-33.92025],[-70.72470000000001,-33.920770000000005],[-70.72389000000001,-33.92186],[-70.72131,-33.9236],[-70.71861000000001,-33.925560000000004],[-70.71783,-33.926520000000004],[-70.71740000000001,-33.92729],[-70.71657,-33.92893],[-70.71613,-33.929840000000006],[-70.71375,-33.93468],[-70.71282000000001,-33.93665],[-70.71246000000001,-33.93798],[-70.7121,-33.942660000000004],[-70.71201,-33.9455],[-70.71270000000001,-33.948730000000005],[-70.71324,-33.95085],[-70.71351,-33.95225],[-70.71354000000001,-33.95349],[-70.71323000000001,-33.95487],[-70.71224000000001,-33.95747],[-70.71009000000001,-33.96305],[-70.70777000000001,-33.96909],[-70.70415000000001,-33.978350000000006],[-70.70263,-33.982200000000006],[-70.70113,-33.98633],[-70.70094,-33.988170000000004],[-70.70157,-33.99579],[-70.70291,-34.00914],[-70.70445000000001,-34.02488],[-70.70542,-34.03307],[-70.70571000000001,-34.03436],[-70.70653,-34.035900000000005],[-70.7077,-34.037060000000004],[-70.70861000000001,-34.03768],[-70.71143000000001,-34.03884],[-70.71404000000001,-34.03976],[-70.72331000000001,-34.04308],[-70.72679000000001,-34.04433],[-70.73213000000001,-34.04742],[-70.73748,-34.0505],[-70.74094000000001,-34.05169],[-70.74748000000001,-34.05382],[-70.74943,-34.05474],[-70.75065000000001,-34.05559],[-70.75204000000001,-34.056900000000006],[-70.75334000000001,-34.05875],[-70.75544000000001,-34.06228],[-70.75767,-34.065850000000005],[-70.76012,-34.06971],[-70.76174,-34.07193],[-70.76876,-34.07945],[-70.77313000000001,-34.08402],[-70.77437,-34.08588],[-70.77559000000001,-34.08914],[-70.77794,-34.096430000000005],[-70.77969,-34.10208],[-70.78012000000001,-34.10757],[-70.7805,-34.11527],[-70.78110000000001,-34.119820000000004],[-70.78427,-34.133070000000004],[-70.78624,-34.1413],[-70.78678000000001,-34.14359],[-70.78790000000001,-34.146860000000004],[-70.79251000000001,-34.156580000000005],[-70.79357,-34.15968],[-70.79399000000001,-34.162200000000006],[-70.79406,-34.165240000000004],[-70.79379,-34.16756],[-70.79260000000001,-34.172160000000005],[-70.78825,-34.18766],[-70.7857,-34.19686],[-70.78514000000001,-34.199960000000004],[-70.78485,-34.20461],[-70.78494,-34.20712],[-70.78536000000001,-34.2096],[-70.78651,-34.21262],[-70.78935,-34.218430000000005],[-70.79289,-34.22581],[-70.79326,-34.2282],[-70.79296000000001,-34.23024],[-70.7924,-34.23174],[-70.79194000000001,-34.23368],[-70.79212000000001,-34.235400000000006],[-70.79338,-34.23798],[-70.79426000000001,-34.23955],[-70.79539000000001,-34.241490000000006],[-70.79646000000001,-34.243390000000005],[-70.79986000000001,-34.249320000000004],[-70.804,-34.25658],[-70.81042000000001,-34.26778],[-70.81808000000001,-34.281130000000005],[-70.82008,-34.28463],[-70.82143,-34.28699],[-70.82221000000001,-34.28884],[-70.8228,-34.291740000000004],[-70.82454,-34.30041],[-70.82602,-34.30785],[-70.82648,-34.31004],[-70.82743,-34.31291],[-70.82917,-34.318110000000004],[-70.83091,-34.32348],[-70.83442000000001,-34.33382],[-70.83532000000001,-34.33652],[-70.8361,-34.33807],[-70.84271000000001,-34.34967],[-70.84856,-34.359820000000006],[-70.86354,-34.38593],[-70.8708,-34.39865],[-70.87308,-34.402280000000005],[-70.87349,-34.40243],[-70.87384,-34.4022],[-70.87381,-34.40189],[-70.87344,-34.40173],[-70.87059,-34.40189],[-70.86416000000001,-34.402590000000004],[-70.86085,-34.40294],[-70.85957,-34.40303],[-70.85933,-34.40292],[-70.85919000000001,-34.402710000000006],[-70.85853,-34.40214],[-70.85822,-34.401590000000006],[-70.85849,-34.401650000000004],[-70.85879,-34.401720000000005],[-70.85900000000001,-34.4018],[-70.85915,-34.401880000000006],[-70.85966,-34.40196],[-70.86006,-34.40194],[-70.8605,-34.402370000000005],[-70.86077,-34.402800000000006],[-70.86080000000001,-34.402860000000004]],"estimatedDistance":132475,"startLocation":{"lat":-33.3908833,"lon":-70.54620129999999,"loc":[-70.54620129999999,-33.3908833],"placeId":null,"stopId":"655d11d88a5a1a1ff0328466"},"endLocation":{"lat":-34.4028433,"lon":-70.8608394,"loc":[-70.8608394,-34.4028433],"placeId":null,"stopId":"65e975a20bdb0bb5d4008898","referencePoint":true},"placeWaitTime":0,"reason":"","linkedDeparture":null,"linkedDepartures":[],"reservationsToLink":[],"cabify":{"productId":null},"asap":false,"isEmergency":false,"isPastService":false,"communityId":"653fd601f90509541a748683","placeId":null,"stopId":"655d11d88a5a1a1ff0328466","serviceHour":"","placeName":"Alto Las Condes Avenida Presidente Kennedy Lateral, Las Condes, Chile","placeLongName":"Alto Las Condes Avenida Presidente Kennedy Lateral, Las Condes, Chile","hourIsDepartureOrArrival":"arrival","roundedDistance":"132.47","travelTime":5418,"originalEstimatedArrival":"","originalServiceDate":"","originalTravelTime":5418,"adjustmentFactor":1,"totalReservations":1,"driverCode":"753","driverId":"${driverId}","communities":["653fd601f90509541a748683"],"arrivalDate":"2025-06-16T14:45:57.000Z"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=    Set Variable    ${response.json()}
    Should Contain    ${json}    driverId    msg=❌ 'driverId' key is missing in the JSON response
    Should Contain    ${json}    vehicleId   msg=❌ 'vehicleId' key is missing in the JSON response
