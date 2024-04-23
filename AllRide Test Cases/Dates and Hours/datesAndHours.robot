*** Settings ***
Library    DateTime
Library    Collections

*** Test Cases ***
Set Date Variables
    ${fecha_hoy}=    Get Current Date    result_format=%Y-%m-%d

    ${fecha_manana}=    Add Time To Date    ${fecha_hoy}    1 days     result_format=%Y-%m-%d

    ${fecha_pasado_manana}=    Add Time To Date    ${fecha_hoy}    2 days     result_format=%Y-%m-%d
    ${fecha_pasado_pasado_manana}=    Add Time To Date    ${fecha_hoy}    3 days    result_format=%Y-%m-%d

    ${dia_actual}=    Convert Date    ${fecha_hoy}    result_format=%a
    ${dia_actual_lower}=    Set Variable    ${dia_actual.lower()}

    ${arrival_date}=    Set Variable    ${fecha_manana}T01:00:00.000Z
    ${r_estimated_arrival1}=    Set Variable    ${fecha_manana}T14:45:57.000Z
    ${service_date}=    Set Variable    ${fecha_manana}T00:25:29.000Z
    ${modified_arrival_date}=    Set Variable    ${fecha_manana}T01:00:00.000Z
    ${r_modified_estimated_arrival}=    Set Variable    ${fecha_pasado_manana}T14:45:57.000Z
    ${modified_service_date}=    Set Variable    ${fecha_manana}T00:25:29.000Z
    ${service_date_20min}=    Set Variable    ${fecha_manana}T00:20:00.000Z
    ${service_date_22min}=    Set Variable    ${fecha_manana}T00:47:00.000Z
    ${start_date}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    ${end_date_4weeks}=    Set Variable    2023-12-30T02:59:59.999Z
    ${end_date}=    Set Variable    ${fecha_pasado_pasado_manana}T03:00:00.000Z
    ${end_date_tomorrow}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    ${schedule_day}=    Set Variable    ${dia_actual}
    ${start_date_today}=    Set Variable    ${fecha_hoy}T03:00:00.000Z
    ${today_date}=    Set Variable    ${fecha_hoy}
    ${end_date_tomorrow2}=    Set Variable    ${fecha_manana}T02:59:59.999Z
    ${expiration_date_qr}=    Set Variable    ${fecha_manana}T14:10:37.968Z
   ## ${today_historic_movement}=    Convert Date    ${fecha_manana}T03%3A00%3A00.000Z
   ## ${tomorrow_historic_movement}=    Convert Date    ${fecha_manana}T02%3A59%3A59.999Z

    Log Many    Hoy: ${fecha_hoy}
    Log Many    Mañana: ${fecha_manana}
    Log Many    Pasado Mañana: ${fecha_pasado_manana}
    Log Many    Pasado Pasado Mañana: ${fecha_pasado_pasado_manana}
    Log Many    Día Actual: ${dia_actual}

    Log Many    Arrival Date: ${arrival_date}
    Log Many    R Estimated Arrival 1: ${r_estimated_arrival1}
    Log Many    Service Date: ${service_date}
    Log Many    Modified Arrival Date: ${modified_arrival_date}
    Log Many    R Modified Estimated Arrival: ${r_modified_estimated_arrival}
    Log Many    Modified Service Date: ${modified_service_date}
    Log Many    Service Date 20min: ${service_date_20min}
    Log Many    Service Date 22min: ${service_date_22min}
    Log Many    Start Date: ${start_date}
    Log Many    End Date 4 Weeks: ${end_date_4weeks}
    Log Many    End Date: ${end_date}
    Log Many    End Date Tomorrow: ${end_date_tomorrow}
    Log Many    Schedule Day: ${schedule_day}
    Log Many    Start Date Today: ${start_date_today}
    Log Many    Today Date: ${today_date}
    Log Many    End Date Tomorrow 2: ${end_date_tomorrow2}
    Log Many    Expiration Date QR: ${expiration_date_qr}
    
    Log Many    Hoy: ${fecha_hoy}
    Log Many    Mañana: ${fecha_manana}
    Log Many    Pasado Mañana: ${fecha_pasado_manana}
    Log Many    Pasado Pasado Mañana: ${fecha_pasado_pasado_manana}
    Log Many    Día Actual: ${dia_actual.lower}

    Log Many    Arrival Date: ${arrival_date}
    