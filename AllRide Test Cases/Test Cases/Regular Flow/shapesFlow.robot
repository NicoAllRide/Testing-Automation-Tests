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


Get All Shapes
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Get On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/shapes/list?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    
    Should Not Be Empty    ${response.json()}    Response was empty, no stops were found


####################################################
##Get Routes As Driver Pendiente

#######################################################


Create Shape Manually
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/shapes?community=6654ae4eba54fe502d4e4187
    ...    data={"name":"Shape RF","points":[{"loc":[-70.66219000000001,-33.456970000000005],"lat":-33.456970000000005,"lon":-70.66219000000001,"sequence":0},{"loc":[-70.66106,-33.45687],"lat":-33.45687,"lon":-70.66106,"sequence":1},{"loc":[-70.66106,-33.45687],"lat":-33.45687,"lon":-70.66106,"sequence":2},{"loc":[-70.661,-33.4568],"lat":-33.4568,"lon":-70.661,"sequence":3},{"loc":[-70.66097,-33.45673],"lat":-33.45673,"lon":-70.66097,"sequence":4},{"loc":[-70.66202000000001,-33.4568],"lat":-33.4568,"lon":-70.66202000000001,"sequence":5},{"loc":[-70.66404,-33.45696],"lat":-33.45696,"lon":-70.66404,"sequence":6},{"loc":[-70.66527,-33.45709],"lat":-33.45709,"lon":-70.66527,"sequence":7},{"loc":[-70.66607,-33.45722],"lat":-33.45722,"lon":-70.66607,"sequence":8},{"loc":[-70.66833000000001,-33.457640000000005],"lat":-33.457640000000005,"lon":-70.66833000000001,"sequence":9},{"loc":[-70.67211,-33.458310000000004],"lat":-33.458310000000004,"lon":-70.67211,"sequence":10},{"loc":[-70.67361000000001,-33.45841],"lat":-33.45841,"lon":-70.67361000000001,"sequence":11},{"loc":[-70.67505,-33.458490000000005],"lat":-33.458490000000005,"lon":-70.67505,"sequence":12},{"loc":[-70.67505,-33.458490000000005],"lat":-33.458490000000005,"lon":-70.67505,"sequence":13},{"loc":[-70.67715000000001,-33.45862],"lat":-33.45862,"lon":-70.67715000000001,"sequence":14},{"loc":[-70.67865,-33.45872],"lat":-33.45872,"lon":-70.67865,"sequence":15},{"loc":[-70.67885000000001,-33.458740000000006],"lat":-33.458740000000006,"lon":-70.67885000000001,"sequence":16},{"loc":[-70.67929000000001,-33.45877],"lat":-33.45877,"lon":-70.67929000000001,"sequence":17},{"loc":[-70.67948000000001,-33.458780000000004],"lat":-33.458780000000004,"lon":-70.67948000000001,"sequence":18},{"loc":[-70.67973,-33.458800000000004],"lat":-33.458800000000004,"lon":-70.67973,"sequence":19},{"loc":[-70.68035,-33.45884],"lat":-33.45884,"lon":-70.68035,"sequence":20},{"loc":[-70.68142,-33.458920000000006],"lat":-33.458920000000006,"lon":-70.68142,"sequence":21},{"loc":[-70.68142,-33.458920000000006],"lat":-33.458920000000006,"lon":-70.68142,"sequence":22},{"loc":[-70.68236,-33.458920000000006],"lat":-33.458920000000006,"lon":-70.68236,"sequence":23},{"loc":[-70.68279000000001,-33.45893],"lat":-33.45893,"lon":-70.68279000000001,"sequence":24},{"loc":[-70.68404000000001,-33.458980000000004],"lat":-33.458980000000004,"lon":-70.68404000000001,"sequence":25},{"loc":[-70.68471000000001,-33.45899],"lat":-33.45899,"lon":-70.68471000000001,"sequence":26},{"loc":[-70.68549,-33.459],"lat":-33.459,"lon":-70.68549,"sequence":27},{"loc":[-70.68663000000001,-33.459050000000005],"lat":-33.459050000000005,"lon":-70.68663000000001,"sequence":28},{"loc":[-70.68793000000001,-33.459],"lat":-33.459,"lon":-70.68793000000001,"sequence":29},{"loc":[-70.68821000000001,-33.45901],"lat":-33.45901,"lon":-70.68821000000001,"sequence":30},{"loc":[-70.68901000000001,-33.45902],"lat":-33.45902,"lon":-70.68901000000001,"sequence":31},{"loc":[-70.68918000000001,-33.45902],"lat":-33.45902,"lon":-70.68918000000001,"sequence":32},{"loc":[-70.69034,-33.45906],"lat":-33.45906,"lon":-70.69034,"sequence":33},{"loc":[-70.69068,-33.459070000000004],"lat":-33.459070000000004,"lon":-70.69068,"sequence":34},{"loc":[-70.69233000000001,-33.45913],"lat":-33.45913,"lon":-70.69233000000001,"sequence":35},{"loc":[-70.69233000000001,-33.45913],"lat":-33.45913,"lon":-70.69233000000001,"sequence":36},{"loc":[-70.69290000000001,-33.459320000000005],"lat":-33.459320000000005,"lon":-70.69290000000001,"sequence":37},{"loc":[-70.69334,-33.45948],"lat":-33.45948,"lon":-70.69334,"sequence":38},{"loc":[-70.69456000000001,-33.45994],"lat":-33.45994,"lon":-70.69456000000001,"sequence":39},{"loc":[-70.69504,-33.460150000000006],"lat":-33.460150000000006,"lon":-70.69504,"sequence":40},{"loc":[-70.69529,-33.46027],"lat":-33.46027,"lon":-70.69529,"sequence":41},{"loc":[-70.69599000000001,-33.46059],"lat":-33.46059,"lon":-70.69599000000001,"sequence":42},{"loc":[-70.69614,-33.460660000000004],"lat":-33.460660000000004,"lon":-70.69614,"sequence":43},{"loc":[-70.69637,-33.46078],"lat":-33.46078,"lon":-70.69637,"sequence":44},{"loc":[-70.69827000000001,-33.461690000000004],"lat":-33.461690000000004,"lon":-70.69827000000001,"sequence":45},{"loc":[-70.69875,-33.46191],"lat":-33.46191,"lon":-70.69875,"sequence":46},{"loc":[-70.69916,-33.462120000000006],"lat":-33.462120000000006,"lon":-70.69916,"sequence":47},{"loc":[-70.70047000000001,-33.462790000000005],"lat":-33.462790000000005,"lon":-70.70047000000001,"sequence":48},{"loc":[-70.70123000000001,-33.463190000000004],"lat":-33.463190000000004,"lon":-70.70123000000001,"sequence":49},{"loc":[-70.70189,-33.46343],"lat":-33.46343,"lon":-70.70189,"sequence":50},{"loc":[-70.70256,-33.46363],"lat":-33.46363,"lon":-70.70256,"sequence":51},{"loc":[-70.70256,-33.46363],"lat":-33.46363,"lon":-70.70256,"sequence":52},{"loc":[-70.70282,-33.462920000000004],"lat":-33.462920000000004,"lon":-70.70282,"sequence":53},{"loc":[-70.70295,-33.46255],"lat":-33.46255,"lon":-70.70295,"sequence":54},{"loc":[-70.70307000000001,-33.46215],"lat":-33.46215,"lon":-70.70307000000001,"sequence":55},{"loc":[-70.70309,-33.46195],"lat":-33.46195,"lon":-70.70309,"sequence":56},{"loc":[-70.70308,-33.461760000000005],"lat":-33.461760000000005,"lon":-70.70308,"sequence":57},{"loc":[-70.70308,-33.461760000000005],"lat":-33.461760000000005,"lon":-70.70308,"sequence":58},{"loc":[-70.70292,-33.46172],"lat":-33.46172,"lon":-70.70292,"sequence":59},{"loc":[-70.70271000000001,-33.461650000000006],"lat":-33.461650000000006,"lon":-70.70271000000001,"sequence":60},{"loc":[-70.70149,-33.46121],"lat":-33.46121,"lon":-70.70149,"sequence":61},{"loc":[-70.70111,-33.46106],"lat":-33.46106,"lon":-70.70111,"sequence":62},{"loc":[-70.7005,-33.46088],"lat":-33.46088,"lon":-70.7005,"sequence":63},{"loc":[-70.70012000000001,-33.46068],"lat":-33.46068,"lon":-70.70012000000001,"sequence":64},{"loc":[-70.70033000000001,-33.460260000000005],"lat":-33.460260000000005,"lon":-70.70033000000001,"sequence":65},{"loc":[-70.70053,-33.459860000000006],"lat":-33.459860000000006,"lon":-70.70053,"sequence":66},{"loc":[-70.70074000000001,-33.45944],"lat":-33.45944,"lon":-70.70074000000001,"sequence":67},{"loc":[-70.70107,-33.458760000000005],"lat":-33.458760000000005,"lon":-70.70107,"sequence":68},{"loc":[-70.70119000000001,-33.458600000000004],"lat":-33.458600000000004,"lon":-70.70119000000001,"sequence":69},{"loc":[-70.70167000000001,-33.458200000000005],"lat":-33.458200000000005,"lon":-70.70167000000001,"sequence":70},{"loc":[-70.70167000000001,-33.458200000000005],"lat":-33.458200000000005,"lon":-70.70167000000001,"sequence":71},{"loc":[-70.70142,-33.45812],"lat":-33.45812,"lon":-70.70142,"sequence":72},{"loc":[-70.70116,-33.45805],"lat":-33.45805,"lon":-70.70116,"sequence":73},{"loc":[-70.70116,-33.45805],"lat":-33.45805,"lon":-70.70116,"sequence":74},{"loc":[-70.70129,-33.45768],"lat":-33.45768,"lon":-70.70129,"sequence":75},{"loc":[-70.70116,-33.45805],"lat":-33.45805,"lon":-70.70116,"sequence":76},{"loc":[-70.70142,-33.45812],"lat":-33.45812,"lon":-70.70142,"sequence":77},{"loc":[-70.70167000000001,-33.458200000000005],"lat":-33.458200000000005,"lon":-70.70167000000001,"sequence":78},{"loc":[-70.70217000000001,-33.45837],"lat":-33.45837,"lon":-70.70217000000001,"sequence":79},{"loc":[-70.70272,-33.45857],"lat":-33.45857,"lon":-70.70272,"sequence":80},{"loc":[-70.70325000000001,-33.458760000000005],"lat":-33.458760000000005,"lon":-70.70325000000001,"sequence":81},{"loc":[-70.70408,-33.45902],"lat":-33.45902,"lon":-70.70408,"sequence":82},{"loc":[-70.70481000000001,-33.459250000000004],"lat":-33.459250000000004,"lon":-70.70481000000001,"sequence":83},{"loc":[-70.70495000000001,-33.45928],"lat":-33.45928,"lon":-70.70495000000001,"sequence":84},{"loc":[-70.7051,-33.45931],"lat":-33.45931,"lon":-70.7051,"sequence":85},{"loc":[-70.70523,-33.459320000000005],"lat":-33.459320000000005,"lon":-70.70523,"sequence":86},{"loc":[-70.70532,-33.459320000000005],"lat":-33.459320000000005,"lon":-70.70532,"sequence":87},{"loc":[-70.70536,-33.45837],"lat":-33.45837,"lon":-70.70536,"sequence":88},{"loc":[-70.70540000000001,-33.458000000000006],"lat":-33.458000000000006,"lon":-70.70540000000001,"sequence":89},{"loc":[-70.70537,-33.45792],"lat":-33.45792,"lon":-70.70537,"sequence":90},{"loc":[-70.70535000000001,-33.45765],"lat":-33.45765,"lon":-70.70535000000001,"sequence":91},{"loc":[-70.70530000000001,-33.45752],"lat":-33.45752,"lon":-70.70530000000001,"sequence":92},{"loc":[-70.7052,-33.457460000000005],"lat":-33.457460000000005,"lon":-70.7052,"sequence":93},{"loc":[-70.70478,-33.457370000000004],"lat":-33.457370000000004,"lon":-70.70478,"sequence":94},{"loc":[-70.70452,-33.457280000000004],"lat":-33.457280000000004,"lon":-70.70452,"sequence":95},{"loc":[-70.70441000000001,-33.45722],"lat":-33.45722,"lon":-70.70441000000001,"sequence":96},{"loc":[-70.70376,-33.456990000000005],"lat":-33.456990000000005,"lon":-70.70376,"sequence":97},{"loc":[-70.70352000000001,-33.456920000000004],"lat":-33.456920000000004,"lon":-70.70352000000001,"sequence":98},{"loc":[-70.70313,-33.45684],"lat":-33.45684,"lon":-70.70313,"sequence":99},{"loc":[-70.70255,-33.45671],"lat":-33.45671,"lon":-70.70255,"sequence":100},{"loc":[-70.70104,-33.45635],"lat":-33.45635,"lon":-70.70104,"sequence":101},{"loc":[-70.69911,-33.4559],"lat":-33.4559,"lon":-70.69911,"sequence":102},{"loc":[-70.69764,-33.455560000000006],"lat":-33.455560000000006,"lon":-70.69764,"sequence":103},{"loc":[-70.69736,-33.455490000000005],"lat":-33.455490000000005,"lon":-70.69736,"sequence":104},{"loc":[-70.69656,-33.4553],"lat":-33.4553,"lon":-70.69656,"sequence":105},{"loc":[-70.69587,-33.45515],"lat":-33.45515,"lon":-70.69587,"sequence":106},{"loc":[-70.69604000000001,-33.454890000000006],"lat":-33.454890000000006,"lon":-70.69604000000001,"sequence":107},{"loc":[-70.69634,-33.45382],"lat":-33.45382,"lon":-70.69634,"sequence":108},{"loc":[-70.69668,-33.452690000000004],"lat":-33.452690000000004,"lon":-70.69668,"sequence":109},{"loc":[-70.69663,-33.45263],"lat":-33.45263,"lon":-70.69663,"sequence":110},{"loc":[-70.69662000000001,-33.45259],"lat":-33.45259,"lon":-70.69662000000001,"sequence":111},{"loc":[-70.69661,-33.452450000000006],"lat":-33.452450000000006,"lon":-70.69661,"sequence":112},{"loc":[-70.69654,-33.45183],"lat":-33.45183,"lon":-70.69654,"sequence":113},{"loc":[-70.69636000000001,-33.44993],"lat":-33.44993,"lon":-70.69636000000001,"sequence":114},{"loc":[-70.69628,-33.44885],"lat":-33.44885,"lon":-70.69628,"sequence":115},{"loc":[-70.6962,-33.447770000000006],"lat":-33.447770000000006,"lon":-70.6962,"sequence":116},{"loc":[-70.69612000000001,-33.446720000000006],"lat":-33.446720000000006,"lon":-70.69612000000001,"sequence":117},{"loc":[-70.69604000000001,-33.44547],"lat":-33.44547,"lon":-70.69604000000001,"sequence":118},{"loc":[-70.69597,-33.445260000000005],"lat":-33.445260000000005,"lon":-70.69597,"sequence":119},{"loc":[-70.69594000000001,-33.445190000000004],"lat":-33.445190000000004,"lon":-70.69594000000001,"sequence":120},{"loc":[-70.69496000000001,-33.445],"lat":-33.445,"lon":-70.69496000000001,"sequence":121},{"loc":[-70.69348000000001,-33.444720000000004],"lat":-33.444720000000004,"lon":-70.69348000000001,"sequence":122},{"loc":[-70.6932,-33.444680000000005],"lat":-33.444680000000005,"lon":-70.6932,"sequence":123},{"loc":[-70.69306,-33.44465],"lat":-33.44465,"lon":-70.69306,"sequence":124},{"loc":[-70.69250000000001,-33.444590000000005],"lat":-33.444590000000005,"lon":-70.69250000000001,"sequence":125},{"loc":[-70.69224000000001,-33.44456],"lat":-33.44456,"lon":-70.69224000000001,"sequence":126},{"loc":[-70.69199,-33.44455],"lat":-33.44455,"lon":-70.69199,"sequence":127},{"loc":[-70.69171,-33.44454],"lat":-33.44454,"lon":-70.69171,"sequence":128},{"loc":[-70.69086,-33.444410000000005],"lat":-33.444410000000005,"lon":-70.69086,"sequence":129},{"loc":[-70.68960000000001,-33.444340000000004],"lat":-33.444340000000004,"lon":-70.68960000000001,"sequence":130},{"loc":[-70.68802000000001,-33.444280000000006],"lat":-33.444280000000006,"lon":-70.68802000000001,"sequence":131},{"loc":[-70.6876,-33.44426],"lat":-33.44426,"lon":-70.6876,"sequence":132},{"loc":[-70.68738,-33.444250000000004],"lat":-33.444250000000004,"lon":-70.68738,"sequence":133},{"loc":[-70.68422000000001,-33.44409],"lat":-33.44409,"lon":-70.68422000000001,"sequence":134},{"loc":[-70.68352,-33.44406],"lat":-33.44406,"lon":-70.68352,"sequence":135},{"loc":[-70.68223,-33.444],"lat":-33.444,"lon":-70.68223,"sequence":136},{"loc":[-70.68031,-33.4439],"lat":-33.4439,"lon":-70.68031,"sequence":137},{"loc":[-70.68006000000001,-33.44388],"lat":-33.44388,"lon":-70.68006000000001,"sequence":138},{"loc":[-70.67998,-33.44389],"lat":-33.44389,"lon":-70.67998,"sequence":139},{"loc":[-70.67982,-33.4439],"lat":-33.4439,"lon":-70.67982,"sequence":140},{"loc":[-70.67970000000001,-33.44393],"lat":-33.44393,"lon":-70.67970000000001,"sequence":141},{"loc":[-70.67960000000001,-33.44398],"lat":-33.44398,"lon":-70.67960000000001,"sequence":142},{"loc":[-70.67961000000001,-33.443780000000004],"lat":-33.443780000000004,"lon":-70.67961000000001,"sequence":143},{"loc":[-70.67968,-33.44288],"lat":-33.44288,"lon":-70.67968,"sequence":144},{"loc":[-70.67973,-33.44239],"lat":-33.44239,"lon":-70.67973,"sequence":145},{"loc":[-70.67977,-33.442],"lat":-33.442,"lon":-70.67977,"sequence":146},{"loc":[-70.67978000000001,-33.4418],"lat":-33.4418,"lon":-70.67978000000001,"sequence":147},{"loc":[-70.67986,-33.440650000000005],"lat":-33.440650000000005,"lon":-70.67986,"sequence":148},{"loc":[-70.67993,-33.439820000000005],"lat":-33.439820000000005,"lon":-70.67993,"sequence":149},{"loc":[-70.67998,-33.438950000000006],"lat":-33.438950000000006,"lon":-70.67998,"sequence":150},{"loc":[-70.68007,-33.43844],"lat":-33.43844,"lon":-70.68007,"sequence":151},{"loc":[-70.6808,-33.43849],"lat":-33.43849,"lon":-70.6808,"sequence":152},{"loc":[-70.68124,-33.438520000000004],"lat":-33.438520000000004,"lon":-70.68124,"sequence":153},{"loc":[-70.68129,-33.43784],"lat":-33.43784,"lon":-70.68129,"sequence":154},{"loc":[-70.68134,-33.4376],"lat":-33.4376,"lon":-70.68134,"sequence":155},{"loc":[-70.68182,-33.437560000000005],"lat":-33.437560000000005,"lon":-70.68182,"sequence":156}],"avoid":{"ferries":false,"highways":false,"tolls":false},"markers":[{"lat":-33.45743976383781,"lng":-70.66211735194733,"draggable":true,"label":"A"},{"lat":-33.45730264968902,"lng":-70.70131498037752,"draggable":true,"label":"1"},{"lat":-33.43753040916807,"lng":-70.68203007167389,"draggable":true,"label":"B"}],"communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"ownerIds":[{"id":"6654ae4eba54fe502d4e4187","role":"community"}],"distanceInMeters":10161,"distance":10,"timeOnRoute":28}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}
    ${shapeId}    Set Variable    ${response.json()}[_id]

    Set Global Variable    ${shapeId}

    # Nombre
    Should Be Equal As Strings    ${json}[name]    Shape RF
    ...    msg=❌ Name mismatch. Found: "${json}[name]"

    # Comunidades
    Should Contain    ${json}[communities]    6654ae4eba54fe502d4e4187
    ...    msg=❌ Community ID missing. Found: "${json}[communities]"
    Should Contain    ${json}[superCommunities]    653fd68233d83952fafcd4be
    ...    msg=❌ Super Community ID missing. Found: "${json}[superCommunities]"
    Should Be Equal As Strings    ${json}[communityId]       6654ae4eba54fe502d4e4187
    ...    msg=❌ communityId mismatch. Found: "${json}[communityId]"
    Should Be Equal As Strings    ${json}[superCommunityId]  653fd68233d83952fafcd4be
    ...    msg=❌ superCommunityId mismatch. Found: "${json}[superCommunityId]"

    # Owner
    Should Be Equal As Strings    ${json}[ownerIds][0][id]    6654ae4eba54fe502d4e4187
    ...    msg=❌ ownerIds[0].id mismatch. Found: "${json}[ownerIds][0][id]"
    Should Be Equal As Strings    ${json}[ownerIds][0][role]  community
    ...    msg=❌ ownerIds[0].role should be 'community'. Found: "${json}[ownerIds][0][role]"

    # Cada marcador debe tener lat, lng, label y draggable

    # Evitar elementos
    Should Be Equal As Strings    ${json}[avoid][ferries]    False
    ...    msg=❌ avoid.ferries should be false. Found: "${json}[avoid][ferries]"
    Should Be Equal As Strings    ${json}[avoid][highways]   False
    ...    msg=❌ avoid.highways should be false. Found: "${json}[avoid][highways]"
    Should Be Equal As Strings    ${json}[avoid][tolls]      False
    ...    msg=❌ avoid.tolls should be false. Found: "${json}[avoid][tolls]"

    # Puntos no deben estar vacíos
    Should Not Be Empty    ${json}[points]
    ...    msg=❌ 'points' should not be empty. Found: "${json}[points]"

    # Distancia y tiempo
    Should Be Equal As Numbers    ${json}[distance]          10
    ...    msg=❌ Distance mismatch. Found: "${json}[distance]"
    Should Be Equal As Numbers    ${json}[distanceInMeters]  10161
    ...    msg=❌ distanceInMeters mismatch. Found: "${json}[distanceInMeters]"
    Should Be Equal As Numbers    ${json}[timeOnRoute]       28
    ...    msg=❌ timeOnRoute mismatch. Found: "${json}[timeOnRoute]"

    # Dirección y timestamps
    Should Not Be Empty    ${json}[createdAt]
    ...    msg=❌ createdAt is missing. Found: "${json}[createdAt]"
    Should Not Be Empty    ${json}[updatedAt]
    ...    msg=❌ updatedAt is missing. Found: "${json}[updatedAt]"


Create route with just created Shape
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${endPoint}
    ...    data={"name":"Route with just created Shape","description":"Route with just created Shape","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"ownerIds":[{"id":"6654ae4eba54fe502d4e4187","role":"community"}],"externalInfo":{"uuid":""},"assistantIds":[],"shapeId":"${shapeId}","usesBusCode":false,"usesVehicleList":false,"usesDriverCode":false,"usesPasses":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"dynamicSeatAssignment":false,"usesTickets":false,"startsOnStop":false,"notNearStop":false,"routeCost":0,"ticketCost":0,"excludePassengers":{"active":false,"excludeType":"dontHide"},"restrictPassengers":{"enabled":false,"allowed":[],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"endDepartureNotice":{"enabled":false,"lastStop":null},"scheduling":{"enabled":false,"limitUnit":"","limitAmount":0,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]},"timeRules":{"booking":{"maxTime":{"enabled":false,"amount":0,"unit":"minutes"}}},"byQuantity":{"enabled":false,"amount":0,"time":0,"unit":"days","userSkip":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"allowsServiceSnapshots":false,"allowsNonServiceSnapshots":false,"labels":[],"roundOrder":[],"anchorStops":[],"originStop":null,"destinationStop":null,"allowsRating":false,"hasBeacons":false,"hasCapacity":false,"isStatic":false,"showParable":false,"extraInfo":"","usesManualSeat":false,"allowsManualValidation":false,"usesDriverPin":false,"hasBoardings":false,"hasUnboardings":false,"allowsDistance":false,"allowGenericVehicles":false,"hasExternalGPS":false,"departureHourFulfillment":{"enabled":false,"ranges":[]},"usesOfflineCount":false,"useServiceReservations":false,"unassignedDepartures":{"enabled":false,"allowsMultiple":{"enabled":false,"limit":{"amount":5,"unit":"minutes"}}},"autoStartConditions":{"enabled":false,"ignition":false,"allowStop":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"visible":true,"active":true,"usesTextToSpeech":false,"hasBoardingCount":false,"hasRounds":false,"hasUnboardingCount":false,"timeOnRoute":15,"distance":9,"distanceInMeters":8807,"legOptions":[{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100},"ETA":{"enabled":null,"update":{"amount":0,"unit":"minutes"},"visibility":"admin","notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}}}],"validateDeparture":{"enabled":false},"rounds":{"enabled":false,"anchorStops":[]},"trail":{"enabled":false,"adjustByRounds":false},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"assistantAssignsSeat":true,"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"internal":false,"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"},"estimatedDuration":{"byPercentage":{"enabled":false,"amount":0,"timer":{"amount":0,"unit":"minutes"}},"byTime":{"enabled":false,"amount":0,"unit":"minutes","timer":{"amount":0,"unit":"minutes"}}}},"color":"a04747","custom":{"ui":{"color":"a04747","marker":{"1x":"https://s3.amazonaws.com/allride.odd.icons/odd_buses_icon.jpg","1.5x":"https://s3.amazonaws.com/allride.odd.icons/odd_buses_icon.jpg","2x":"https://s3.amazonaws.com/allride.odd.icons/odd_buses_icon.jpg","3x":"https://s3.amazonaws.com/allride.odd.icons/odd_buses_icon.jpg","4x":"https://s3.amazonaws.com/allride.odd.icons/odd_buses_icon.jpg"}}},"route_type":3}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${routeId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${routeId}

Modify Shape
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/shapes/${shapeId}?community=6654ae4eba54fe502d4e4187
    ...    data={"_id":"684317750459d00047b1826c","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"name":"Shape RF Modified 1","markers":[{"_id":"684317750459d00047b1826d","lat":-33.461148392135335,"lng":-70.64220463222077,"draggable":true,"label":"A"},{"_id":"684317750459d00047b1826e","lat":-33.45957306560208,"lng":-70.66211735194733,"draggable":true,"label":"B"}],"avoid":{"ferries":false,"highways":false,"tolls":false},"points":[{"loc":[-70.64216,-33.4615],"lat":-33.4615,"lon":-70.64216,"sequence":0},{"loc":[-70.6418,-33.461470000000006],"lat":-33.461470000000006,"lon":-70.6418,"sequence":1},{"loc":[-70.64178000000001,-33.461670000000005],"lat":-33.461670000000005,"lon":-70.64178000000001,"sequence":2},{"loc":[-70.64175,-33.46186],"lat":-33.46186,"lon":-70.64175,"sequence":3},{"loc":[-70.64175,-33.46186],"lat":-33.46186,"lon":-70.64175,"sequence":4},{"loc":[-70.64165000000001,-33.462970000000006],"lat":-33.462970000000006,"lon":-70.64165000000001,"sequence":5},{"loc":[-70.64165000000001,-33.462970000000006],"lat":-33.462970000000006,"lon":-70.64165000000001,"sequence":6},{"loc":[-70.64269,-33.463080000000005],"lat":-33.463080000000005,"lon":-70.64269,"sequence":7},{"loc":[-70.64326000000001,-33.463150000000006],"lat":-33.463150000000006,"lon":-70.64326000000001,"sequence":8},{"loc":[-70.6443,-33.46327],"lat":-33.46327,"lon":-70.6443,"sequence":9},{"loc":[-70.64447000000001,-33.46329],"lat":-33.46329,"lon":-70.64447000000001,"sequence":10},{"loc":[-70.64488,-33.463330000000006],"lat":-33.463330000000006,"lon":-70.64488,"sequence":11},{"loc":[-70.64588,-33.46342],"lat":-33.46342,"lon":-70.64588,"sequence":12},{"loc":[-70.64706000000001,-33.463550000000005],"lat":-33.463550000000005,"lon":-70.64706000000001,"sequence":13},{"loc":[-70.64769000000001,-33.4636],"lat":-33.4636,"lon":-70.64769000000001,"sequence":14},{"loc":[-70.64890000000001,-33.46374],"lat":-33.46374,"lon":-70.64890000000001,"sequence":15},{"loc":[-70.65102,-33.46397],"lat":-33.46397,"lon":-70.65102,"sequence":16},{"loc":[-70.65184,-33.46406],"lat":-33.46406,"lon":-70.65184,"sequence":17},{"loc":[-70.65289,-33.46417],"lat":-33.46417,"lon":-70.65289,"sequence":18},{"loc":[-70.65392,-33.464310000000005],"lat":-33.464310000000005,"lon":-70.65392,"sequence":19},{"loc":[-70.65468,-33.464400000000005],"lat":-33.464400000000005,"lon":-70.65468,"sequence":20},{"loc":[-70.65586,-33.46453],"lat":-33.46453,"lon":-70.65586,"sequence":21},{"loc":[-70.65626,-33.46457],"lat":-33.46457,"lon":-70.65626,"sequence":22},{"loc":[-70.65634,-33.46271],"lat":-33.46271,"lon":-70.65634,"sequence":23},{"loc":[-70.65642000000001,-33.461400000000005],"lat":-33.461400000000005,"lon":-70.65642000000001,"sequence":24},{"loc":[-70.65646000000001,-33.46052],"lat":-33.46052,"lon":-70.65646000000001,"sequence":25},{"loc":[-70.65646000000001,-33.46052],"lat":-33.46052,"lon":-70.65646000000001,"sequence":26},{"loc":[-70.65666,-33.460350000000005],"lat":-33.460350000000005,"lon":-70.65666,"sequence":27},{"loc":[-70.65714000000001,-33.460330000000006],"lat":-33.460330000000006,"lon":-70.65714000000001,"sequence":28},{"loc":[-70.65727000000001,-33.46031],"lat":-33.46031,"lon":-70.65727000000001,"sequence":29},{"loc":[-70.65734,-33.46029],"lat":-33.46029,"lon":-70.65734,"sequence":30},{"loc":[-70.65741,-33.46023],"lat":-33.46023,"lon":-70.65741,"sequence":31},{"loc":[-70.65748,-33.46013],"lat":-33.46013,"lon":-70.65748,"sequence":32},{"loc":[-70.65752,-33.46003],"lat":-33.46003,"lon":-70.65752,"sequence":33},{"loc":[-70.65753000000001,-33.459880000000005],"lat":-33.459880000000005,"lon":-70.65753000000001,"sequence":34},{"loc":[-70.6575,-33.45933],"lat":-33.45933,"lon":-70.6575,"sequence":35},{"loc":[-70.65740000000001,-33.45884],"lat":-33.45884,"lon":-70.65740000000001,"sequence":36},{"loc":[-70.65735000000001,-33.45864],"lat":-33.45864,"lon":-70.65735000000001,"sequence":37},{"loc":[-70.65735000000001,-33.45857],"lat":-33.45857,"lon":-70.65735000000001,"sequence":38},{"loc":[-70.65741,-33.45841],"lat":-33.45841,"lon":-70.65741,"sequence":39},{"loc":[-70.65748,-33.458290000000005],"lat":-33.458290000000005,"lon":-70.65748,"sequence":40},{"loc":[-70.65762000000001,-33.458200000000005],"lat":-33.458200000000005,"lon":-70.65762000000001,"sequence":41},{"loc":[-70.65797,-33.45814],"lat":-33.45814,"lon":-70.65797,"sequence":42},{"loc":[-70.65819,-33.45816],"lat":-33.45816,"lon":-70.65819,"sequence":43},{"loc":[-70.65819,-33.45816],"lat":-33.45816,"lon":-70.65819,"sequence":44},{"loc":[-70.65938,-33.45828],"lat":-33.45828,"lon":-70.65938,"sequence":45},{"loc":[-70.65967,-33.45676],"lat":-33.45676,"lon":-70.65967,"sequence":46},{"loc":[-70.65967,-33.45676],"lat":-33.45676,"lon":-70.65967,"sequence":47},{"loc":[-70.65968000000001,-33.45662],"lat":-33.45662,"lon":-70.65968000000001,"sequence":48},{"loc":[-70.65990000000001,-33.4566],"lat":-33.4566,"lon":-70.65990000000001,"sequence":49},{"loc":[-70.66042,-33.45664],"lat":-33.45664,"lon":-70.66042,"sequence":50},{"loc":[-70.66051,-33.456830000000004],"lat":-33.456830000000004,"lon":-70.66051,"sequence":51},{"loc":[-70.6605,-33.45704],"lat":-33.45704,"lon":-70.6605,"sequence":52},{"loc":[-70.66046,-33.457350000000005],"lat":-33.457350000000005,"lon":-70.66046,"sequence":53},{"loc":[-70.66043,-33.457950000000004],"lat":-33.457950000000004,"lon":-70.66043,"sequence":54},{"loc":[-70.66041,-33.45819],"lat":-33.45819,"lon":-70.66041,"sequence":55},{"loc":[-70.66041,-33.458330000000004],"lat":-33.458330000000004,"lon":-70.66041,"sequence":56},{"loc":[-70.66039,-33.45877],"lat":-33.45877,"lon":-70.66039,"sequence":57},{"loc":[-70.66039,-33.45877],"lat":-33.45877,"lon":-70.66039,"sequence":58},{"loc":[-70.66071000000001,-33.45881],"lat":-33.45881,"lon":-70.66071000000001,"sequence":59},{"loc":[-70.66092,-33.458870000000005],"lat":-33.458870000000005,"lon":-70.66092,"sequence":60},{"loc":[-70.66106,-33.45895],"lat":-33.45895,"lon":-70.66106,"sequence":61},{"loc":[-70.66115,-33.45904],"lat":-33.45904,"lon":-70.66115,"sequence":62},{"loc":[-70.66124,-33.4592],"lat":-33.4592,"lon":-70.66124,"sequence":63},{"loc":[-70.66130000000001,-33.4594],"lat":-33.4594,"lon":-70.66130000000001,"sequence":64},{"loc":[-70.66134000000001,-33.45964],"lat":-33.45964,"lon":-70.66134000000001,"sequence":65}],"timeOnRoute":12,"distance":3,"distanceInMeters":3190,"ownerIds":[{"_id":"684317750459d00047b182b1","id":"6654ae4eba54fe502d4e4187","role":"community"}],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"6654ae4eba54fe502d4e4187","direction":276.6250860516332,"createdAt":"2025-06-06T16:29:41.169Z","updatedAt":"2025-06-06T16:29:41.169Z","__v":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}
    
    Should Be Equal As Strings    ${shapeId}    ${response.json()}[_id]    
    ...    msg=Expected _id to be "${shapeId}", but found "${response.json()}[_id]"


    # Nombre
    Should Be Equal As Strings    ${json}[name]    Shape RF Modified 1
    ...    msg=❌ Name mismatch. Found: "${json}[name]"


Delete Shape

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/shapes/${shapeId}?community=6654ae4eba54fe502d4e4187
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}
Get All Shapes(After deleted shape)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Get On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/shapes/list?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    
    Should Not Be Empty    ${response.json()}    Response was empty, no stops were found
    ${shapes}=    Set Variable    ${response.json()}
    FOR    ${shape}    IN    @{shapes}
        Should Not Contain    ${shape}[name]    Shape RF Modified 1
        ...    msg=❌ Found shape with name 'Shape RF Modified 1'. Full object: ${shape}
    END
Get Route after deleted Shape (Preguntar Gustavo)
    skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Get On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/${routeId}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Empty    ${response.json()}[shapeId]    
    ...    msg=Expected shapeId to be empty after deletion, but found "${response.json()}[shapeId]"
    

#Obtener la ruta luego de la eliminación de su shapeId

Delete Route
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/${routeId}?community=6654ae4eba54fe502d4e4187
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    ${route}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${route}[name]        Route with just created Shape
    ...    msg=❌ Route name mismatch. Found: "${route}[name]"


    Should Be Equal As Strings    ${route}[description]     Route with just created Shape
    ...    msg=❌ Description mismatch. Found: "${route}[description]"

    Should Be Equal As Strings    ${route}[communityId]     6654ae4eba54fe502d4e4187
    ...    msg=❌ communityId mismatch. Found: "${route}[communityId]"

    Should Be Equal As Strings    ${route}[superCommunityId]     653fd68233d83952fafcd4be
    ...    msg=❌ superCommunityId mismatch. Found: "${route}[superCommunityId]"

    Should Be Equal As Strings    ${route}[color]       a04747
    ...    msg=❌ Color mismatch. Found: "${route}[color]"

    Should Be Equal As Numbers    ${route}[distance]         9
    ...    msg=❌ Distance mismatch. Found: "${route}[distance]"

    Should Be Equal As Numbers    ${route}[distanceInMeters]     8807
    ...    msg=❌ Distance in meters mismatch. Found: "${route}[distanceInMeters]"

    Should Be Equal As Numbers    ${route}[timeOnRoute]      15
    ...    msg=❌ Time on route mismatch. Found: "${route}[timeOnRoute]"

    Should Be Equal As Strings    ${route}[ownerIds][0][id]   6654ae4eba54fe502d4e4187
    ...    msg=❌ Owner ID mismatch. Found: "${route}[ownerIds][0][id]"

    Should Be Equal As Strings    ${route}[ownerIds][0][role]     community
    ...    msg=❌ Owner role mismatch. Found: "${route}[ownerIds][0][role]"

    Should Be Equal As Strings    ${route}[active]    False
    ...    msg=❌ Active flag mismatch. Found: "${route}[active]"

    Should Be Equal As Strings    ${route}[visible]   True
    ...    msg=❌ Visible flag mismatch. Found: "${route}[visible]"

    Should Not Be Empty    ${route}[deletedAt]
    ...    msg=❌ Expected route to be deleted, but deletedAt is missing.
