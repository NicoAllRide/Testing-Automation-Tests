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


#---------------------------No se puede automatizar, luego de utilizar los pases no se eliminan, entonces el QR que se genera es el del pase ya utilizado, por lo que falla
# Averiguar la manera de poder eliminar los pases del usuario para poder utilizar solo uno
# Habría que ejecuar solo uno al día
# -------------------------------------------------#


*** Test Cases ***
Set Date Variables
    sleep     15s
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
    ${start_date_tickets}=    Set Variable    ${fecha_hoy}T04:00:00.000Z
    Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=    Set Variable    ${fecha_manana}T03:59:59.999Z
    Set Global Variable    ${end_date_tickets}

    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}

Generate random UUID (_id validations qrValidations)
    ${uuid_qr}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr}
    Set Global Variable    ${uuid_qr}
Generate random UUID 2 (_id validations qrValidations)
    ${uuid_qr2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr2}
    Set Global Variable    ${uuid_qr2}
Generate random UUID 3 (_id validations qrValidations)
    ${uuid_qr3}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr3}
    Set Global Variable    ${uuid_qr3}
Generate random UUID 4 (_id validations qrValidations)
    ${uuid_qr4}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr4}
    Set Global Variable    ${uuid_qr4}

2 hours local
    ${date}=    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}=    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}=    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}=    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}


Generate Random 10 Digit Value
    ${random_value1}=    Evaluate    "".join([str(random.randint(0,9)) for _ in range(10)])    random
    Log    Valor aleatorio generado: ${random_value1}
    Set Global Variable    ${random_value1}

Create community Validation manual (Código de enrolamiento) 1
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
   ${customData}=    Set Variable    ${response.json()}[validation]
   ${customValidationId}    Set Variable    ${response.json()}[validation][_id]

   Set Global Variable    ${customValidationId}

    Should Be Equal As Strings    ${customData}[community]  6654ae4eba54fe502d4e4187
    ...    msg=❌ Community mismatch. Found: "${customData}[community]"

    Should Be Equal As Strings    ${customData}[validated]  False
    ...    msg=❌ Validated flag mismatch. Found: "${customData}[validated]"

    ${value1}=    Set Variable    ${customData}[values][0]
    Should Be Equal As Strings    ${value1}[key]     rut
    Should Be Equal As Strings    ${value1}[value]   111111111
    Should Be Equal As Strings    ${value1}[public]  True
    ...    msg=❌ 'rut' field is incorrect. Found: ${value1}

    ${value2}=    Set Variable    ${customData}[values][1]
    Should Be Equal As Strings    ${value2}[key]     address
    Should Be Equal As Strings    ${value2}[public]  True
    ...    msg=❌ 'address' field is incorrect. Found: ${value2}

    ${value3}=    Set Variable    ${customData}[values][2]
    Should Be Equal As Strings    ${value3}[key]     coordinates
    Should Be Equal As Strings    ${value3}[public]  False
    ...    msg=❌ 'coordinates' field is incorrect. Found: ${value3}

    ${value4}=    Set Variable    ${customData}[values][3]
    Should Be Equal As Strings    ${value4}[key]     Color
    Should Be Equal As Strings    ${value4}[public]  True
    ...    msg=❌ 'Color' field is incorrect. Found: ${value4}

    ${value5}=    Set Variable    ${customData}[values][4]
    Should Be Equal As Strings    ${value5}[key]     Animal
    Should Be Equal As Strings    ${value5}[public]  True
    ...    msg=❌ 'Animal' field is incorrect. Found: ${value5}

    ${value6}=    Set Variable    ${customData}[values][5]
    Should Be Equal As Strings    ${value6}[key]     Empresa
    Should Be Equal As Strings    ${value6}[public]  True
    ...    msg=❌ 'Empresa' field is incorrect. Found: ${value6}
Create user manually with already existing communityValidation 1
    [Documentation]    Crear un usuario individual de manera manual con un código ya existente
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/createUser?community=6654ae4eba54fe502d4e4187
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","country":"cl","name":"UserRobotFramework","customValidation":{"rut":"111111111","address":"Rengo, O'Higgins, Chile","coordinates":"-34.4028433,-70.8608394","Color":"Negro","Animal":"Perro","Empresa":"AllRide"},"phoneNumber":null}
    ...    headers=${headers}

    ${user}=    Set Variable    ${response.json()}[correct][0]
    ${accessTokenNico}=    Set Variable    ${response.json()}[correct][0][accessToken]
    ${userId}=    Set Variable    ${response.json()}[correct][0][_id]
    Set Global Variable    ${userId}
    Set Global Variable    ${accessTokenNico}

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






Find created user manually 1
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



Create community Validation manual (Código de enrolamiento) 2
    [Documentation]    Crear un código de enrolamiento individual de manera manual
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/communityValidationUsers/?community=6654ae4eba54fe502d4e4187
    ...    data={"community":"6654ae4eba54fe502d4e4187","values":[{"key":"rut","value":"111111112","listValue":null,"public":true,"check":true,"listOfRoutes":false},{"key":"address","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"coordinates","value":"","listValue":null,"public":false,"check":false,"listOfRoutes":false},{"key":"Color","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"Animal","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"Empresa","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false}],"validated":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
   ${customData}=    Set Variable    ${response.json()}[validation]
   ${customValidationId}    Set Variable    ${response.json()}[validation][_id]

   Set Global Variable    ${customValidationId}

    Should Be Equal As Strings    ${customData}[community]  6654ae4eba54fe502d4e4187
    ...    msg=❌ Community mismatch. Found: "${customData}[community]"

    Should Be Equal As Strings    ${customData}[validated]  False
    ...    msg=❌ Validated flag mismatch. Found: "${customData}[validated]"

    ${value1}=    Set Variable    ${customData}[values][0]
    Should Be Equal As Strings    ${value1}[key]     rut
    Should Be Equal As Strings    ${value1}[value]   111111112
    Should Be Equal As Strings    ${value1}[public]  True
    ...    msg=❌ 'rut' field is incorrect. Found: ${value1}

    ${value2}=    Set Variable    ${customData}[values][1]
    Should Be Equal As Strings    ${value2}[key]     address
    Should Be Equal As Strings    ${value2}[public]  True
    ...    msg=❌ 'address' field is incorrect. Found: ${value2}

    ${value3}=    Set Variable    ${customData}[values][2]
    Should Be Equal As Strings    ${value3}[key]     coordinates
    Should Be Equal As Strings    ${value3}[public]  False
    ...    msg=❌ 'coordinates' field is incorrect. Found: ${value3}

    ${value4}=    Set Variable    ${customData}[values][3]
    Should Be Equal As Strings    ${value4}[key]     Color
    Should Be Equal As Strings    ${value4}[public]  True
    ...    msg=❌ 'Color' field is incorrect. Found: ${value4}

    ${value5}=    Set Variable    ${customData}[values][4]
    Should Be Equal As Strings    ${value5}[key]     Animal
    Should Be Equal As Strings    ${value5}[public]  True
    ...    msg=❌ 'Animal' field is incorrect. Found: ${value5}

    ${value6}=    Set Variable    ${customData}[values][5]
    Should Be Equal As Strings    ${value6}[key]     Empresa
    Should Be Equal As Strings    ${value6}[public]  True
    ...    msg=❌ 'Empresa' field is incorrect. Found: ${value6}
Create user manually with already existing communityValidation 2
    [Documentation]    Crear un usuario individual de manera manual con un código ya existente
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/createUser?community=6654ae4eba54fe502d4e4187
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","country":"cl","name":"UserRobotFramework 2","customValidation":{"rut":"111111112","address":"Rengo, O'Higgins, Chile","coordinates":"-34.4028433,-70.8608394","Color":"Negro","Animal":"Perro","Empresa":"AllRide"},"phoneNumber":null}
    ...    headers=${headers}

    ${user}=    Set Variable    ${response.json()}[correct][0]
    ${accessTokenNico2}=    Set Variable    ${response.json()}[correct][0][accessToken]
    ${userId_2}=    Set Variable    ${response.json()}[correct][0][_id]
    Set Global Variable    ${userId_2}
    Set Global Variable    ${accessTokenNico2}




Find created user manually 2
    [Documentation]    Se busca el usuario creado recientemente y verifica que sus datos sean los correctos

    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/listPagination?page=1&pageSize=200&community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    ${last_user}=    Set Variable    ${response.json()}[users][-1]

    Should Be Equal As Strings    ${last_user}[name]    UserRobotFramework 2
    ...    msg=❌ El nombre del último usuario debería ser 'UserRobotFramework 2'. Se encontró: "${last_user}[name]"
    
    Should Be Equal As Strings    ${last_user}[_id]    ${userId_2}
    ...    msg=❌ El _id del último usuario debería ser '${userId_2}'. Se encontró: "${last_user}[name]"


    # Validar que fue creado desde admin
    Should Be Equal As Strings    ${last_user}[createdFromAdmin]    True
    ...    msg=❌ El campo 'createdFromAdmin' debería ser True. Se encontró: "${last_user}[createdFromAdmin]"

    # Validar avatar placeholder
    Should Contain    ${last_user}[avatar]    user_placeholder.png
    ...    msg=❌ El avatar debería ser el placeholder por defecto. Se encontró: "${last_user}[avatar]"






Crate Product (Pass)
    [Documentation]     Creación de productos desde el admin (Pases)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/createProduct?community=6654ae4eba54fe502d4e4187
    ...    data={"active":true,"name":"Automation Test Passes 2","description":"Automation Test Passes 2","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"expiration":"","price":10,"discount":0,"stock":2,"values":[{"communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"ref":"pb_pass","quantity":1,"options":{"name":"Automation Test Passes 2","description":"Automation Test Passes 2","startDate":"${fecha_hoy}","endDate":"${fecha_manana}","unlimitedUses":false,"maxUses":2,"maxDailyUses":2,"state":"available","allRoutes":true,"routeIds":[],"routeNames":[],"oddTypes":[]}}],"productType":"pb_pass"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
 
    ${last_pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${last_pass}[active]    True
    ...    msg=❌ The pass should be active. Found: "${last_pass}[active]"

    Should Be Equal As Integers    ${last_pass}[stock]    2
    ...    msg=❌ The stock should be 1. Found: "${last_pass}[stock]"

    Should Be Equal As Integers    ${last_pass}[price]    10
    ...    msg=❌ The price should be 10. Found: "${last_pass}[price]"

    Should Contain    ${last_pass}[communities]    6654ae4eba54fe502d4e4187
    ...    msg=❌ Expected community ID not found. Found: "${last_pass}[communities]"

    Should Contain    ${last_pass}[superCommunities]    653fd68233d83952fafcd4be
    ...    msg=❌ Expected superCommunity ID not found. Found: "${last_pass}[superCommunities]"

    ${pass_values}=    Get From List    ${last_pass}[values]    0

    Should Be Equal As Strings    ${pass_values}[ref]    pb_pass
    ...    msg=❌ The 'ref' should be 'pb_pass'. Found: "${pass_values}[ref]"

    Should Be Equal As Integers    ${pass_values}[quantity]    1
    ...    msg=❌ The quantity should be 1. Found: "${pass_values}[quantity]"

    ${options}=    Set Variable    ${pass_values}[options]

    Should Be Equal As Strings    ${options}[name]    Automation Test Passes 2
    ...    msg=❌ The pass name should be 'Automation Test Passes 2'. Found: "${options}[name]"

    Should Be Equal As Strings    ${options}[description]    Automation Test Passes 2
    ...    msg=❌ The pass description should be 'Automation Test Passes 2'. Found: "${options}[description]"

    Should Be Equal As Strings    ${options}[startDate]    ${fecha_hoy}
    ...    msg=❌ The start date should be '${fecha_hoy}'. Found: "${options}[startDate]"

    Should Be Equal As Strings    ${options}[endDate]    ${fecha_manana}
    ...    msg=❌ The end date should be '${fecha_manana}'. Found: "${options}[endDate]"

    Should Be Equal As Strings    ${options}[unlimitedUses]    False
    ...    msg=❌ 'unlimitedUses' should be False. Found: "${options}[unlimitedUses]"

    Should Be Equal As Integers    ${options}[maxUses]    2
    ...    msg=❌ 'maxUses' should be 2. Found: "${options}[maxUses]"

    Should Be Equal As Integers    ${options}[maxDailyUses]    2
    ...    msg=❌ 'maxDailyUses' should be 2. Found: "${options}[maxDailyUses]"

    Should Be Equal As Strings    ${options}[state]    available
    ...    msg=❌ The pass state should be 'available'. Found: "${options}[state]"

    Should Be True    ${options}[allRoutes]
    ...    msg=❌ 'allRoutes' should be True. Found: "${options}[allRoutes]"

    Length Should Be    ${options}[routeIds]    0
    ...    msg=❌ 'routeIds' should be empty. Found: "${options}[routeIds]"

    Length Should Be    ${options}[routeNames]    0
    ...    msg=❌ 'routeNames' should be empty. Found: "${options}[routeNames]"

    Length Should Be    ${options}[oddTypes]    0
    ...    msg=❌ 'oddTypes' should be empty. Found: "${options}[oddTypes]"

    ${pass_id}=    Set Variable    ${last_pass}[_id]
    Set Global Variable    ${pass_id}
    Log    ✅ Pass ID: ${pass_id}

    Sleep    30s


Get active product List (Before assign)
    [Documentation]     Se obtiene la lista de prodcutos activos, se verifica que haya stock(1) y precio(10)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/products/listActive?community=6654ae4eba54fe502d4e4187

    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${passes}=    Set Variable    ${response.json()}
    ${found}=     Set Variable    False
    ${product_id}=    Set Variable    NONE

    FOR    ${pass}    IN    @{passes}
    ${name}=         Set Variable    ${pass}[name]
    ${description}=  Set Variable    ${pass}[description]
    ${price}=        Set Variable    ${pass}[price]
    ${stock}=        Set Variable    ${pass}[stock]
    Run Keyword If    '${name}' == 'Automation Test Passes 2' and '${description}' == 'Automation Test Passes 2' and '${price}' == '10' and ${stock} == 2
    ...    Set Test Variable    ${found}    True
    Run Keyword If    '${name}' == 'Automation Test Passes 2' and '${description}' == 'Automation Test Passes 2' and '${price}' == '10' and ${stock} == 2
    ...    Set Test Variable    ${product_id}    ${pass}[_id]
    END

    Should Be True    ${found}    msg=❌ Product 'Automation Test Passes 2' with stock=0 not found in active product list.
    Log    ✅ Found Product ID: ${product_id}
    Set Global Variable    ${product_id}

    Sleep    30s


Assing Passes Manually From Admin 1
    [Documentation]    Se asigna el pase al usuario y se verifica que los usos restantes correspondan a lo configurado
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/assignToUser?community=6654ae4eba54fe502d4e4187
    ...    data={"userId":"${userId}","productId":"${product_id}","quantity":1,"userName":"UserRobotFramework"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${pass}=    Set Variable    ${response.json()}[0]

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected name to be 'Automation Test Passes 2' but got: ${pass}[name]

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes 2
    ...    msg=❌ Expected description to be 'Automation Test Passes 2' but got: ${pass}[description]

    Should Be Equal As Strings    ${pass}[productId]    ${product_id}
    ...    msg=❌ Expected productId to be '${product_id}' but got: ${pass}[productId]

    Should Be Equal As Strings    ${pass}[userId]    ${user_id}
    ...    msg=❌ Expected userId to be '${user_id}' but got: ${pass}[userId]

    Should Be Equal As Strings    ${pass}[maxUses]    2
    ...    msg=❌ Expected maxUses to be 2 but got: ${pass}[maxUses]

    Should Be Equal As Strings    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2 but got: ${pass}[maxDailyUses]

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True but got: ${pass}[allRoutes]

    ${assigned_pass_id}=    Set Variable    ${pass}[_id]
    Log    ✅ Assigned pass ID: ${assigned_pass_id}
    Set Global Variable    ${assigned_pass_id}
Assing Passes Manually From Admin 2
    [Documentation]    Se asigna el pase al usuario y se verifica que los usos restantes correspondan a lo configurado
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/assignToUser?community=6654ae4eba54fe502d4e4187
    ...    data={"userId":"${userId_2}","productId":"${product_id}","quantity":1,"userName":"UserRobotFramework 2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${pass}=    Set Variable    ${response.json()}[0]

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected name to be 'Automation Test Passes 2' but got: ${pass}[name]

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes 2
    ...    msg=❌ Expected description to be 'Automation Test Passes 2' but got: ${pass}[description]

    Should Be Equal As Strings    ${pass}[productId]    ${product_id}
    ...    msg=❌ Expected productId to be '${product_id}' but got: ${pass}[productId]

    Should Be Equal As Strings    ${pass}[userId]    ${userId_2}
    ...    msg=❌ Expected userId to be '${user_id}' but got: ${pass}[userId]

    Should Be Equal As Strings    ${pass}[maxUses]    2
    ...    msg=❌ Expected maxUses to be 2 but got: ${pass}[maxUses]

    Should Be Equal As Strings    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2 but got: ${pass}[maxDailyUses]

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True but got: ${pass}[allRoutes]

    ${assigned_pass_id_2}=    Set Variable    ${pass}[_id]
    Log    ✅ Assigned pass ID: ${assigned_pass_id_2}
    Set Global Variable    ${assigned_pass_id_2}

Get active product List (After assign-should be 0 passes left)
    [Documentation]    Se obtiene la lista de prodcutos activos, se verifica que NO haya stock(0) y precio(10)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/products/listActive?community=6654ae4eba54fe502d4e4187

    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${passes}=    Set Variable    ${response.json()}
    ${stock}=     Set Variable    NONE
    ${product_id}=    Set Variable    NONE

    FOR    ${pass}    IN    @{passes}
    ${name}=         Set Variable    ${pass}[name]
    ${description}=  Set Variable    ${pass}[description]
    ${price}=        Set Variable    ${pass}[price]
    ${stock_check}=  Set Variable    ${pass}[stock]
    Run Keyword If    '${name}' == 'Automation Test Passes 2' and '${description}' == 'Automation Test Passes 2' and '${price}' == '10'
    ...    Set Test Variable    ${stock}    ${stock_check}
    Run Keyword If    '${name}' == 'Automation Test Passes 2' and '${description}' == 'Automation Test Passes 2' and '${price}' == '10'
    ...    Set Test Variable    ${product_id}    ${pass}[_id]
    END

    Should Be Equal As Numbers    ${stock}    0
    ...    msg=❌ Expected stock to be 0 for product 'Automation Test Passes 2', but got: ${stock}

    Log    ✅ Found Product ID with stock=0: ${product_id}
    Set Global Variable    ${product_id}


    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Get Passes From User 1 (Step2 - Should be 1+)
    [Documentation]    Se verifica que se haya agregado correctamente el pase al usuario
    # Define the URL for authenticated resource
    ${url}=    Set Variable    ${STAGE_URL}/api/v2/products/user/purchased

    # Set request headers with token
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenNico}

    # Perform the GET request
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Extract transaction and passes
    ${transactions}=    Set Variable    ${response.json()}[transactions]
    ${first_transaction}=    Get From List    ${transactions}    0
    ${passes}=    Get From Dictionary    ${first_transaction}    passes

    # Ensure passes list is not empty
    Should Not Be Empty    ${passes}
    ...    msg=❌ 'passes' list is empty. No passes found in the transaction.

    # Get the last pass
    ${pass}=    Get From List    ${passes}    -1

    # Validate pass fields
    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected pass name to be 'Automation Test Passes 2' but got '${pass}[name]'

    Should Be Equal As Numbers    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2 but got '${pass}[maxDailyUses]'

    Should Be Equal As Strings    ${pass}[service]    privateBus
    ...    msg=❌ Expected service to be 'privateBus' but got '${pass}[service]'

    # Save _id globally for next steps
    ${passId}=    Get From Dictionary    ${pass}    _id
    Log    ✅ Found pass with _id: ${passId}
    Set Global Variable    ${passId}
Get Passes From User 2 (Step2 - Should be 1+)
    [Documentation]    Se verifica que se haya agregado correctamente el pase al usuario
    # Define the URL for authenticated resource
    ${url}=    Set Variable    ${STAGE_URL}/api/v2/products/user/purchased

    # Set request headers with token
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenNico2}

    # Perform the GET request
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Extract transaction and passes
    ${transactions}=    Set Variable    ${response.json()}[transactions]
    ${first_transaction}=    Get From List    ${transactions}    0
    ${passes}=    Get From Dictionary    ${first_transaction}    passes

    # Ensure passes list is not empty
    Should Not Be Empty    ${passes}
    ...    msg=❌ 'passes' list is empty. No passes found in the transaction.

    # Get the last pass
    ${pass}=    Get From List    ${passes}    -1

    # Validate pass fields
    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected pass name to be 'Automation Test Passes 2' but got '${pass}[name]'

    Should Be Equal As Numbers    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2 but got '${pass}[maxDailyUses]'

    Should Be Equal As Strings    ${pass}[service]    privateBus
    ...    msg=❌ Expected service to be 'privateBus' but got '${pass}[service]'

    # Save _id globally for next steps
    ${passId2}=    Get From Dictionary    ${pass}    _id
    Log    ✅ Found pass with _id: ${passId2}
    Set Global Variable    ${passId2}

Get Pass Detail Before validation 1
    [Documentation]    Se verifica el pase comprado desde la app usuario y que tenga 2 usos aún
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId}/passes/privateBus

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenNico}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected name to be 'Automation Test Passes 2', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes 2
    ...    msg=❌ Expected description to be 'Automation Test Passes 2', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    2
    ...    msg=❌ Expected remaining to be 2, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUsesAllowed]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUsesAllowed]'

    Should Be Equal As Numbers    ${pass}[used]    0
    ...    msg=❌ Expected used to be 0, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    2
    ...    msg=❌ Expected remainingDailyUses to be 2, but got '${pass}[remainingDailyUses]'

Get Pass Detail Before validation 2
    [Documentation]    Se verifica el pase comprado desde la app usuario y que tenga 2 usos aún
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId2}/passes/privateBus

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenNico2}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected name to be 'Automation Test Passes 2', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes 2
    ...    msg=❌ Expected description to be 'Automation Test Passes 2', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    2
    ...    msg=❌ Expected remaining to be 2, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUsesAllowed]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUsesAllowed]'

    Should Be Equal As Numbers    ${pass}[used]    0
    ...    msg=❌ Expected used to be 0, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    2
    ...    msg=❌ Expected remainingDailyUses to be 2, but got '${pass}[remainingDailyUses]'




Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad2}&driverId=68a5f2cf4909d4c0300b4704

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
    ...    data={"communityId":"${idComunidad2}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"672a5859d9b6f9e986592e3a","capacity":5,"busCode":"1111","driverCode":"10596","vehicleId":"${vehicleId}","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    ${departureId}=    Set Variable     ${response.json()}[_id]
    Set Global Variable    ${departureToken}
    Set Global Variable    ${departureId}

Get User QR(UserRobotFramework) 1
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["${userId}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}
Get User QR(UserRobotFramework) 2
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["${userId_2}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico2}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico2}
    Log    ${qrCodeNico2}
    Log    ${code}

Validate With QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad2}","validationString":"${qrCodeNico}","timezone":"America/Santiago","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s


Get Pass Detail After validation (Online)
    [Documentation]    Se verifica el descuento del pase luego de la validación online, debería quedan 1 solo uso
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId}/passes/privateBus

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenNico}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected name to be 'Automation Test Passes 2', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes 2
    ...    msg=❌ Expected description to be 'Automation Test Passes 2', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    1
    ...    msg=❌ Expected remaining to be 1, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUsesAllowed]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUsesAllowed]'

    Should Be Equal As Numbers    ${pass}[used]    1
    ...    msg=❌ Expected used to be 1, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    1
    ...    msg=❌ Expected remainingDailyUses to be 1, but got '${pass}[remainingDailyUses]'

    Sleep    17s

Sync pass validation offline
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/validations/sync/${idSuperCommunity}
    ...    data={"validations":[{"assignedSeat":"3","communityId":"${idComunidad2}","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico}","reason":[],"remainingTickets":0,"routeId":"68488d2a4ff298af70023813","synced":false,"token":"","userId":"${user_id}","validated":true},{"assignedSeat":"4","communityId":"${idComunidad2}","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr2}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico2}","reason":[],"remainingTickets":0,"routeId":"68488d2a4ff298af70023813","synced":false,"token":"","userId":"${userId_2}","validated":false}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
        ${validations}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${response.json()}
    Status Should Be    200

    FOR    ${validation}    IN    @{validations}
    # Verifica que cada objeto no esté vacío
        Should Not Be Empty    ${validation}    Validations info is empty
    END


Get Pass Detail After validation (Offline) Should not discount ticket due to time limitation
    [Documentation]    Se verifica que no se haya descontado ningún uso de pase dentro de los 29 segundos de restricción
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId}/passes/privateBus

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenNico}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected name to be 'Automation Test Passes 2', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes 2
    ...    msg=❌ Expected description to be 'Automation Test Passes 2', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    1
    ...    msg=❌ Expected remaining to be 1, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUsesAllowed]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUsesAllowed]'

    Should Be Equal As Numbers    ${pass}[used]    1
    ...    msg=❌ Expected used to be 1, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    1
    ...    msg=❌ Expected remainingDailyUses to be 1, but got '${pass}[remainingDailyUses]'

    Sleep    31s

Sync pass validation offline after pass time limit(30s)
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/validations/sync/${idSuperCommunity}
    ...    data={"validations":[{"assignedSeat":"3","communityId":"${idComunidad2}","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr4}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico}","reason":[],"remainingTickets":0,"routeId":"68488d2a4ff298af70023813","synced":false,"token":"","userId":"${user_id}","validated":true},{"assignedSeat":"4","communityId":"${idComunidad2}","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr3}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico2}","reason":[],"remainingTickets":0,"routeId":"68488d2a4ff298af70023813","synced":false,"token":"","userId":"${userId_2}","validated":false}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
        ${validations}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${response.json()}
    Status Should Be    200

    FOR    ${validation}    IN    @{validations}
    # Verifica que cada objeto no esté vacío
        Should Not Be Empty    ${validation}    Validations info is empty
    END


Get Pass Detail After validation (Offline) Should disctount ticket after 31 s
    [Documentation]    Se verifica el descuento del pase luego de la validación offline luego del limite de tiempo(30s) no deberían quedar usos

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId}/passes/privateBus
    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenNico}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected name to be 'Automation Test Passes 2', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes 2
    ...    msg=❌ Expected description to be 'Automation Test Passes 2', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    0
    ...    msg=❌ Expected remaining to be 0, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUsesAllowed]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUsesAllowed]'

    Should Be Equal As Numbers    ${pass}[used]    2
    ...    msg=❌ Expected used to be 2, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    0
    ...    msg=❌ Expected remainingDailyUses to be 0, but got '${pass}[remainingDailyUses]'


Get Pass Detail After validation (Offline) User 2
    [Documentation]    Se verifica el descuento del pase luego de la validación offline, no deberían quedar usos

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId2}/passes/privateBus
    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenNico2}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes 2
    ...    msg=❌ Expected name to be 'Automation Test Passes 2', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes 2
    ...    msg=❌ Expected description to be 'Automation Test Passes 2', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    2
    ...    msg=❌ Expected remaining to be 2, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUsesAllowed]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUsesAllowed]'

    Should Be Equal As Numbers    ${pass}[used]    0
    ...    msg=❌ Expected used to be 0, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    2
    ...    msg=❌ Expected remainingDailyUses to be 2, but got '${pass}[remainingDailyUses]'


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
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
Delete Product from Admin
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/${product_id}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    ${product}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${product}[active]    False
...    msg=❌ Expected product to be inactive (False), but got '${product}[active]'

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
Delete user from community 2
    [Documentation]    Se elimina al usuario de la comunidad
    Create Session    mysesion    ${STAGE_URL}    verify=true

    
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/${userId_2}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}

    ${deleted_user}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${deleted_user}[name]    UserRobotFramework 2
    ...    msg=❌ El nombre del usuario debería ser 'UserRobotFramework 2'. Se encontró: "${deleted_user}[name]"

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
