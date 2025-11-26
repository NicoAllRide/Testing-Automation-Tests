

## Flujo de creación de códigos de enrolamiento
# Manual y masivo
# Eliminiación masiva e individual
# Creación de usuarios manual y masiva con y sin códigos de enrolamiento existentes
# ###

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

#--------------------------------CASOS MANUALES Creación de usuario y código de enrolamiento------------------------#
#Creación, eliminiación

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

2 hours local
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Generate Random 10 Digit Value
    ${random_value1}=    Evaluate    "".join([str(random.randint(0,9)) for _ in range(10)])    random
    Log    Valor aleatorio generado: ${random_value1}
    Set Global Variable    ${random_value1}

Create community Validation manual (Código de enrolamiento)
    [Documentation]    Crear un código de enrolamiento individual de manera manual
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/communityValidationUsers/?community=6654ae4eba54fe502d4e4187
    ...    data={"community":"6654ae4eba54fe502d4e4187","values":[{"key":"rut","value":"111111111","listValue":null,"public":true,"check":true,"listOfRoutes":false},{"key":"address","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"coordinates","value":"","listValue":null,"public":false,"check":false,"listOfRoutes":false},{"key":"Color","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"Animal","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"Empresa","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false}],"validated":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${customData}=	Set Variable	${response.json()}[validation]
    ${customValidationId}=	Set Variable	${customData}[_id]

    Set Global Variable	${customValidationId}

    Should Be Equal As Strings	${customData}[community]	6654ae4eba54fe502d4e4187
    ...	msg=❌ Community mismatch. Found: "${customData}[community]"

    Should Be Equal As Strings	${customData}[validated]	False
    ...	msg=❌ Validated flag mismatch. Found: "${customData}[validated]"

    ${value1}=	Set Variable	${customData}[values][0]
    Should Be Equal As Strings	${value1}[key]	rut
    Should Be Equal As Strings	${value1}[value]	111111111
    Should Be Equal As Strings	${value1}[public]	True
    ...	msg=❌ 'rut' field is incorrect. Found: ${value1}

    ${value2}=	Set Variable	${customData}[values][1]
    Should Be Equal As Strings	${value2}[key]	address
    Should Be Equal As Strings	${value2}[public]	True
    ...	msg=❌ 'address' field is incorrect. Found: ${value2}

    ${value3}=	Set Variable	${customData}[values][2]
    Should Be Equal As Strings	${value3}[key]	coordinates
    Should Be Equal As Strings	${value3}[public]	False
    ...	msg=❌ 'coordinates' field is incorrect. Found: ${value3}

    ${value4}=	Set Variable	${customData}[values][3]
    Should Be Equal As Strings	${value4}[key]	Color
    Should Be Equal As Strings	${value4}[public]	True
    ...	msg=❌ 'Color' field is incorrect. Found: ${value4}

    ${value5}=	Set Variable	${customData}[values][4]
    Should Be Equal As Strings	${value5}[key]	Animal
    Should Be Equal As Strings	${value5}[public]	True
    ...	msg=❌ 'Animal' field is incorrect. Found: ${value5}

    ${value6}=	Set Variable	${customData}[values][5]
    Should Be Equal As Strings	${value6}[key]	Empresa
    Should Be Equal As Strings	${value6}[public]	True
    ...	msg=❌ 'Empresa' field is incorrect. Found: ${value6}
Create user manually with already existing communityValidation
    [Documentation]    Crear un usuario individual de manera manual con un código ya existente
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/createUser?community=6654ae4eba54fe502d4e4187
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","country":"cl","name":"UserRobotFramework","customValidation":{"rut":"111111111","address":"Rengo, O'Higgins, Chile","coordinates":"-34.4028433,-70.8608394","Color":"Negro","Animal":"Perro","Empresa":"AllRide"},"phoneNumber":null}
    ...    headers=${headers}

    ${user}=    Set Variable    ${response.json()}[correct][0]
    ${userId}=    Set Variable    ${response.json()}[correct][0][_id]
    Set Global Variable    ${userId}

    Should Be Equal As Strings    ${user}[name]     UserRobotFramework
    ...    msg=❌ User name mismatch. Found: "${user}[name]"

    Should Be Equal As Strings    ${user}[country]  cl
    ...    msg=❌ Country mismatch. Found: "${user}[country]"

    Should Be Equal As Strings    ${user}[active]   True
    ...    msg=❌ User should be active. Found: "${user}[active]"

    Should Be Equal As Strings    ${user}[adminLevel]    0
    ...    msg=❌ Admin level mismatch. Found: "${user}[adminLevel]"

    Should Be Equal As Strings    ${user}[createdFromAdmin]  True
    ...    msg=❌ createdFromAdmin should be True. Found: "${user}[createdFromAdmin]"

    ${community}=    Set Variable    ${user}[communities][0]

    Should Be Equal As Strings    ${community}[communityId]    6654ae4eba54fe502d4e4187
    ...    msg=❌ Community ID mismatch. Found: "${community}[communityId]"

    Should Be Equal As Strings    ${community}[confirmed]      True
    ...    msg=❌ Community confirmation should be True. Found: "${community}[confirmed]"

    # Validaciones de datos personalizados
    ${custom}=    Set Variable    ${community}[custom]

    Should Be Equal As Strings    ${custom}[0][key]     rut
    Should Be Equal As Strings    ${custom}[0][value]   111111111
    ...    msg=❌ Custom field 'rut' mismatch. Found: "${custom}[0][value]"

    Should Be Equal As Strings    ${custom}[1][key]     address
    Should Be Equal As Strings    ${custom}[1][value]   Rengo, O'Higgins, Chile
    ...    msg=❌ Custom field 'address' mismatch. Found: "${custom}[1][value]"

    Should Be Equal As Strings    ${custom}[2][key]     coordinates
    Should Be Equal As Strings    ${custom}[2][value]   -34.4028433,-70.8608394
    ...    msg=❌ Custom field 'coordinates' mismatch. Found: "${custom}[2][value]"

    Should Be Equal As Strings    ${custom}[3][key]     Color
    Should Be Equal As Strings    ${custom}[3][value]   Negro
    ...    msg=❌ Custom field 'Color' mismatch. Found: "${custom}[3][value]"

    Should Be Equal As Strings    ${custom}[4][key]     Animal
    Should Be Equal As Strings    ${custom}[4][value]   Perro
    ...    msg=❌ Custom field 'Animal' mismatch. Found: "${custom}[4][value]"

    Should Be Equal As Strings    ${custom}[5][key]     Empresa
    Should Be Equal As Strings    ${custom}[5][value]   AllRide
    ...    msg=❌ Custom field 'Empresa' mismatch. Found: "${custom}[5][value]"
    
    # Validar que el usuario tenga privateBus habilitado
    ${privateBus}=    Get From Dictionary    ${community}    privateBus
    Should Be Equal As Strings    ${privateBus}[enabled]    True    msg=❌ 'privateBus' no está habilitado para el usuario





Find created user manually
    [Documentation]    Se busca el usuario creado recientemente y verifica que sus datos sean los correctos

    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/listPagination?page=1&pageSize=200&community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    ${last_user}=    Set Variable    ${response.json()}[users][-1]

    Should Be Equal As Strings    ${last_user}[name]    UserRobotFramework
    ...    msg=❌ El nombre del último usuario debería ser 'UserRobotFramework'. Se encontró: "${last_user}[name]"
    
    Should Be Equal As Strings    ${last_user}[_id]    ${userId}
    ...    msg=❌ El _id del último usuario debería ser '${userId}'. Se encontró: "${last_user}[name]"


    # Validar que fue creado desde admin
    Should Be Equal As Strings    ${last_user}[createdFromAdmin]    True
    ...    msg=❌ El campo 'createdFromAdmin' debería ser True. Se encontró: "${last_user}[createdFromAdmin]"

    # Validar avatar placeholder
    Should Contain    ${last_user}[avatar]    user_placeholder.png
    ...    msg=❌ El avatar debería ser el placeholder por defecto. Se encontró: "${last_user}[avatar]"



Delete user from community
    [Documentation]    Se elimina al usuario de la comunidad
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/${userId}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}

    ${deleted_user}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${deleted_user}[name]    UserRobotFramework
    ...    msg=❌ El nombre del usuario debería ser 'UserRobotFramework'. Se encontró: "${deleted_user}[name]"

    Should Not Be Empty    ${deleted_user}[deletedAt]
    ...    msg=❌ El campo 'deletedAt' debería estar presente. Se encontró vacío o nulo.

    Should Be Equal As Strings    ${deleted_user}[createdFromAdmin]    True
    ...    msg=❌ El campo 'createdFromAdmin' debería ser True. Se encontró: "${deleted_user}[createdFromAdmin]"

    Should Contain    ${deleted_user}[avatar]    user_placeholder.png
    ...    msg=❌ El avatar debería ser el placeholder por defecto. Se encontró: "${deleted_user}[avatar]"

    Should Be Equal As Strings    ${deleted_user}[country]    cl
    ...    msg=❌ El campo 'country' debería ser 'cl'. Se encontró: "${deleted_user}[country]"

Delete validationCode
    [Documentation]    Se elimina el código de enrolamiento
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/communityValidationUsers/${customValidationId}?community=6654ae4eba54fe502d4e4187

    ...    headers=${headers}
   
    ${delete_response}=    Set Variable    ${response.json()}

    Dictionary Should Contain Key    ${delete_response}    n
    Dictionary Should Contain Key    ${delete_response}    electionId
    Dictionary Should Contain Key    ${delete_response}    opTime
    Dictionary Should Contain Key    ${delete_response}    ok
    Dictionary Should Contain Key    ${delete_response}    $clusterTime
    Dictionary Should Contain Key    ${delete_response}    operationTime
    Dictionary Should Contain Key    ${delete_response}    deletedCount

    Dictionary Should Contain Key    ${delete_response}[opTime]    ts
    Dictionary Should Contain Key    ${delete_response}[opTime]    t

    Dictionary Should Contain Key    ${delete_response}[$clusterTime]    clusterTime
    Dictionary Should Contain Key    ${delete_response}[$clusterTime]    signature
    Dictionary Should Contain Key    ${delete_response}[$clusterTime][signature]    hash
    Dictionary Should Contain Key    ${delete_response}[$clusterTime][signature]    keyId

Search for customValidation(Should not be found after deletion)
    [Documentation]     Se busca el código de enrolamiento recién eliminado, no debería encontrarse
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/communityValidationUsers/list?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    
    ${deleted_id}=    Set Variable    ${customValidationId}
    ${response_list}=    Set Variable    ${response.json()}
    ${id_list}=    Create List

    FOR    ${item}    IN    @{response_list}
        ${_id}=    Set Variable    ${item["_id"]}
        Append To List    ${id_list}    ${_id}
    END
    Should Not Contain    ${id_list}    ${deleted_id}    msg=❌ The _id "${deleted_id}" was found in the list and should have been deleted.




#--------------------------------CASOS MASIVOS Creación de usuario y código de enrolamiento------------------------#
#Creación,edición, eliminiación


Create community Validation bulk (Código de enrolamiento)
    [Documentation]    Creación de código de enrolamiento mediante creación masiva de usuarios(solo 1)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/communityValidationUsers/bulkInsert?community=6654ae4eba54fe502d4e4187
    ...    data=[{"community":"6654ae4eba54fe502d4e4187","values":[{"key":"rut","value":"111111112","public":true,"check":true},{"key":"coordinates","public":false,"check":false}],"validated":false}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}
    ${restriccion}=    Get From List    ${json}    0

    # Main validations
    Should Be Equal As Strings    ${restriccion}[validated]    False    msg=❌ The field "validated" should be False
    Should Be Empty               ${restriccion}[userIds]               msg=❌ The field "userIds" should be empty
    Should Be Equal As Strings    ${restriccion}[community]    6654ae4eba54fe502d4e4187    msg=❌ Community ID does not match expected

    # Values validations
    ${values}=    Get From Dictionary    ${restriccion}    values
    ${rut}=       Get From List    ${values}    0
    ${coords}=    Get From List    ${values}    1

    Should Be Equal As Strings    ${rut}[key]    rut    msg=❌ First value key should be "rut"
    Should Be Equal As Strings    ${rut}[value]  111111112    msg=❌ "rut" value does not match expected
    Should Be True                ${rut}[public]             msg=❌ "rut" should be public

    Should Be Equal As Strings    ${coords}[key]    coordinates    msg=❌ Second value key should be "coordinates"
Create user bulk
    [Documentation]
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/bulkCreateUsers?community=6654ae4eba54fe502d4e4187
    ...    data=[{"communityId":"6654ae4eba54fe502d4e4187","country":"cl","name":"QA TEST RF","customValidation":{"rut":"111111112"},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true},{"name":"Limitada Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":true,"asapDepartures":true}]}}]
    ...    headers=${headers}

    ${json}=    Set Variable    ${response.json()}
    ${bulkUserId}=    Set Variable    ${response.json()}[correct][0][_id]
    Set Global Variable    ${bulkUserId}
    ${user}=    Get From List    ${json}[correct]    0

    # Basic user validations
    Should Be Equal As Strings    ${user}[name]               QA TEST RF    msg=❌ 'name' does not match expected
    Should Be Equal As Strings    ${user}[country]            cl           msg=❌ 'country' should be 'cl'
    Should Be Equal As Strings    ${user}[currency]           clp          msg=❌ 'currency' should be 'clp'
    Should Be Equal As Strings    ${user}[active]             True         msg=❌ 'active' should be True
    Should Be Equal As Strings    ${user}[createdFromAdmin]   True         msg=❌ 'createdFromAdmin' should be True

    # Config validations
    ${config}=        Get From Dictionary    ${user}    config
    ${privateBus}=    Get From Dictionary    ${config}    privateBus

    Should Be Equal As Strings    ${privateBus}[showSection]       True     msg=❌ 'showSection' should be True
    Should Be Equal As Strings    ${privateBus}[canBeValidated]    True     msg=❌ 'canBeValidated' should be True
    Should Be Equal As Strings    ${privateBus}[canBook]           True     msg=❌ 'canBook' should be True
    Should Be Equal As Strings    ${config}[enabledPin]            False    msg=❌ 'enabledPin' should be False
    Should Be Equal As Strings    ${config}[excludeMassiveMailing]     False    msg=❌ 'excludeMassiveMailing' should be False

    # Community validation
    ${communities}=    Get From Dictionary    ${user}    communities
    ${community}=      Get From List          ${communities}    0

    Should Be Equal As Strings    ${community}[communityId]    6654ae4eba54fe502d4e4187    msg=❌ 'communityId' mismatch
    Should Be Equal As Strings    ${community}[confirmed]      True                        msg=❌ 'confirmed' should be True
    Should Be Equal As Strings    ${community}[isAdmin]        False                       msg=❌ 'isAdmin' should be False

    # Custom fields validation
    ${custom}=    Get From Dictionary    ${community}    custom
    ${rut}=       Get From List    ${custom}    0
    ${coords}=    Get From List    ${custom}    1

    Should Be Equal As Strings    ${rut}[key]      rut         msg=❌ First custom key should be 'rut'
    Should Be Equal As Strings    ${rut}[value]    111111112   msg=❌ 'rut' value mismatch
    Should Be Equal As Strings    ${coords}[key]   coordinates     msg=❌ Second custom key should be 'coordinates'

    # Final JSON-wide validations
    Should Be Empty    ${json}[withErrors]       msg=❌ 'withErrors' should be empty
    Should Be Empty    ${json}[cardsWithError]   msg=❌ 'cardsWithError' should be empty
    Should Be Equal As Strings    ${json}[timeStamp]    True    msg=❌ 'timeStamp' should be True

    # Validación de adminApproval según los servicios

    ${privateBus}=    Get From Dictionary    ${community}    privateBus
    ${odd}=           Get From Dictionary    ${privateBus}    odd
    ${oddApproval}=   Get From Dictionary    ${odd}    needsAdminApproval

    ${services}=      Get From Dictionary    ${privateBus}    oDDServices
    ${firstService}=  Get From List          ${services}    0
    ${firstServiceApproval}=    Get From Dictionary    ${firstService}    needsAdminApproval



    # 2. Validate individual values per service
    ${firstService}=    Get From List    ${services}    0
    ${secondService}=    Get From List    ${services}    1

    Should Be Equal As Strings    ${firstService}[name]    Taxis Nico
    ...    msg=❌ First service name should be 'Taxis Nico'. Found: '${firstService}[name]'

    Should Be Equal As Strings    ${firstService}[needsAdminApproval]    True
    ...    msg=❌ 'Taxis Nico' should have needsAdminApproval=True. Found: ${firstService}[needsAdminApproval]

    Should Be Equal As Strings    ${secondService}[name]    Limitada Nico
    ...    msg=❌ Second service name should be 'Limitada Nico'. Found: '${secondService}[name]'

    Should Be Equal As Strings    ${secondService}[needsAdminApproval]    False
    ...    msg=❌ 'Limitada Nico' should have needsAdminApproval=False. Found: ${secondService}[needsAdminApproval]


Find created user with bulk
    [Documentation]    Search and find the user created via bulk process, verify that only one user was modified
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8

    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/listPagination?page=1&pageSize=200&community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    
    ${last_user}=    Set Variable    ${response.json()}[users][-1]

    Should Be Equal As Strings    ${last_user}[name]    QA TEST RF
    ...    msg=❌ The name of the last user should be 'QA TEST RF'. Found: "${last_user}[name]"

    Should Be Equal As Strings    ${last_user}[_id]    ${bulkUserId}
    ...    msg=❌ The _id of the last user should be '${bulkUserId}'. Found: "${last_user}[_id]"

    # Validate that it was created from admin
    Should Be Equal As Strings    ${last_user}[createdFromAdmin]    True
    ...    msg=❌ The 'createdFromAdmin' field should be True. Found: "${last_user}[createdFromAdmin]"

Get User Detail after bulk creation
    [Documentation]    Buscar usuario recién creado, debería tener habilitado buses privados
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/getUserWithParams/${bulkUserId}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    ${json}=    Set Variable    ${response.json()}

    # Get first community
    ${community}=    Get From List    ${json}[communities]    0

    # Check that 'privateBus' exists in community
    Dictionary Should Contain Key    ${community}    privateBus    msg=❌ 'privateBus' is missing inside communities[0]

    # Check that 'enabled' inside 'privateBus' is True
    Should Be Equal As Strings    ${community}[privateBus][enabled]    True    msg=❌ 'privateBus.enabled' should be True but is False or missing

    
Bulk edit users
    [Documentation]    Edición masiva de usuarios, solo se modificó el usuario creado recientemente
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/bulkEditParams?community=6654ae4eba54fe502d4e4187
    ...    data=[{"id":"64bfe08a8a9a7f1a07966a99","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":true,"asapDepartures":true}]},"errors":[]},{"id":"6532b807897f712ff487a792","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":true,"asapDepartures":true}]},"errors":[]},{"id":"65e5d25bb23585cc1d6720b4","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":true,"asapDepartures":true}]},"errors":[]},{"id":"666078059a5ece0ee6e95904","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":true,"asapDepartures":true}]},"errors":[]},{"id":"666748b30c80b160cb019c0a","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":true,"asapDepartures":true}]},"errors":[]},{"id":"66d8cf4f4a7101503b01f84a","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":true,"asapDepartures":true}]},"errors":[]},{"id":"66e30a06e2b22c7d017bb492","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"66e3145ce2b22c7d017bc69f","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"66f5be743f62ca48d01d2603","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"66f5bea73f62ca48d01d269a","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"66f5becbf3a0b05c0092e66f","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"66f5bee8f3a0b05c0092e702","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"6712d75aed7ba22ec3844bbc","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"672e124238b6b25bda866fb8","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67334f3c38b6b25bdaa3f1a2","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67335df23ec6775bff420443","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67349d50fb5cad12c7dbed46","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":true,"asapDepartures":true}]},"errors":[]},{"id":"675358381ba97d0beb9f1629","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"678680d766ba391305267591","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"6786815c66ba391305267842","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"6786817c66ba3913052679ce","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"678681d5b2e380c81dee7a45","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"6787bd6ea49befc4e590504f","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"6787bdbea49befc4e5905312","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"6787bf41a49befc4e590608d","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67b4dd547c91683d390b1517","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67b4dd567c91683d390b1538","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67d1d327d7ff2fd9a241b416","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67d1d37fd7ff2fd9a241b7b9","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67d1d680c037a44cd53602c5","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67d1f165358e8d65e08be513","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67e2b17f81b33c57c71c15d0","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67e2d43b09cd77d84b833958","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67e41ac5aac5ae43fc648efe","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67e42542c81c5eb23228a3bb","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67f7f0e579eedd86f20b6940","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67f7f63f4f2a3b9d3a7ca619","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67f7f971ae4b97ab20393620","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67fc9b7f72823041f280fd2f","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67fd0c85b300e4f97c73ed3f","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67fd13283f99d5fbb7d487da","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67fd579eba18b236344908f7","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67fd629bb1614d431f3f2632","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"67fd6331b1614d431f3f29a1","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"681bd2d739abd0c012f3ef45","customValidation":{},"buses":{"enabled":false,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]},{"id":"${bulkUserId}","customValidation":{},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Nico","canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false},{"name":"Limitada Nico","canCreate":false,"needsAdminApproval":false,"exclusiveDepartures":false,"asapDepartures":false}]},"errors":[]}]
    ...    headers=${headers}



Get User Detail after bulk edit
    [Documentation]    Buscar usuario recién editado, debería tener habilitado buses privados
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/getUserWithParams/${bulkUserId}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    ${json}=    Set Variable    ${response.json()}

    # Get first community
    ${community}=    Get From List    ${json}[communities]    0

    # Check that 'privateBus' exists in community
    Dictionary Should Contain Key    ${community}    privateBus    msg=❌ 'privateBus' is missing inside communities[0]

    # Check that 'enabled' inside 'privateBus' is True
    Should Be Equal As Strings    ${community}[privateBus][enabled]    True    msg=❌ 'privateBus.enabled' should be True but is False or missing


Delete user from community
    [Documentation]    Delete the user recently created via bulk operation
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8

    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/${bulkUserId}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}

    ${deleted_user}=    Set Variable    ${response.json()}

    Should Not Be Empty    ${deleted_user}[deletedAt]
    ...    msg=❌ The 'deletedAt' field should be present. Found empty or null.

    Should Be Equal As Strings    ${deleted_user}[createdFromAdmin]    True
    ...    msg=❌ The 'createdFromAdmin' field should be True. Found: "${deleted_user}[createdFromAdmin]"

    Should Contain    ${deleted_user}[avatar]    user_placeholder.png
    ...    msg=❌ The avatar should be the default placeholder. Found: "${deleted_user}[avatar]"

    Should Be Equal As Strings    ${deleted_user}[country]    cl
    ...    msg=❌ The 'country' field should be 'cl'. Found: "${deleted_user}[country]"




