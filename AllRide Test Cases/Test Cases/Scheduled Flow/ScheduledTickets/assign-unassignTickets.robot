*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../../Variables/variablesStage.robot

*** Variables ***
${continue_flow}    True


*** Keywords ***
Stop Execution If Previous Failed
    [Arguments]    ${flag}    ${reason}
    Run Keyword If    '${flag}' == 'False'    Skip    ${reason}

Mark Flow As Failed
    [Arguments]    ${reason}
    Log    ${reason}
    Set Global Variable    ${continue_flow}    False


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
    ${start_date_tickets}=    Set Variable    ${fecha_hoy}T04:00:00.000Z
    Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=    Set Variable    ${fecha_manana}T03:59:59.999Z
    Set Global Variable    ${end_date_tickets}

    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}


Assing Tickets(carpool 4, Legacy Tickets)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=6654ae4eba54fe502d4e4187&userId=68d581be1ee85dd206e05804&ticketsQuantityToAssign=3
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Assing Tickets(carpool 4, Product Tickets)
    [Documentation]     Validate that the last available ticket in the response has the expected structure and values

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/assignToUser?community=6654ae4eba54fe502d4e4187
    ...    data={"userId":"68d581be1ee85dd206e05804","productId":"68f0e77c73abb0c9d176e04b","quantity":3}
    ...    headers=${headers}



    # ✅ Retrieve and isolate the last ticket
    ${tickets}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${tickets}    msg=❌ Ticket list should not be empty
    ${last_ticket}=    Set Variable    ${tickets}[-1]

    # ✅ Core validations
    Should Not Be Empty    ${last_ticket["_id"]}
    ...    msg=❌ Ticket _id is missing

    Should Be Equal As Strings    ${last_ticket["state"]}    available
    ...    msg=❌ Ticket state should be 'available'

    Should Not Be Empty    ${last_ticket["qrCode"]}
    ...    msg=❌ Ticket QR code should not be empty

    # ✅ Community validation
    Should Be Equal As Strings    ${last_ticket["communities"][0]}    6654ae4eba54fe502d4e4187
    ...    msg=❌ Community ID mismatch

    Should Be Equal As Strings    ${last_ticket["superCommunities"][0]}    653fd68233d83952fafcd4be
    ...    msg=❌ SuperCommunity ID mismatch

    # ✅ Product & User validation
    Should Be Equal As Strings    ${last_ticket["productId"]}    68f0e77c73abb0c9d176e04b
    ...    msg=❌ Product ID mismatch

    Should Be Equal As Strings    ${last_ticket["userId"]}    68d581be1ee85dd206e05804
    ...    msg=❌ User ID mismatch

    # ✅ General attributes
    Should Be Equal As Strings    ${last_ticket["name"]}    Tickets resto Octubre asignación y desasignación
    ...    msg=❌ Ticket name mismatch

    Should Be Equal As Strings    ${last_ticket["description"]}    Tickets resto Octubre asignación y desasignación
    ...    msg=❌ Ticket description mismatch

    Should Be Equal As Strings    ${last_ticket["endDate"]}    2030-12-14T00:00:00.000Z
    ...    msg=❌ Ticket endDate mismatch

    # ✅ Type & structure
    Should Be True    ${last_ticket["allRoutes"]}
    ...    msg=❌ allRoutes should be True

    Length Should Be    ${last_ticket["oddTypes"]}    0
    ...    msg=❌ oddTypes should be empty

    Length Should Be    ${last_ticket["routeIds"]}    0
    ...    msg=❌ routeIds should be empty

    Length Should Be    ${last_ticket["routeNames"]}    0
    ...    msg=❌ routeNames should be empty

    # ✅ Created & updated timestamps
    Should Not Be Empty    ${last_ticket["createdAt"]}
    ...    msg=❌ createdAt timestamp is missing

    Should Not Be Empty    ${last_ticket["updatedAt"]}
    ...    msg=❌ updatedAt timestamp is missing



Get Assigned Tickets (Legacy - Carpool4)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=6654ae4eba54fe502d4e4187&productId=675aef507537a28101ec930c
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyCarpool4}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "68d581be1ee85dd206e05804"    BREAK
        Set Global Variable    ${assignedQtyCarpool4}
    END

    Should Be True
    ...    ${assignedQtyCarpool4}==3
    ...    Assigned tickets Nico Carpool 4 should be 3 but it is ${assignedQtyCarpool4} The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyCarpool4}
Get Assigned Tickets (Product - Carpool4)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=6654ae4eba54fe502d4e4187&productId=68f0e77c73abb0c9d176e04b

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyCarpool4Product}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "68d581be1ee85dd206e05804"    BREAK
        Set Global Variable    ${assignedQtyCarpool4Product}
    END

    Should Be True
    ...    ${assignedQtyCarpool4Product}==3
    ...    Assigned Product tickets Nico Carpool 4 should be 3 but it is ${assignedQtyCarpool4Product} The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyCarpool4Product}
unAssign Tickets(Nico)
    [Documentation]    Solo se quita un ticket legacy de la vista cliente, debería descontarse solo el ticket seleccionado
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=6654ae4eba54fe502d4e4187&userId=68d581be1ee85dd206e05804&ticketsQuantityToAssign=2
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)




Get Assigned Tickets After unassign(Legacy - Carpool4)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=6654ae4eba54fe502d4e4187&productId=675aef507537a28101ec930c
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyCarpool4}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "68d581be1ee85dd206e05804"    BREAK
        Set Global Variable    ${assignedQtyCarpool4}
    END

    Should Be True
    ...    ${assignedQtyCarpool4}==2
    ...    Assigned tickets Nico Carpool 4 should be 2 but it is ${assignedQtyCarpool4} The unassignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyCarpool4}
Get Assigned Tickets (Product - Carpool4)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=6654ae4eba54fe502d4e4187&productId=68f0e77c73abb0c9d176e04b

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyCarpool4Product}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "68d581be1ee85dd206e05804"    BREAK
        Set Global Variable    ${assignedQtyCarpool4Product}
    END

    Should Be True
    ...    ${assignedQtyCarpool4Product}==3
    ...    Assigned Product tickets Nico should be 3 but it is ${assignedQtyCarpool4Product} The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyCarpool4Product}


Assing Tickets(carpool 4, Legacy Tickets) second case
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=6654ae4eba54fe502d4e4187&userId=68d581be1ee85dd206e05804&ticketsQuantityToAssign=3
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Assing Tickets(carpool 4, Product Tickets) second case
    [Documentation]     Validate that the last available ticket in the response has the expected structure and values

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/assignToUser?community=6654ae4eba54fe502d4e4187
    ...    data={"userId":"68d581be1ee85dd206e05804","productId":"68f0e77c73abb0c9d176e04b","quantity":3}
    ...    headers=${headers}



    # ✅ Retrieve and isolate the last ticket
    ${tickets}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${tickets}    msg=❌ Ticket list should not be empty
    ${last_ticket}=    Set Variable    ${tickets}[-1]

    # ✅ Core validations
    Should Not Be Empty    ${last_ticket["_id"]}
    ...    msg=❌ Ticket _id is missing

    Should Be Equal As Strings    ${last_ticket["state"]}    available
    ...    msg=❌ Ticket state should be 'available'

    Should Not Be Empty    ${last_ticket["qrCode"]}
    ...    msg=❌ Ticket QR code should not be empty

    # ✅ Community validation
    Should Be Equal As Strings    ${last_ticket["communities"][0]}    6654ae4eba54fe502d4e4187
    ...    msg=❌ Community ID mismatch

    Should Be Equal As Strings    ${last_ticket["superCommunities"][0]}    653fd68233d83952fafcd4be
    ...    msg=❌ SuperCommunity ID mismatch

    # ✅ Product & User validation
    Should Be Equal As Strings    ${last_ticket["productId"]}    68f0e77c73abb0c9d176e04b
    ...    msg=❌ Product ID mismatch

    Should Be Equal As Strings    ${last_ticket["userId"]}    68d581be1ee85dd206e05804
    ...    msg=❌ User ID mismatch

    # ✅ General attributes
    Should Be Equal As Strings    ${last_ticket["name"]}    Tickets resto Octubre asignación y desasignación
    ...    msg=❌ Ticket name mismatch

    Should Be Equal As Strings    ${last_ticket["description"]}    Tickets resto Octubre asignación y desasignación
    ...    msg=❌ Ticket description mismatch

    Should Be Equal As Strings    ${last_ticket["endDate"]}    2030-12-14T00:00:00.000Z
    ...    msg=❌ Ticket endDate mismatch

    # ✅ Type & structure
    Should Be True    ${last_ticket["allRoutes"]}
    ...    msg=❌ allRoutes should be True

    Length Should Be    ${last_ticket["oddTypes"]}    0
    ...    msg=❌ oddTypes should be empty

    Length Should Be    ${last_ticket["routeIds"]}    0
    ...    msg=❌ routeIds should be empty

    Length Should Be    ${last_ticket["routeNames"]}    0
    ...    msg=❌ routeNames should be empty

    # ✅ Created & updated timestamps
    Should Not Be Empty    ${last_ticket["createdAt"]}
    ...    msg=❌ createdAt timestamp is missing

    Should Not Be Empty    ${last_ticket["updatedAt"]}
    ...    msg=❌ updatedAt timestamp is missing


unAssign Tickets(Nico) to 0
    [Documentation]    Solo se quita un ticket legacy de la vista cliente, debería descontarse solo el ticket seleccionado
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=6654ae4eba54fe502d4e4187&userId=68d581be1ee85dd206e05804&ticketsQuantityToAssign=0
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Get Assigned Tickets After unassign to 0(Legacy - Carpool4)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=6654ae4eba54fe502d4e4187&productId=675aef507537a28101ec930c
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyCarpool4}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "68d581be1ee85dd206e05804"    BREAK
        Set Global Variable    ${assignedQtyCarpool4}
    END

    Should Be True
    ...    ${assignedQtyCarpool4}==0
    ...    Assigned tickets Nico Carpool 4 should be 0 but it is ${assignedQtyCarpool4} The unassignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyCarpool4}


Get Assigned Tickets (Product - Carpool4) should keep 3 tickets
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=6654ae4eba54fe502d4e4187&productId=68f0e77c73abb0c9d176e04b

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyCarpool4Product}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "68d581be1ee85dd206e05804"    BREAK
        Set Global Variable    ${assignedQtyCarpool4Product}
    END

    Should Be True
    ...    ${assignedQtyCarpool4Product}==6
    ...    Assigned Product tickets Nico should be 6 but it is ${assignedQtyCarpool4Product} The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyCarpool4Product}

Unnasign Ticket Product
    [Documentation]    Se edita la cantidad total de tickets productos a 0
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/editUserProduct?community=6654ae4eba54fe502d4e4187
    ...    data={"userId":"68d581be1ee85dd206e05804","product":{"_id":"68f0e77c73abb0c9d176e04b","quantity":0},"admin":{"_id":"66d75c62a1b7bc9a1dd231c6","roleId":null},"ref":"pb_ticket"}
    ...    headers=${headers}