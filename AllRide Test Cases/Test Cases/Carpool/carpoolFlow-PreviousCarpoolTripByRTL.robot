[Documentation] Plantilla


*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Library     RPA.Smartsheet
Resource    ../Variables/variablesStage.robot
Library     WebSocketClient
Library    carpool_flow.py



*** Variables ***
${STAGE_URL}    https://stage.allrideapp.com
${WS_BASE}      ws://stage.allrideapp.com/socket.io/?EIO=3&transport=websocket
${USER_ID}      68a75a4e7811f4c78b962442
${USER_ID2}     68b7576fc6280f9b167a25c8
${TZ_OFFSET}    -03:00


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

2 hours local
    ${date}=    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}=    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}=    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}=    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Generar Fecha ISO8601 En UTC
    # Obtener hora actual en UTC
    ${now}=    Get Current Date    time_zone=UTC    exclude_millis=no

    # Formatear en ISO8601 con milisegundos .000
    ${formatted}=    Convert Date    ${now}    result_format=%Y-%m-%dT%H:%M:%S.000

    # Agregar el offset -00:00
    ${iso8601}=    Set Variable    ${formatted}${TZ_OFFSET}

    Log    Fecha generada en UTC: ${iso8601}
    Set Global Variable    ${iso8601}

Login User With Email(Obtain Token) Carpool 1
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${jsonBody}=    Set Variable    {"username":"nicolas+carpool3@allrideapp.com","password":"Lolowerty21@"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json

    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    List Should Contain Value    ${response.json()}    accessToken    No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${realTimeToken}=    Set Variable    ${response.json()}[realTimeToken]
    ${accessTokenCarpool1}=    Evaluate    "${accessToken}"
    Set Global Variable    ${accessTokenCarpool1}
    Set Global Variable    ${realTimeToken}

Login User With Email(Obtain Token) Carpool 2
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${jsonBody}=    Set Variable    {"username":"nicolas+carpool4@allrideapp.com","password":"Lolowerty21@"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    List Should Contain Value    ${response.json()}    accessToken    No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenCarpool2}=    Evaluate    "${accessToken}"
    Set Global Variable    ${accessTokenCarpool2}
    ${realTimeTokenUser}=    Set Variable    ${response.json()}[realTimeToken]
    Set Global Variable    ${realTimeTokenUser}

## Vista Principal Carpool

Get trip list at start
    [Documentation]    Lista de viajes en vista principal de carpool
    skip
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/trips/list
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # La cantidad total de viajes que deben aparecen deben ser 3
    # El nombre owner de los dos primeros viajes debe ser Barbara

    ${json}=    Set Variable    ${response.json()}
    ${lastTripId}=    Set Variable    ${json}[-1][_id]
    ${trip1OwnerName}=    Set Variable    ${json}[0][owner][name]
    ${trip2OwnerName}=    Set Variable    ${json}[1][owner][name]
    ${trip3OwnerName}=    Set Variable    ${json}[2][owner][name]

    Should Be Equal As Strings
    ...    ${trip1OwnerName}
    ...    Barbara Lisboa
    ...    msg= name should be Barbara Lisboa but got ${trip1OwnerName}
    Should Be Equal As Strings
    ...    ${trip2OwnerName}
    ...    Barbara Lisboa
    ...    msg= name should be Barbara Lisboa but got ${trip2OwnerName}
    Should Be Equal As Strings
    ...    ${trip3OwnerName}
    ...    Paulina Pasajero
    ...    msg= name should be Paulina Pasajero but got ${trip3OwnerName}

Get community places (CONSULTAR BODY CRIS O JC)
    [Documentation]    Obtener los lugares de la comunuidad
    skip

    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    Run Keyword And Expect Error    HTTP:401 invalid autentication    POST On Session
    ...    mysesion
    ...    url=/api/v1/communities/places
    ...    data=""
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}

########################################## Crear ruta de un solo viaje está pendiente############################################

Create recurrent route as driver (user1)
    [Documentation]    Crear una ruta recurrente como conductor(usuario 1)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/trips/
    ...    data={"allowsSectionCost":false,"aproxWaypoints":{"coordinates":[[-70.85381,-34.41107],[-70.85367,-34.41072],[-70.8535,-34.41007],[-70.85308,-34.40853],[-70.85251,-34.4076],[-70.85206,-34.40705],[-70.85159,-34.40653],[-70.85126,-34.4062],[-70.85087,-34.40583],[-70.85045,-34.40546],[-70.85003,-34.40502],[-70.84913,-34.40427],[-70.84813,-34.40353],[-70.84789,-34.40336],[-70.84742,-34.40297],[-70.84739,-34.40294],[-70.84736,-34.40283],[-70.84736,-34.4028],[-70.84715,-34.40279],[-70.84644,-34.40275],[-70.84573,-34.40269],[-70.8454,-34.40264],[-70.84433,-34.40239],[-70.84376,-34.40229],[-70.84337,-34.40227],[-70.84272,-34.40227],[-70.84241,-34.40229],[-70.84184,-34.40239],[-70.84125,-34.4025],[-70.83714,-34.40315],[-70.83642,-34.40327],[-70.8354,-34.40344],[-70.83488,-34.40357],[-70.83406,-34.40379],[-70.83375,-34.4039],[-70.83302,-34.4042],[-70.83145,-34.40482],[-70.83095,-34.40499],[-70.8303,-34.40523],[-70.82964,-34.40545],[-70.8294,-34.40552],[-70.82864,-34.40566],[-70.82751,-34.40584],[-70.82674,-34.40595],[-70.82589,-34.40601],[-70.8242,-34.40606],[-70.82344,-34.4061],[-70.8232,-34.40616],[-70.82282,-34.40633],[-70.82265,-34.40642],[-70.82228,-34.40661],[-70.82046,-34.40749],[-70.81975,-34.40782],[-70.81846,-34.40853],[-70.8176,-34.409],[-70.81725,-34.40913],[-70.81608,-34.40943],[-70.81525,-34.40961],[-70.81484,-34.40975],[-70.81446,-34.40992],[-70.81407,-34.41013],[-70.81334,-34.41055],[-70.81312,-34.41068],[-70.81286,-34.41062],[-70.81253,-34.41052],[-70.8121,-34.41037],[-70.80991,-34.40956],[-70.80924,-34.4093],[-70.80898,-34.40916],[-70.80834,-34.40865],[-70.80719,-34.40769],[-70.80685,-34.40737],[-70.80617,-34.40667],[-70.80582,-34.40635],[-70.80503,-34.40567],[-70.80483,-34.40554],[-70.8044,-34.40537],[-70.80415,-34.40527],[-70.80403,-34.40516],[-70.80382,-34.40491],[-70.80369,-34.40478],[-70.80358,-34.4047],[-70.8035,-34.40466],[-70.80312,-34.40457],[-70.80267,-34.40449],[-70.80251,-34.40444],[-70.80206,-34.40428],[-70.80188,-34.40425],[-70.80164,-34.40424],[-70.80096,-34.40423],[-70.80057,-34.4042],[-70.80041,-34.40421],[-70.80014,-34.40424],[-70.79997,-34.40422],[-70.79917,-34.40404],[-70.79892,-34.40455],[-70.79848,-34.40551],[-70.7984,-34.40561],[-70.79822,-34.40577],[-70.79717,-34.40651],[-70.797,-34.40664],[-70.79688,-34.40679],[-70.79667,-34.40719],[-70.79651,-34.40748],[-70.7962,-34.40792],[-70.79594,-34.4078],[-70.79534,-34.40744],[-70.79477,-34.4071],[-70.79366,-34.40644],[-70.79082,-34.40485],[-70.78907,-34.40384],[-70.78692,-34.40257],[-70.78458,-34.40116],[-70.78446,-34.40109],[-70.78438,-34.40108],[-70.78428,-34.40113],[-70.78417,-34.4012],[-70.78407,-34.40119],[-70.78353,-34.4009],[-70.78304,-34.40056],[-70.7827,-34.40029],[-70.78251,-34.40016],[-70.78235,-34.40008],[-70.78271,-34.3996],[-70.78272,-34.39955],[-70.78254,-34.39927],[-70.78226,-34.39882],[-70.78216,-34.39857],[-70.78178,-34.39746],[-70.78166,-34.39704],[-70.78167,-34.39695],[-70.78207,-34.39635],[-70.78252,-34.39578],[-70.78226,-34.39571],[-70.78214,-34.39566],[-70.78236,-34.39534],[-70.78264,-34.39501],[-70.78255,-34.3948],[-70.78238,-34.39462]],"type":"LineString"},"codedRoute":"d|_qEhsmoLeA[aCa@sHsAyDqBmByAgBAaAaAiAmAiAsAwAsAuCsDsCgEa@o@mAAEEUEE?Ai@GmCKmCIaAq@uESqBCmA?aCB@RqBTuB`CuXVoC`@kEXgBj@cDT@z@qCzByH`@cBn@aCj@cCLo@ZwCb@aFTyCJiDHqIFwCJo@`@kAPa@d@iAnDkJ`AmClCaG|AkDXeAz@iFb@eDZqA`@kAh@mArAqCXk@Ks@SaA]uAaDuLs@eC[s@eB_C_EeF_AcAkCgC_AeAgCCYg@a@uASq@UWq@i@YYOUGOQkAOyAI_@_@yAEc@Ao@AgCEmA@_@Du@Ca@c@_DdBq@~DwARO^c@rCqEXa@WnAi@x@_@vA@Ws@gAwBcAqBcCEHwPiEIFmLyGsMMWAOHSLUASy@kBcAaBu@cAYe@O_@_BfAI@w@c@yAw@q@SEkAsAWQ@wBnAqBxAMs@IW_Aj@aAv@i@Qc@a@","comment":"","cost":0,"currency":"","destination":{"communityId":"","icon":"","location":[-70.7819,-34.3945],"longName":"Media luna cerrillos","placeId":"6654d4c8713b9a5184cfe1de","reference":"","shortName":"Media Luna Cerrillos"},"dropoutPlaces":[],"fee":0,"filed":false,"followerShards":[],"followers":[],"followersData":[],"_id":"","tripInstances":[],"new":true,"origin":{"communityId":"","icon":"","location":[-70.8537,-34.4111],"longName":"Hospital Rengo","placeId":"","reference":"","shortName":"Hospital Rengo"},"pending":[],"pendingsData":[],"pickupPlaces":[],"recurrent":false,"restrictions":[{"_id":"","restrictionType":"public"}],"seats":4,"sectionCost":true,"startDate":"2025-09-29T17:44:13.666-04:00","studentFee":false,"timezone":"America/Santiago","tripDates":[{"day":"wednesday","_id":"","time":"1970-01-01T18:38:00.000-03:00"}],"userId":""}
    ...    headers=${headers}
    ${code}=    Convert To String    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200

    ${json}=    Set Variable    ${response.json()}
    ${tripId}=    Set Variable    ${json}[_id]
    Set Global Variable    ${tripId}

    # ✅ Privacidad

    ${restriction}=    Set Variable    ${json}[restrictions][0][restrictionType]
    Should Be Equal As Strings    ${restriction}    public    msg=restriction should be public but got ${restriction}

    # ✅ Basic status
    Should Not Be Empty    ${tripId}    # ✅ Trip must have an internal ID

    # ✅ Origin & Destination
    Should Be Equal As Strings    ${json["origin"]["longName"]}    Hospital Rengo    msg
    Should Be Equal As Strings    ${json["destination"]["shortName"]}    Media Luna Cerrillos

    # ✅ Owner
    Should Contain    ${json["owner"]["communities"]}    6654ae4eba54fe502d4e4187

    # ✅ Seats & Distance
    Should Be Equal As Numbers    ${json["seats"]}    4
    Should Be True    ${json["distance"]} > 0

    # ✅ Trip Dates
    Length Should Be    ${json["tripDates"]}    1
    Should Be Equal As Strings    ${json["tripDates"][0]["day"]}    wednesday

    # ✅ Restrictions
    Should Be Equal As Strings    ${json["restrictions"][0]["restrictionType"]}    public

    # ✅ Suggestions (esto depende de si tu backend realmente retorna esta sección, puedes comentarlo si no aplica)
    Run Keyword And Ignore Error    Should Be Equal As Strings    ${json["suggestions"]["enabled"]}    True

    # ❌ Validaciones de error explícitas (por si falla alguna clave esperada)
    Run Keyword Unless
    ...    '${json["origin"]["longName"]}' == 'Hospital Rengo'
    ...    Fail
    ...    ❌ Origin longName does not match expected
    Run Keyword Unless
    ...    '${json["destination"]["shortName"]}' == 'Media Luna Cerrillos'
    ...    Fail
    ...    ❌ Destination shortName does not match expected
    Run Keyword Unless    ${json["seats"]} == 4    Fail    ❌ Seats count is incorrect, expected 4
    Run Keyword Unless    len(${json["tripDates"]}) == 1    Fail    ❌ Trip should have exactly 1 tripDate
    Run Keyword Unless
    ...    '${json["restrictions"][0]["restrictionType"]}' == 'public'
    ...    Fail
    ...    ❌ Restriction type must be 'public'

##Vista principal carpool luego de crear una ruta recurrente

Get route just created(Driver) And TripInstances
    [Documentation]    Obtener la ruta recién creada y los tripInstances, corresponden a los días en los que se genera cada ruta
    skip

    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/tripinstances/for_trip/${tripId}
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${trips}=    Set Variable    ${response.json()}

    # ✅ Validate total count is 5
    Length Should Be    ${trips}    5
    ...    msg=❌ Expected 5 trip instances, but got a different number

    ${index}=    Set Variable    1
    FOR    ${trip}    IN    @{trips}
        # ✅ Common validations
        Should Be Equal As Strings    ${trip["status"]}    published
        ...    msg=❌ Trip instance status is not 'published'

        Should Be Equal As Strings    ${trip["recurrent"]}    True
        ...    msg=❌ Trip instance should be recurrent

        Should Not Be Empty    ${trip["_id"]}
        ...    msg=❌ Trip instance missing _id

        Should Not Be Empty    ${trip["tripId"]}
        ...    msg=❌ Trip instance missing tripId

        # ✅ Save _id as global variables
        Set Global Variable    ${tripinstance${index}}    ${trip["_id"]}
        ${index}=    Evaluate    ${index} + 1
    END

    Log To Console    TripInstance1: ${tripinstance1}
    Log To Console    TripInstance2: ${tripinstance2}
    Log To Console    TripInstance3: ${tripinstance3}
    Log To Console    TripInstance4: ${tripinstance4}
    Log To Console    TripInstance5: ${tripinstance5}

Get route just created(Driver) And TripInstances 2
    [Documentation]    Obtener la ruta recién creada y los tripInstances, corresponden a los días en los que se genera cada ruta

    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/tripinstances/for_trip/${tripId}
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${trips}=    Set Variable    ${response.json()}

    ${tripinstance1}=    Set Variable    ${trips}[0][_id]

    Set Global Variable    ${tripinstance1}

# Buscador de rutas

Search Route And Validate ID (User 2)
    [Documentation]    Buscar la ruta recién creada mediante su ID como usuario 2

    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/search/coordinates?country=cl&origin_lat=-34.4111&origin_lon=-70.8537&destination_lat=-34.3945&destination_lon=-70.7819&origin_name=Hospital%20Rengo&destination_name=Media%20Luna%20Cerrillos&origin_place_id=6654d4acba54fe502d4e6b6a&destination_place_id=6654d4c8713b9a5184cfe1de
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool2}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${expected_id}=    Set Variable    6757525faa9f4e162d0c105e
    ${json}=    Set Variable    ${response.json()}

    ${id_found}=    Set Variable    False

    FOR    ${element}    IN    @{json}
        Log    Revisando ID: ${element["_id"]}
        IF    '${element["_id"]}' == '${expected_id}'
            Log    ✅ ID encontrado: ${expected_id}
            ${id_found}=    Set Variable    True
            BREAK
        END
    END

    IF    not ${id_found}
        Fail    ❌    Could not find the expected ID (${expected_id}) in the /search/coordinates response.
    END

# Seguir ruta

Follow Route(User 2)
    [Documentation]    Seguir ruta recién encontrada como usuario

    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool2}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/trips/follow/${tripId}
    ...    data={"pickupPointLat":-34.4111,"pickupPointLon":-70.8537,"pickupPointName":"Punto de inicio","dropoutPointLat":-33.4570,"dropoutPointLon":-70.6500,"dropoutPointName":"Punto de bajada","message":"Hola! Me interesa este viaje","shard":"cl","searchOrigin":null,"searchDestination":null,"originCenter":null,"destinationCenter":null}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}

Get requested user following route as Driver
    [Documentation]    Verificar la información del usuario que está solicitando unirse como conductor

    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/users/68b7576fc6280f9b167a25c8
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user}=    Set Variable    ${response.json()}

    # ✅ General info
    Should Be Equal As Strings    ${user["active"]}    True
    ...    msg=❌ User should be active but is not

    Should Not Be Empty    ${user["_id"]}
    ...    msg=❌ User missing _id

    Should Be Equal As Strings    ${user["country"]}    cl
    ...    msg=❌ User country should be 'cl'

    Should Be Equal As Strings    ${user["currency"]}    clp
    ...    msg=❌ User currency should be 'clp'

    Should Not Be Empty    ${user["name"]}
    ...    msg=❌ User missing name

    # ✅ Personal info
    Should Not Be Empty    ${user["personalInfo"]["rut"]}
    ...    msg=❌ User rut is missing

    # phoneNumber is expected to be null
    Should Be Equal As Strings    ${user["personalInfo"]["phoneNumber"]}    ${None}
    ...    msg=❌ User phoneNumber should be null

    # ✅ Communities
    Length Should Be    ${user["communities"]}    1
    ...    msg=❌ User should belong to exactly 1 community

    ${community}=    Set Variable    ${user["communities"][0]}
    Should Be Equal As Strings    ${community["confirmed"]}    True
    ...    msg=❌ Community should be confirmed

    Should Be Equal As Strings    ${community["communityId"]}    6654ae4eba54fe502d4e4187
    ...    msg=❌ Community ID is not the expected one

    # ✅ Private bus
    Should Be Equal As Strings    ${community["privateBus"]["enabled"]}    True
    ...    msg=❌ Private bus should be enabled

    Should Not Be Empty    ${community["privateBus"]["oDDServices"]}
    ...    msg=❌ User should have at least one ODD service

    # ✅ Auth tokens
    Should Not Be Empty    ${user["auth"]["accessToken"]}
    ...    msg=❌ User is missing accessToken

    Should Not Be Empty    ${user["auth"]["realtimeToken"]}
    ...    msg=❌ User is missing realtimeToken

    Should Not Be Empty    ${user["auth"]["chatToken"]}
    ...    msg=❌ User is missing chatToken

Accept follower as Driver
    Skip
    [Documentation]    Aceptar seguidor del viaje como Conductor

    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/trips/accept/${tripId}/68d581be1ee85dd206e05804
    ...    data={"pickupPointLat":-34.4111,"pickupPointLon":-70.8537}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${trip}=    Set Variable    ${response.json()}

    # ✅ General validations
    Should Not Be Empty    ${trip["_id"]}
    ...    msg=❌ Trip is missing _id

    Should Be Equal As Strings    ${trip["recurrent"]}    True
    ...    msg=❌ Trip should be recurrent but is not

    Should Be Equal As Strings    ${trip["currency"]}    clp
    ...    msg=❌ Trip currency should be 'clp'

    Should Be Equal As Strings    ${trip["timezone"]}    America/Santiago
    ...    msg=❌ Trip timezone should be 'America/Santiago'

    Should Not Be Empty    ${trip["codedRoute"]}
    ...    msg=❌ Trip missing codedRoute

    # ✅ Origin and destination
    Should Be Equal As Strings    ${trip["origin"]["longName"]}    Hospital Rengo
    ...    msg=❌ Trip origin longName mismatch

    Should Be Equal As Strings    ${trip["destination"]["longName"]}    Media luna cerrillos
    ...    msg=❌ Trip destination longName mismatch

    Should Be Equal As Strings    ${trip["destination"]["placeId"]}    6654d4c8713b9a5184cfe1de
    ...    msg=❌ Destination placeId mismatch

    # ✅ Owner
    Should Not Be Empty    ${trip["owner"]["id"]}
    ...    msg=❌ Trip owner missing id

    Should Be Equal As Strings    ${trip["owner"]["name"]}    Nico QA Carpool 1
    ...    msg=❌ Trip owner name mismatch

    Length Should Be    ${trip["owner"]["communities"]}    1
    ...    msg=❌ Trip owner should belong to 1 community

    # ✅ Trip Dates
    Length Should Be    ${trip["tripDates"]}    1
    ...    msg=❌ Trip should contain exactly 1 tripDate

    ${date}=    Set Variable    ${trip["tripDates"][0]}
    Should Be Equal As Strings    ${date["day"]}    wednesday
    ...    msg=❌ Trip date day should be 'wednesday'

    Should Not Be Empty    ${date["time"]}
    ...    msg=❌ Trip date missing time

    # ✅ Pickup & Dropout Places
    Length Should Be    ${trip["pickupPlaces"]}    1
    ...    msg=❌ Trip should contain exactly 1 pickupPlace

    Length Should Be    ${trip["dropoutPlaces"]}    1
    ...    msg=❌ Trip should contain exactly 1 dropoutPlace

    Should Be Equal As Strings    ${trip["pickupPlaces"][0]["name"]}    Punto de inicio
    ...    msg=❌ Pickup place name mismatch

    Should Be Equal As Strings    ${trip["dropoutPlaces"][0]["name"]}    Punto de bajada
    ...    msg=❌ Dropout place name mismatch

    # ✅ Followers Data
    Length Should Be    ${trip["followersData"]}    1
    ...    msg=❌ Trip should contain exactly 1 follower

    ${follower}=    Set Variable    ${trip["followersData"][0]}
    Should Be Equal As Strings    ${follower["name"]}    Nico QA Carpool 2
    ...    msg=❌ Follower name mismatch

    Should Be Equal As Strings    ${follower["accepted"]}    True
    ...    msg=❌ Follower should be accepted


Start carpool departure
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/tripinstances/start/${tripinstance1}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessTokenDeparture}=    Set Variable    []    ###Reeemplazar

Carpool Realtime - Realtime Flow Python
    ${WS_URL_DRIVER}=    Set Variable    ${WS_BASE}&token=${realTimeToken}
    ${WS_URL_USER}=      Set Variable    ${WS_BASE}&token=${realTimeTokenUser}

    ${result}=    Run Carpool Flow
    ...    ${WS_URL_DRIVER}
    ...    ${WS_URL_USER}
    ...    ${DRIVER_ID}
    ...    ${USER_ID}
    ...    ${tripInstance1}

    Should Be Equal As Strings    ${result}    PASS

Get Chats
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool2}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/chat/public/${tripId}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}

Get Chats (user)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool2}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/chat/messages/${tripId}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}

Get Chats (driver)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/chat/messages/${tripId}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}

End trip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/tripinstances/end/${tripinstance1}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${trip_instance}=    Set Variable    ${response.json()}

    # ✅ General validations
    Should Not Be Empty    ${trip_instance["_id"]}
    ...    msg=❌ Trip instance is missing _id

    Should Not Be Empty    ${trip_instance["boardingDetails"]}
    ...    msg=❌ boardingDetails should not be empty

Delete trip
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/trips/${tripId}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}

    # ✅ Check that the API responded with the correct message
    Should Be Equal As Strings    ${response["message"]}    Trip deleted
    ...    msg=❌ Expected 'Trip deleted' message, but got something else

    # ✅ Extra safeguard in case the response is empty
    Should Not Be Empty    ${response["message"]}
    ...    msg=❌ Response message is missing after deletion

##Iniciar el viaje
## Chat
## Eliminar ruta creada por mi DELETE



Login Parking
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/device/register
    ...    data={"build":"3","communityId":"6654ae4eba54fe502d4e4187","deviceId":"15af83c4-0603-437e-aeb3-f758fd492a9d","model":"SM-G780G","notificationToken":"fQNNDHrkTFmguYGm5NZ3B1:APA91bEhltZ9FwPhnPs5S1X-E-BqY0r9KPgosqXp0Fjo6Ns8cjx_DQWfMyP2Q0zBkQBR0mirNW0dS3QVb96GE7d8rZCNO9Z37Ls1EP48DyqxQlMolEPHr0k"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessTokenParking}=    Set Variable    ${json}[accessToken]
    Set Global Variable    ${accessTokenParking}

Get User QR(User2 carpool)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["68d581be1ee85dd206e05804"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUserCarpool2}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUserCarpool2}
    Log    ${qrCodeUserCarpool2}
    Log    ${code}
Get User QR(User1 carpool)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["68d581af1ee85dd206e057ee"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUserCarpool1}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUserCarpool1}
    Log    ${qrCodeUserCarpool1}
    Log    ${code}
Get User QR(User No Carpool)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["66e30a06e2b22c7d017bb492"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUserNoCarpool}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUserNoCarpool}
    Log    ${qrCodeUserNoCarpool}
    Log    ${code}
Validate parking(user carpool1 should be able to validate)
    skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/entry
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserCarpool1}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}
Validate parking(user carpool2 should be able to validate)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/entry
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserCarpool2}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}

Validate parking(no carpool should not be able to validate no precondition no space left)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=  Run Keyword And Expect Error   HTTPError: 410 Client Error: Gone for url: https://stage.allrideapp.com/api/v1/prk/lot/validate/entry   POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/entry
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserNoCarpool}"}
    ...    headers=${headers}

Exit parking(user carpool1)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/exit
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserCarpool1}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}
Exit parking(user carpool2)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/exit
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserCarpool2}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}
