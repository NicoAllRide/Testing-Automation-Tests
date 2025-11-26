

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

### join withot params
## Join with params
### create withot params --debería tener solo el servicio de Limitada
### create with params --- debería tener por defecto solo el servicio de Taxis Nico solo a los que tengan Color rosado


Delete params from community 1
   [Documentation]     Joins a community using RUT and "Color" parameter, validates that both services are active
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8

    ${response}=    Put On Session
    ...    mysesion
    ...    url=/api/v1/admin/community/688c2f3da4c7c7ffe5c44aeb
    ...    data={"_id":"688c2f3da4c7c7ffe5c44aeb","config":{"general":{"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"userPhoneNumber":{"enabled":false},"validationParams":{"enabled":true,"params":[{"show":true,"mandatory":false,"private":false,"name":"rut","description":"","dataType":"rut","check":false,"isUserStop":false,"internal":false,"validationExpr":"","options":[],"triggeredFns":[]}],"allowMultipleUseValidationCodes":false,"allowsJoinRequests":{"enabled":false}},"externalInfo":{"customMap":{}},"balance":{"enabled":true},"ui":{"design":{"isoType":"","logoType":"","color":""}},"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"products":{"enabled":false,"treatManualAssignmentsAsTransactions":false,"feePercentage":0,"stripe":{"connectedAccountId":null,"useProductConnectedAccountId":false}},"tutorials":{"userApp":{"products":{"enabled":false}}},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":true,"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"allowsCustomJoinWithoutEmailCheck":false,"hasUserMessagingSystem":false,"public":true,"assocCommunities":null,"allowsValidationOptions":false,"isStudentsCommunity":false,"use24hFormat":false},"privateBus":{"ui":{"admin":{"fulfillmentReport":{"hiddenRoutes":[]},"dashboard":{"markersLabel":"default"},"_id":"688c2f78a4c7c7ffe5c44b2f"}},"admin":{"icTable":{"startServiceButton":false}},"oDDSettings":{"joinNewAdminODDs":false,"enableToNewUsers":{"enabled":false,"specificParams":{"enabled":false,"params":[]}},"latestUserStopsSearch":false,"useCorrelativeIdAsName":{"enabled":false,"useType":"prefix","editable":true},"restrictedZones":{"enabled":false,"zones":[]},"showOtherReason":true,"allowsTemporaryStops":false},"scheduling":{"enabled":false,"allowSeatReservations":false,"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":false,"limitTime":null,"limitUnit":"minutes"},"reservation":{"restrictions":{"enabled":false,"amount":0,"time":1,"unit":"days","userSkip":[]}},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"admin":{"skipAllReservationsAssignedCheck":false},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4,"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"serviceCreationLimit":{"enabled":false,"date":null}},"budgetSystem":{"enabled":false},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"notifyAdmins":{"notifyIdleTime":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"amount":5,"unit":"minutes"}},"restrictiveLabels":{"enabled":false,"labels":[]},"validation":{"accessToken":{"enabled":true,"allowsSkip":false},"timestamp":{"userSkip":[],"enabled":false,"allowsSkip":false},"dailyLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null},"timeLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null,"time":null,"unit":""},"departureLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null},"DNIValidation":{"enabled":false,"field":"","allowsExternal":false},"bCValidation":{"enabled":false,"field":""},"customQRValidation":{"enabled":false,"field":""},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":false,"dataType":"text","options":[],"name":"","description":""},"customValidationParams":{"driverParams":[],"passengerParams":[],"maxValidationTime":{"amount":1,"unit":"hours"}},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"enabled":false,"allowsStatic":false,"usesTickets":false,"usesPasses":false,"ticketPrice":null,"internalNFCField":"","external":[]},"assistant":{"entryTimes":[],"departureTimes":[],"enabled":false,"collecting":false,"description":""},"poll":{"active":false,"answeredBy":[]},"rateRoute":{"enabled":false,"withValidation":false},"snapshots":{"service":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}}},"harassmentAssistanceSettings":{"enabled":false,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"reports":{"boardingReport":false,"visibleCode":"plate"},"driverApp":{"visibleCode":"plate","allowsWhatsAppMessages":false,"dataRefreshPeriod":null,"localValidationTime":null,"showOnlyScheduledServices":false,"version":"","showBoxOnValidatePassenger":{"qr":true,"dni":true,"barCode":true},"ui":{"showCapacity":true,"showFullBtn":true,"showValidateBtn":true,"showBoardingsBtn":true,"showUnboardingsBtn":true,"showTicketCounter":true,"showRoundsCounter":true,"showBarrierBtn":true,"showGoogleMapsBtn":true}},"passengerApp":{"visibleCode":"plate","allowsWhatsAppMessages":false},"driverCustomParams":{"enabled":false,"params":[]},"fleetCustomParams":{"enabled":false,"params":[]},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":false},"emergencyCall":{"enabled":true},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"restrictRTL":{"enabled":false},"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"userApp":{"allowsMultipleReservations":{"enabled":false,"amountLimit":0},"exploreMode":"standard"},"speedAlert":{"enabled":false,"limit":27.78,"notify":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"inactiveGPSAlert":{"notify":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false,"notify":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"fineManagementSystem":{"enabled":false,"types":[],"possibleOrigins":[],"stateNotifications":[]},"ETA":{"enabled":false,"update":{"amount":0,"unit":"minutes"},"visibility":["admin"],"notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"chatSystem":{"defaultMessages":{"user":[],"driver":[]}},"enabled":true,"visible":true,"apportionCategories":[],"labels":[],"allowsRating":false,"allowsSnapshots":false,"allowsScreenshots":false,"usesPin":false,"noPassengerInfo":false,"allowGenericVehicles":false,"continuousGpsAlwaysOn":false,"locationCacheDuration":360,"driverCanCreateRoutes":false,"oDDServices":[],"auxiliaryTrackers":[],"showStandbyDrivers":true,"trackersVisibility":[],"standbyTrackersVisibility":[],"odd":{"pricing":{"timeDistanceConfig":{"tolls":{"manual":[]},"additionalCharges":[]},"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyPassengersWithoutReservation":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyAdmins":{"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"driverReject":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"serviceCanceled":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"rejectedByProvider":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false}},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":false},"validateDeparture":{"enabled":false},"userRequests":{"enableToNewUsers":{"specificParams":{"enabled":false,"params":[]},"enabled":false},"reasons":{"list":[]},"adminApprovalByDefault":true,"schedules":[]},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false}},"restrictRequests":{"forService":{"settings":{"userCustomParams":{"params":[]},"geographical":{"zones":[]},"providers":[]}},"forProviders":{"settings":[]}},"endServiceLegAutomatically":{"estimatedDuration":{"byPercentage":{"timer":{"amount":5,"unit":"minutes"}},"byTime":{"timer":{"amount":5,"unit":"minutes"},"unit":"minutes"}},"timer":{"amount":5,"unit":"minutes"},"distance":100},"mandatoryUserParams":{"enabled":false,"params":[]},"enabled":false,"reasons":[],"hideEstimatedTimes":false,"allowsMultipleDrivers":false,"allowsDistance":false,"_id":"688c2f78a4c7c7ffe5c44b30","entryTimes":[],"exitTimes":[],"legOptions":[],"notifications":[],"approvers":[]},"createServices":{"enabled":true},"harassmentAssistance":false},"parking":{"enabled":false,"visible":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false,"requiredBoardingConditions":{"startWithRTL":false,"pickupLocationTolerance":false,"boardingTimeWindow":false,"driverPassengerProximity":false,"boardingQueryDelay":false}},"carpool":{"boardingConditions":{"enabled":false,"startWithRTL":false,"pickupLocationTolerance":{"enabled":false,"value":200},"boardingTimeWindow":{"enabled":false,"value":30},"driverPassengerProximity":{"enabled":false,"value":100},"boardingQueryDelay":{"enabled":false,"value":1}},"emergencyCall":{"enabled":true},"enabled":false,"visible":true,"communityOptions":false,"routePublishingOptions":[],"routeSearchRestrictions":[],"divisionKey":null,"categories":{"perPassenger":false,"config":{"subsidy":{"enabled":true,"amount":0,"informationText":"","companyText":""},"priority":90,"_id":"688c2f3da4c7c7ffe5c44af0","name":"no_charge","enabled":true,"currency":"clp","description":"","params":[{"_id":"688c2f3da4c7c7ffe5c44af1","name":"communities","value":"688c2f3da4c7c7ffe5c44aeb","createdAt":"2025-08-01T03:06:37.153Z","updatedAt":"2025-08-01T03:06:37.153Z"}],"createdAt":"2025-08-01T03:06:37.155Z","updatedAt":"2025-10-23T15:31:20.957Z","__v":0}}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"enabled":true,"visible":true,"hasSOS":true},"schoolBus":{"enabled":false,"visible":true},"publicBus":{"enabled":true,"visible":true}},"custom":{"hasSubsidy":{"active":false,"subsidizedUsers":[]},"realTimeTransportSystem":{"buses":{"oDDSettings":{"enableToNewUsers":{"specificParams":{"enabled":false,"params":[]},"enabled":false},"joinNewAdminODDs":false},"scheduling":{"admin":{"skipAllReservationsAssignedCheck":false},"dynamicResourceAssignment":{"enabled":false,"limitTime":15,"limitUnit":"minutes"},"reservation":{"restrictions":{"customParams":{"enabled":false,"dataType":"text","options":[]},"unit":"days","userSkip":[]},"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"exceedValidationLimit":{"enabled":false},"notifyAdmins":{"fullService":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"driverReject":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false}},"autoAssignReservations":{"enabled":false},"apportioning":{"enabled":false,"type":"estimated"},"enabled":false,"serviceCreationAnticipation":4,"allowSeatReservations":false},"budgetSystem":{"enabled":false},"notifyPassBudgetPercentage":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"percentages":{"general":{"enabled":false,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}},"enabled":false},"restrictiveLabels":{"enabled":false,"labels":[]},"validation":{"accessToken":{"userSkip":[]},"timestamp":{"userSkip":[]},"dailyLimit":{"userSkip":[]},"timeLimit":{"userSkip":[]},"departureLimit":{"userSkip":[]},"DNIValidation":{"enabled":false,"failureMessage":"Solo puedes presentar el código de AllRideo o de tu cédula de identidad.","showRejected":true,"options":["qr"]},"bCValidation":{"enabled":false},"customQRValidation":{"enabled":false},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":false,"dataType":"text","options":[]},"customValidationParams":{"passengerParams":[],"driverParams":[]},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"external":[]},"assistant":{"entryTimes":[],"departureTimes":[]},"poll":{"active":false,"answeredBy":[]},"wfIntegration":{"enabled":false},"tracker":{"enabled":false},"rateRoute":{"enabled":false,"withValidation":false},"snapshots":{"service":{"enabled":false},"nonService":{"enabled":false}},"harassmentAssistanceSettings":{"enabled":false,"showTextAbove":true,"showInformation":true},"emergencyCall":{"enabled":true},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"custom":{"reports":{"visibleCode":"plate"},"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"}},"driverCustomParams":{"enabled":false,"params":[]},"fleetCustomParams":{"enabled":false,"params":[]},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"routeDeviation":{"notify":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"maxDistance":100,"maxTime":5,"enabled":false},"fineManagementSystem":{"enabled":false,"types":[],"possibleOrigins":[],"stateNotifications":[]},"apportionCategories":[],"labels":[],"allowsRating":false,"allowsSnapshots":false,"allowsScreenshots":true,"usesPin":false,"harassmentAssistance":false,"noPassengerInfo":false,"allowGenericVehicles":false,"continuousGpsAlwaysOn":false,"oDDServices":[],"auxiliaryTrackers":[]},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCall":{"enabled":true},"enabled":true,"communityOptions":true,"routePublishingOptions":[],"routeSearchRestrictions":[]},"cabpool":{"hasSOS":true},"schoolbus":{"enabled":true}},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[],"allowsJoinRequests":{"enabled":false}},"parkingLots":{"specificLots":{"enabled":false,"lotIds":[]},"exitReminderTime":{"time":5,"unit":"minutes"},"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hour"},"notifyInactiveUsers":{"enabled":false,"days":7},"fullName":{"enabled":false},"enabled":false,"enableToAllUsers":false,"busIntegration":false,"reservationByDay":false,"reservationModel":"priority","accessModel":"reservation","maxAvailableDays":5,"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"sections":false,"allowsScreenshots":true,"lotIdsAndKeysParams":[],"ranges":[]},"balance":{"enabled":true},"products":{"enabled":false},"betaFeatures":[],"allowsManualUsers":false,"replacesManualUser":true,"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"hasUserMessagingSystem":false},"emailSuffixes":["allrideapp.com"],"admins":[],"timezone":"Chile/Continental","type":"normal","distance":0,"allowAds":false,"assocCommunities":[],"public":true,"name":"Pruebas Nico (customJoin)","site":"http://adminstage.allrideapp.com","terms":null,"country":"cl","hasBusesSystem":true,"language":"es","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_688c2f3da4c7c7ffe5c44aeb_1754017655840.png","badge":"https://s3.amazonaws.com/allride.uploads/communityAvatar_688c2f3da4c7c7ffe5c44aeb_1754017656299.png","createdAt":"2025-08-01T03:06:37.105Z","updatedAt":"2025-10-21T13:05:19.335Z","__v":497}

    ...    headers=${headers}


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
    ...    data={"community":"6654ae4eba54fe502d4e4187","values":[{"key":"rut","value":"111111111","listValue":null,"public":true,"check":true,"listOfRoutes":false},{"key":"address","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"coordinates","value":"","listValue":null,"public":false,"check":false,"listOfRoutes":false},{"key":"Color","value":"Rosado","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"Animal","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false},{"key":"Empresa","value":"","listValue":null,"public":true,"check":false,"listOfRoutes":false}],"validated":false}
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
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","country":"cl","name":"UserRobotFramework","customValidation":{"rut":"111111111","address":"Rengo, O'Higgins, Chile","coordinates":"-34.4028433,-70.8608394","Color":"Rosado","Animal":"Perro","Empresa":"AllRide"},"phoneNumber":null}
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
    Should Be Equal As Strings    ${custom}[3][value]   Rosado
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

    # Validar que odd.needsAdminApproval sea False (debe seguir al único servicio activo)
    ${odd}=    Get From Dictionary    ${privateBus}    odd
    Should Be Equal As Strings    ${odd}[needsAdminApproval]    True    msg=❌ 'odd.needsAdminApproval' debería ser True
    # Validar que existen exactamente dos oDDServices
    ${services}=    Get From Dictionary    ${privateBus}    oDDServices
    Length Should Be    ${services}    2    msg=❌ El usuario debería tener exactamente dos oDDServices

    ${service1}=    Get From List    ${services}    0
    ${service2}=    Get From List    ${services}    1

    # Validar que uno sea 'Taxis Nico' con needsAdminApproval=True
    Run Keyword If    '${service1}[name]' == 'Taxis Nico'
    ...    Should Be Equal As Strings    ${service1}[needsAdminApproval]    True    msg=❌ 'Taxis Nico' debería tener needsAdminApproval=True
    Run Keyword If    '${service2}[name]' == 'Taxis Nico'
    ...    Should Be Equal As Strings    ${service2}[needsAdminApproval]    True    msg=❌ 'Taxis Nico' debería tener needsAdminApproval=True

    # Validar que uno sea 'Limitada Nico' con needsAdminApproval=False
    Run Keyword If    '${service1}[name]' == 'Limitada Nico'
    ...    Should Be Equal As Strings    ${service1}[needsAdminApproval]    False    msg=❌ 'Limitada Nico' debería tener needsAdminApproval=False
    Run Keyword If    '${service2}[name]' == 'Limitada Nico'
    ...    Should Be Equal As Strings    ${service2}[needsAdminApproval]    False    msg=❌ 'Limitada Nico' debería tener needsAdminApproval=False


Find created user manually
    [Documentation]    Searches for the most recently created user and verifies that their data is correct

    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8

    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/listPagination?page=1&pageSize=200&community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    
    ${last_user}=    Set Variable    ${response.json()}[users][-1]

    Should Be Equal As Strings    ${last_user}[name]    UserRobotFramework
    ...    msg=❌ The name of the last user should be 'UserRobotFramework'. Found: "${last_user}[name]"

    Should Be Equal As Strings    ${last_user}[_id]    ${userId}
    ...    msg=❌ The _id of the last user should be '${userId}'. Found: "${last_user}[_id]"

    # Validate that it was created from admin
    Should Be Equal As Strings    ${last_user}[createdFromAdmin]    True
    ...    msg=❌ The 'createdFromAdmin' field should be True. Found: "${last_user}[createdFromAdmin]"

    # Validate avatar is placeholder
    Should Contain    ${last_user}[avatar]    user_placeholder.png
    ...    msg=❌ The avatar should be the default placeholder. Found: "${last_user}[avatar]"




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
Login User With Email(Obtain Token)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+comunidad@allrideapp.com","password":"Lolowerty21@"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    List Should Contain Value    ${response.json()}    accessToken    No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}


Join Community
    [Documentation]     Joins a community using RUT and validates that only the 'Limitada Nico' service is active
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json; charset=utf-8

    ${response}=    Post On Session
    ...    mysesion
    ...    url=${stage_url}/api/v1/communities/customJoin/6654ae4eba54fe502d4e4187
    ...    data={"rut": "98863257"}
    ...    headers=${headers}

    ${json}=         Convert To Dictionary    ${response.json()}
    ${joinedUserId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${joinedUserId}
    ${community}=    Get From List    ${json}[communities]    0
    ${privateBus}=   Get From Dictionary    ${community}    privateBus

    # Validate that privateBus is enabled
    Should Be Equal As Strings    ${privateBus}[enabled]    True    msg=❌ 'privateBus.enabled' should be True

    # Validate that odd.needsAdminApproval is still True (inherited from first service)
    ${odd}=    Get From Dictionary    ${privateBus}    odd
    Should Be Equal As Strings    ${odd}[needsAdminApproval]    True    msg=❌ 'odd.needsAdminApproval' should be True

    # Validate that exactly one service is active
    ${services}=    Get From Dictionary    ${privateBus}    oDDServices
    ${actual_len}=    Get Length    ${services}
    Length Should Be    ${services}    2    msg=❌ Expected exactly 2 active oDDService, but found ${actual_len}



###Jooin user from community
### Eliminar de la comunidad
Delete user from community
    [Documentation]     Deletes a user from the community and validates their remaining data is correct

    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8

    ${response}=    Delete On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/${joinedUserId}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}

    ${json}=    Set Variable    ${response.json()}

    # Validate user's name
    Should Be Equal As Strings    ${json}[name]    Nico Comunidad
    ...    msg=❌ User name should be 'Nico Comunidad'. Found: "${json}[name]"

    # Validate country
    Should Be Equal As Strings    ${json}[country]    cl
    ...    msg=❌ User country should be 'cl'. Found: "${json}[country]"

    # Validate active status
    Should Be Equal As Strings    ${json}[active]    True
    ...    msg=❌ User should be active. Found: "${json}[active]"

    # Validate no associated communities
    ${community_count}=    Get Length    ${json}[communities]
    Length Should Be    ${json}[communities]    0
    ...    msg=❌ User should not belong to any communities. Found: ${community_count}

    # Validate email is correct
    ${email}=    Get From List    ${json}[emails]    0
    Should Be Equal As Strings    ${email}[email]    nicolas+comunidad@allrideapp.com
    ...    msg=❌ User email should be 'nicolas+comunidad@allrideapp.com'. Found: "${email}[email]"

    # Validate privateBus config values
    ${config}=    Get From Dictionary    ${json}    config
    ${privateBus}=    Get From Dictionary    ${config}    privateBus

    Should Be Equal As Strings    ${privateBus}[showSection]    True
    ...    msg=❌ 'privateBus.showSection' should be True. Found: "${privateBus}[showSection]"

    Should Be Equal As Strings    ${privateBus}[canBeValidated]    True
    ...    msg=❌ 'privateBus.canBeValidated' should be True. Found: "${privateBus}[canBeValidated]"

    Should Be Equal As Strings    ${privateBus}[canBook]    True
    ...    msg=❌ 'privateBus.canBook' should be True. Found: "${privateBus}[canBook]"


Join Community With Params
    [Documentation]     Joins a community using RUT and "Color" parameter, validates that both services are active

    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${accessTokenNico}
    ...    Content-Type=application/json; charset=utf-8

    ${response}=    Post On Session
    ...    mysesion
    ...    url=${stage_url}/api/v1/communities/customJoin/6654ae4eba54fe502d4e4187
    ...    data={"rut": "98863257", "Color": "Rosado"}
    ...    headers=${headers}

    ${json}=         Convert To Dictionary    ${response.json()}
    ${joinedUserId}=    Set Variable    ${json}[_id]
    Set Global Variable    ${joinedUserId}
    ${community}=    Get From List    ${json}[communities]    0
    ${privateBus}=   Get From Dictionary    ${community}    privateBus

    # Validaciones generales de configuración de comunidad
    Should Be Equal As Strings    ${privateBus}[enabled]    True
    ...    msg=❌ 'privateBus.enabled' should be True. Found: ${privateBus}[enabled]

    ${odd}=    Get From Dictionary    ${privateBus}    odd
    Should Be Equal As Strings    ${odd}[needsAdminApproval]    True
    ...    msg=❌ 'odd.needsAdminApproval' should be True. Found: ${odd}[needsAdminApproval]

    ${services}=    Get From Dictionary    ${privateBus}    oDDServices
    ${actual_service_count}=    Get Length    ${services}
    Length Should Be    ${services}    2
    ...    msg=❌ Expected exactly 2 active oDDServices. Found: ${actual_service_count}

    ${serviceNames}=    Create List
    FOR    ${s}    IN    @{services}
        ${name}=    Get From Dictionary    ${s}    name
        Append To List    ${serviceNames}    ${name}
    END
    List Should Contain Value    ${serviceNames}    Limitada Nico
    ...    msg=❌ Missing service 'Limitada Nico'. Found services: ${serviceNames}
    List Should Contain Value    ${serviceNames}    Taxis Nico
    ...    msg=❌ Missing service 'Taxis Nico'. Found services: ${serviceNames}

    # Verificación directa de parámetros personalizados
    ${custom}=    Get From Dictionary    ${community}    custom

    Should Be Equal As Strings    ${custom[0]['key']}    rut
    ...    msg=❌ Expected custom[0].key to be 'rut'. Found: ${custom[0]['key']}
    Should Be Equal As Strings    ${custom[0]['value']}    98863257
    ...    msg=❌ 'rut' value should be 98863257. Found: ${custom[0]['value']}

    Should Be Equal As Strings    ${custom[1]['key']}    address
    ...    msg=❌ Expected custom[1].key to be 'address'. Found: ${custom[1]['key']}
    Should Be Empty    ${custom[1]['value']}
    ...    msg=❌ 'address' should be empty. Found: ${custom[1]['value']}

 #   Should Be Equal As Strings    ${custom[2]['key']}    coordinates
  #  ...    msg=❌ Expected custom[2].key to be 'coordinates'. Found: ${custom[2]['key']}
   # Should Be True    ${custom[2]['private']}
  #  ...    msg=❌ 'coordinates' should be private=True. Found: ${custom[2]['private']}
   # Should Be Empty   ${custom[2]['value']}
   # ...    msg=❌ 'coordinates' should be empty. Found: ${custom[2]['value']}

    Should Be Equal As Strings    ${custom[3]['key']}    Color
    ...    msg=❌ Expected custom[3].key to be 'Color'. Found: ${custom[3]['key']}
    Should Be Equal As Strings    ${custom[3]['value']}    Rosado
    ...    msg=❌ 'Color' should be 'Rosado'. Found: ${custom[3]['value']}

    Should Be Equal As Strings    ${custom[4]['key']}    Animal
    Should Be Empty    ${custom[4]['value']}
    ...    msg=❌ 'Animal' should be empty. Found: ${custom[4]['value']}

    Should Be Equal As Strings    ${custom[5]['key']}    Empresa
    Should Be Empty    ${custom[5]['value']}
    ...    msg=❌ 'Empresa' should be empty. Found: ${custom[5]['value']}

    Should Be Equal As Strings    ${custom[6]['key']}    Teléfono
    Should Be Empty    ${custom[6]['value']}
    ...    msg=❌ 'Teléfono' should be empty. Found: ${custom[6]['value']}

    Should Be Equal As Strings    ${custom[7]['key']}    Correo
    ...    msg=❌ Expected custom[7].key to be 'Correo'. Found: ${custom[7]['key']}

    ## Verificar que el usuario que fue eliminado de la comunidad no puedda ver transporte privado de la comunidad de la que fue eliminada

###Jooin user from community
### Solo correo y correo y parámetros
Delete user with params from community
    [Documentation]     Se une a una comunidad con rut, se valida que solo tenga el servicio Limitada Nico activo
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    Delete On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/${joinedUserId}?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}

    ${json}=    Set Variable    ${response.json()}
    # Validar que el nombre del usuario sea correcto
    Should Be Equal As Strings    ${json}[name]    Nico Comunidad
    ...    msg=❌ El nombre del usuario no coincide

    # Validar país
    Should Be Equal As Strings    ${json}[country]    cl
    ...    msg=❌ El país del usuario no es 'cl'

    # Validar que esté activo
    Should Be Equal As Strings    ${json}[active]    True
    ...    msg=❌ El usuario debería estar activo

    # Validar que no esté unido a ninguna comunidad
    Length Should Be    ${json}[communities]    0
    ...    msg=❌ El usuario no debería tener comunidades asociadas aún

    # Validar que tenga email cargado correctamente
    ${email}=    Get From List    ${json}[emails]    0
    Should Be Equal As Strings    ${email}[email]    nicolas+comunidad@allrideapp.com
    ...    msg=❌ El email del usuario no es el esperado

    # Validar token y config de privateBus visibles
    ${config}=    Get From Dictionary    ${json}    config
    ${privateBus}=    Get From Dictionary    ${config}    privateBus

    Should Be Equal As Strings    ${privateBus}[showSection]    True
    ...    msg=❌ privateBus.showSection debería ser True

    Should Be Equal As Strings    ${privateBus}[canBeValidated]    True
    ...    msg=❌ privateBus.canBeValidated debería ser True

    Should Be Equal As Strings    ${privateBus}[canBook]    True
    ...    msg=❌ privateBus.canBook debería ser True
  




######Agregar caso ddonde al intentar unirse a la

Join Community Only email
    [Documentation]     Joins a community using RUT and "Color" parameter, validates that both services are active
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json; charset=utf-8

    ${response}=    Post On Session
    ...    mysesion
    ...    url=${stage_url}/api/v1/communities/customJoin/688c2f3da4c7c7ffe5c44aeb
    ...    data={"email": "nicolas+comunidad@allrideapp.com"}
    ...    headers=${headers}

    ${json}=         Convert To Dictionary    ${response.json()}
    ${joinedUserId}=    Set Variable    ${json}[_id]
    Set Global Variable    ${joinedUserId}
    ${community}=    Get From List    ${json}[communities]    0

Delete user with only email from community
    [Documentation]     Se une a una comunidad con rut, se valida que solo tenga el servicio Limitada Nico activo
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    Delete On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/${joinedUserId}?community=688c2f3da4c7c7ffe5c44aeb
    ...    headers=${headers}

    ${json}=    Set Variable    ${response.json()}
    # Validar que el nombre del usuario sea correcto
    Should Be Equal As Strings    ${json}[name]    Nico Comunidad
    ...    msg=❌ El nombre del usuario no coincide

    # Validar país
    Should Be Equal As Strings    ${json}[country]    cl
    ...    msg=❌ El país del usuario no es 'cl'

    # Validar que esté activo
    Should Be Equal As Strings    ${json}[active]    True
    ...    msg=❌ El usuario debería estar activo

    # Validar que no esté unido a ninguna comunidad
    Length Should Be    ${json}[communities]    0
    ...    msg=❌ El usuario no debería tener comunidades asociadas aún

    # Validar que tenga email cargado correctamente
    ${email}=    Get From List    ${json}[emails]    0
    Should Be Equal As Strings    ${email}[email]    nicolas+comunidad@allrideapp.com
    ...    msg=❌ El email del usuario no es el esperado

    # Validar token y config de privateBus visibles
    ${config}=    Get From Dictionary    ${json}    config
    ${privateBus}=    Get From Dictionary    ${config}    privateBus

    Should Be Equal As Strings    ${privateBus}[showSection]    True
    ...    msg=❌ privateBus.showSection debería ser True

    Should Be Equal As Strings    ${privateBus}[canBeValidated]    True
    ...    msg=❌ privateBus.canBeValidated debería ser True

    Should Be Equal As Strings    ${privateBus}[canBook]    True
    ...    msg=❌ privateBus.canBook debería ser True
  


    ## Verificar que el usuario que fue eliminado de la comunidad no puedda ver transporte privado de la comunidad de la que fue eliminada

###Jooin user from community

Try to Join Community With Wrong Params(Should fail)

    [Documentation]     Se une a una comunidad con rut y parámetro "Color", se valida que tenga ambos servicios activos
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json; charset=utf-8
    
    ${response}=  Run Keyword And Expect Error  HTTPError: 400 Client Error: Bad Request for url: https://stage.allrideapp.com/api/v1/communities/customJoin/6654ae4eba54fe502d4e4187     Post On Session
    ...    mysesion
    ...    url=/api/v1/communities/customJoin/6654ae4eba54fe502d4e4187
    ...    data={"rut": "98863257112321123213", "Color": "Rosado"}
    ...    headers=${headers}

######Agregar caso ddonde al intentar unirse a la
Try to Join Community With No Mandatory(Should fail)

    [Documentation]     Se une a una comunidad con rut y parámetro "Color", se valida que tenga ambos servicios activos
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json; charset=utf-8
    
    ${response}=  Run Keyword And Expect Error  HTTPError: 400 Client Error: Bad Request for url: https://stage.allrideapp.com/api/v1/communities/customJoin/6654ae4eba54fe502d4e4187     Post On Session
    ...    mysesion
    ...    url=/api/v1/communities/customJoin/6654ae4eba54fe502d4e4187
    ...    data={"Color": "Rosado"}
    ...    headers=${headers}



Add Params to commmunity
   [Documentation]     Joins a community using RUT and "Color" parameter, validates that both services are active
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8

    ${response}=    Put On Session
    ...    mysesion
    ...    url=/api/v1/admin/community/688c2f3da4c7c7ffe5c44aeb
    ...    data={"_id":"688c2f3da4c7c7ffe5c44aeb","config":{"general":{"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"userPhoneNumber":{"enabled":false},"validationParams":{"enabled":true,"params":[{"show":true,"mandatory":false,"private":false,"name":"rut","description":"","dataType":"rut","check":false,"isUserStop":false,"internal":false,"validationExpr":"","options":[],"triggeredFns":[]}],"allowMultipleUseValidationCodes":false,"allowsJoinRequests":{"enabled":false}},"externalInfo":{"customMap":{}},"balance":{"enabled":true},"ui":{"design":{"isoType":"","logoType":"","color":""}},"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"products":{"enabled":false,"treatManualAssignmentsAsTransactions":false,"feePercentage":0,"stripe":{"connectedAccountId":null,"useProductConnectedAccountId":false}},"tutorials":{"userApp":{"products":{"enabled":false}}},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":true,"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"allowsCustomJoinWithoutEmailCheck":false,"hasUserMessagingSystem":false,"public":true,"assocCommunities":null,"allowsValidationOptions":false,"isStudentsCommunity":false,"use24hFormat":false},"privateBus":{"ui":{"admin":{"fulfillmentReport":{"hiddenRoutes":[]},"dashboard":{"markersLabel":"default"},"_id":"688c2f78a4c7c7ffe5c44b2f"}},"admin":{"icTable":{"startServiceButton":false}},"oDDSettings":{"joinNewAdminODDs":false,"enableToNewUsers":{"enabled":false,"specificParams":{"enabled":false,"params":[]}},"latestUserStopsSearch":false,"useCorrelativeIdAsName":{"enabled":false,"useType":"prefix","editable":true},"restrictedZones":{"enabled":false,"zones":[]},"showOtherReason":true,"allowsTemporaryStops":false},"scheduling":{"enabled":false,"allowSeatReservations":false,"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":false,"limitTime":null,"limitUnit":"minutes"},"reservation":{"restrictions":{"enabled":false,"amount":0,"time":1,"unit":"days","userSkip":[]}},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"admin":{"skipAllReservationsAssignedCheck":false},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4,"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"serviceCreationLimit":{"enabled":false,"date":null}},"budgetSystem":{"enabled":false},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"notifyAdmins":{"notifyIdleTime":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"amount":5,"unit":"minutes"}},"restrictiveLabels":{"enabled":false,"labels":[]},"validation":{"accessToken":{"enabled":true,"allowsSkip":false},"timestamp":{"userSkip":[],"enabled":false,"allowsSkip":false},"dailyLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null},"timeLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null,"time":null,"unit":""},"departureLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null},"DNIValidation":{"enabled":false,"field":"","allowsExternal":false},"bCValidation":{"enabled":false,"field":""},"customQRValidation":{"enabled":false,"field":""},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":false,"dataType":"text","options":[],"name":"","description":""},"customValidationParams":{"driverParams":[],"passengerParams":[],"maxValidationTime":{"amount":1,"unit":"hours"}},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"enabled":false,"allowsStatic":false,"usesTickets":false,"usesPasses":false,"ticketPrice":null,"internalNFCField":"","external":[]},"assistant":{"entryTimes":[],"departureTimes":[],"enabled":false,"collecting":false,"description":""},"poll":{"active":false,"answeredBy":[]},"rateRoute":{"enabled":false,"withValidation":false},"snapshots":{"service":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}}},"harassmentAssistanceSettings":{"enabled":false,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"reports":{"boardingReport":false,"visibleCode":"plate"},"driverApp":{"visibleCode":"plate","allowsWhatsAppMessages":false,"dataRefreshPeriod":null,"localValidationTime":null,"showOnlyScheduledServices":false,"version":"","showBoxOnValidatePassenger":{"qr":true,"dni":true,"barCode":true},"ui":{"showCapacity":true,"showFullBtn":true,"showValidateBtn":true,"showBoardingsBtn":true,"showUnboardingsBtn":true,"showTicketCounter":true,"showRoundsCounter":true,"showBarrierBtn":true,"showGoogleMapsBtn":true}},"passengerApp":{"visibleCode":"plate","allowsWhatsAppMessages":false},"driverCustomParams":{"enabled":false,"params":[]},"fleetCustomParams":{"enabled":false,"params":[]},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":false},"emergencyCall":{"enabled":true},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"restrictRTL":{"enabled":false},"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"userApp":{"allowsMultipleReservations":{"enabled":false,"amountLimit":0},"exploreMode":"standard"},"speedAlert":{"enabled":false,"limit":27.78,"notify":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"inactiveGPSAlert":{"notify":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false,"notify":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"fineManagementSystem":{"enabled":false,"types":[],"possibleOrigins":[],"stateNotifications":[]},"ETA":{"enabled":false,"update":{"amount":0,"unit":"minutes"},"visibility":["admin"],"notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"chatSystem":{"defaultMessages":{"user":[],"driver":[]}},"enabled":true,"visible":true,"apportionCategories":[],"labels":[],"allowsRating":false,"allowsSnapshots":false,"allowsScreenshots":false,"usesPin":false,"noPassengerInfo":false,"allowGenericVehicles":false,"continuousGpsAlwaysOn":false,"locationCacheDuration":360,"driverCanCreateRoutes":false,"oDDServices":[],"auxiliaryTrackers":[],"showStandbyDrivers":true,"trackersVisibility":[],"standbyTrackersVisibility":[],"odd":{"pricing":{"timeDistanceConfig":{"tolls":{"manual":[]},"additionalCharges":[]},"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyPassengersWithoutReservation":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyAdmins":{"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"driverReject":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"serviceCanceled":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"rejectedByProvider":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false}},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":false},"validateDeparture":{"enabled":false},"userRequests":{"enableToNewUsers":{"specificParams":{"enabled":false,"params":[]},"enabled":false},"reasons":{"list":[]},"adminApprovalByDefault":true,"schedules":[]},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false}},"restrictRequests":{"forService":{"settings":{"userCustomParams":{"params":[]},"geographical":{"zones":[]},"providers":[]}},"forProviders":{"settings":[]}},"endServiceLegAutomatically":{"estimatedDuration":{"byPercentage":{"timer":{"amount":5,"unit":"minutes"}},"byTime":{"timer":{"amount":5,"unit":"minutes"},"unit":"minutes"}},"timer":{"amount":5,"unit":"minutes"},"distance":100},"mandatoryUserParams":{"enabled":false,"params":[]},"enabled":false,"reasons":[],"hideEstimatedTimes":false,"allowsMultipleDrivers":false,"allowsDistance":false,"_id":"688c2f78a4c7c7ffe5c44b30","entryTimes":[],"exitTimes":[],"legOptions":[],"notifications":[],"approvers":[]},"createServices":{"enabled":true},"harassmentAssistance":false},"parking":{"enabled":false,"visible":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false,"requiredBoardingConditions":{"startWithRTL":false,"pickupLocationTolerance":false,"boardingTimeWindow":false,"driverPassengerProximity":false,"boardingQueryDelay":false}},"carpool":{"boardingConditions":{"enabled":false,"startWithRTL":false,"pickupLocationTolerance":{"enabled":false,"value":200},"boardingTimeWindow":{"enabled":false,"value":30},"driverPassengerProximity":{"enabled":false,"value":100},"boardingQueryDelay":{"enabled":false,"value":1}},"emergencyCall":{"enabled":true},"enabled":false,"visible":true,"communityOptions":false,"routePublishingOptions":[],"routeSearchRestrictions":[],"divisionKey":null,"categories":{"perPassenger":false,"config":{"subsidy":{"enabled":true,"amount":0,"informationText":"","companyText":""},"priority":90,"_id":"688c2f3da4c7c7ffe5c44af0","name":"no_charge","enabled":true,"currency":"clp","description":"","params":[{"_id":"688c2f3da4c7c7ffe5c44af1","name":"communities","value":"688c2f3da4c7c7ffe5c44aeb","createdAt":"2025-08-01T03:06:37.153Z","updatedAt":"2025-08-01T03:06:37.153Z"}],"createdAt":"2025-08-01T03:06:37.155Z","updatedAt":"2025-10-23T15:31:20.957Z","__v":0}}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"enabled":true,"visible":true,"hasSOS":true},"schoolBus":{"enabled":false,"visible":true},"publicBus":{"enabled":true,"visible":true}},"custom":{"hasSubsidy":{"active":false,"subsidizedUsers":[]},"realTimeTransportSystem":{"buses":{"oDDSettings":{"enableToNewUsers":{"specificParams":{"enabled":false,"params":[]},"enabled":false},"joinNewAdminODDs":false},"scheduling":{"admin":{"skipAllReservationsAssignedCheck":false},"dynamicResourceAssignment":{"enabled":false,"limitTime":15,"limitUnit":"minutes"},"reservation":{"restrictions":{"customParams":{"enabled":false,"dataType":"text","options":[]},"unit":"days","userSkip":[]},"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"exceedValidationLimit":{"enabled":false},"notifyAdmins":{"fullService":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"driverReject":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false}},"autoAssignReservations":{"enabled":false},"apportioning":{"enabled":false,"type":"estimated"},"enabled":false,"serviceCreationAnticipation":4,"allowSeatReservations":false},"budgetSystem":{"enabled":false},"notifyPassBudgetPercentage":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"percentages":{"general":{"enabled":false,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}},"enabled":false},"restrictiveLabels":{"enabled":false,"labels":[]},"validation":{"accessToken":{"userSkip":[]},"timestamp":{"userSkip":[]},"dailyLimit":{"userSkip":[]},"timeLimit":{"userSkip":[]},"departureLimit":{"userSkip":[]},"DNIValidation":{"enabled":false,"failureMessage":"Solo puedes presentar el código de AllRideo o de tu cédula de identidad.","showRejected":true,"options":["qr"]},"bCValidation":{"enabled":false},"customQRValidation":{"enabled":false},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":false,"dataType":"text","options":[]},"customValidationParams":{"passengerParams":[],"driverParams":[]},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"external":[]},"assistant":{"entryTimes":[],"departureTimes":[]},"poll":{"active":false,"answeredBy":[]},"wfIntegration":{"enabled":false},"tracker":{"enabled":false},"rateRoute":{"enabled":false,"withValidation":false},"snapshots":{"service":{"enabled":false},"nonService":{"enabled":false}},"harassmentAssistanceSettings":{"enabled":false,"showTextAbove":true,"showInformation":true},"emergencyCall":{"enabled":true},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"custom":{"reports":{"visibleCode":"plate"},"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"}},"driverCustomParams":{"enabled":false,"params":[]},"fleetCustomParams":{"enabled":false,"params":[]},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"routeDeviation":{"notify":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"maxDistance":100,"maxTime":5,"enabled":false},"fineManagementSystem":{"enabled":false,"types":[],"possibleOrigins":[],"stateNotifications":[]},"apportionCategories":[],"labels":[],"allowsRating":false,"allowsSnapshots":false,"allowsScreenshots":true,"usesPin":false,"harassmentAssistance":false,"noPassengerInfo":false,"allowGenericVehicles":false,"continuousGpsAlwaysOn":false,"oDDServices":[],"auxiliaryTrackers":[]},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCall":{"enabled":true},"enabled":true,"communityOptions":true,"routePublishingOptions":[],"routeSearchRestrictions":[]},"cabpool":{"hasSOS":true},"schoolbus":{"enabled":true}},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[],"allowsJoinRequests":{"enabled":false}},"parkingLots":{"specificLots":{"enabled":false,"lotIds":[]},"exitReminderTime":{"time":5,"unit":"minutes"},"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hour"},"notifyInactiveUsers":{"enabled":false,"days":7},"fullName":{"enabled":false},"enabled":false,"enableToAllUsers":false,"busIntegration":false,"reservationByDay":false,"reservationModel":"priority","accessModel":"reservation","maxAvailableDays":5,"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"sections":false,"allowsScreenshots":true,"lotIdsAndKeysParams":[],"ranges":[]},"balance":{"enabled":true},"products":{"enabled":false},"betaFeatures":[],"allowsManualUsers":false,"replacesManualUser":true,"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"hasUserMessagingSystem":false},"emailSuffixes":["allrideapp.com"],"admins":[],"timezone":"Chile/Continental","type":"normal","distance":0,"allowAds":false,"assocCommunities":[],"public":true,"name":"Pruebas Nico (customJoin)","site":"http://adminstage.allrideapp.com","terms":null,"country":"cl","hasBusesSystem":true,"language":"es","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_688c2f3da4c7c7ffe5c44aeb_1754017655840.png","badge":"https://s3.amazonaws.com/allride.uploads/communityAvatar_688c2f3da4c7c7ffe5c44aeb_1754017656299.png","createdAt":"2025-08-01T03:06:37.105Z","updatedAt":"2025-10-21T13:05:19.335Z","__v":497}
    ...    headers=${headers}


Join Community Email and Params
    [Documentation]     Joins a community using RUT and "Color" parameter, validates that both services are active
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json; charset=utf-8

    ${response}=    Post On Session
    ...    mysesion
    ...    url=${stage_url}/api/v1/communities/customJoin/688c2f3da4c7c7ffe5c44aeb
    ...    data={"email": "nicolas+comunidad@allrideapp.com", "rut": "191866819"}
    ...    headers=${headers}

    ${json}=         Convert To Dictionary    ${response.json()}
    ${joinedUserId}=    Set Variable    ${json}[_id]
    Set Global Variable    ${joinedUserId}
    ${community}=    Get From List    ${json}[communities]    0


Delete user with only email and params
    [Documentation]     Se une a una comunidad con rut, se valida que solo tenga el servicio Limitada Nico activo
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    Delete On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/${joinedUserId}?community=688c2f3da4c7c7ffe5c44aeb
    ...    headers=${headers}

    ${json}=    Set Variable    ${response.json()}
    # Validar que el nombre del usuario sea correcto
    Should Be Equal As Strings    ${json}[name]    Nico Comunidad
    ...    msg=❌ El nombre del usuario no coincide

    # Validar país
    Should Be Equal As Strings    ${json}[country]    cl
    ...    msg=❌ El país del usuario no es 'cl'

    # Validar que esté activo
    Should Be Equal As Strings    ${json}[active]    True
    ...    msg=❌ El usuario debería estar activo

    # Validar que no esté unido a ninguna comunidad
    Length Should Be    ${json}[communities]    0
    ...    msg=❌ El usuario no debería tener comunidades asociadas aún

    # Validar que tenga email cargado correctamente
    ${email}=    Get From List    ${json}[emails]    0
    Should Be Equal As Strings    ${email}[email]    nicolas+comunidad@allrideapp.com
    ...    msg=❌ El email del usuario no es el esperado

    # Validar token y config de privateBus visibles
    ${config}=    Get From Dictionary    ${json}    config
    ${privateBus}=    Get From Dictionary    ${config}    privateBus

    Should Be Equal As Strings    ${privateBus}[showSection]    True
    ...    msg=❌ privateBus.showSection debería ser True

    Should Be Equal As Strings    ${privateBus}[canBeValidated]    True
    ...    msg=❌ privateBus.canBeValidated debería ser True

    Should Be Equal As Strings    ${privateBus}[canBook]    True
    ...    msg=❌ privateBus.canBook debería ser True
  

add allowsCustomJoinWithoutEmailCheck to comminuty (Only email)
    skip
   [Documentation]     Joins a community using RUT and "Color" parameter, validates that both services are active
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8

    ${response}=    Put On Session
    ...    mysesion
    ...    url=/api/v1/admin/community/688c2f3da4c7c7ffe5c44aeb
    ...    data={"_id":"688c2f3da4c7c7ffe5c44aeb","config":{"general":{"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"userPhoneNumber":{"enabled":false},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"enabled":false,"params":[{"mandatory":false,"check":false,"show":true,"private":false,"internal":false,"options":[],"triggeredFns":[],"_id":"688cff05a09dd2b5b3bf1904","name":"rut","description":"","dataType":"rut","isUserStop":false,"validationExpr":""}]},"externalInfo":{"siga":{"enabled":false}},"balance":{"enabled":true},"ui":{"design":{"isoType":"","logoType":"","color":""}},"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"products":{"enabled":false,"feePercentage":0,"stripe":{"connectedAccountId":null,"useProductConnectedAccountId":false}},"tutorials":{"userApp":{"products":{"enabled":false}}},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":true,"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"allowsCustomJoinWithoutEmailCheck":true,"hasUserMessagingSystem":false,"public":true,"assocCommunities":null,"allowsValidationOptions":false,"isStudentsCommunity":false,"use24hFormat":false},"privateBus":{"ui":{"admin":{"fulfillmentReport":{"hiddenRoutes":[]},"dashboard":{"markersLabel":"default"},"_id":"688c2f78a4c7c7ffe5c44b2f"}},"admin":{"icTable":{"startServiceButton":false}},"oDDSettings":{"joinNewAdminODDs":false,"enableToNewUsers":{"enabled":false,"specificParams":{"enabled":false,"params":[]}},"latestUserStopsSearch":false,"useCorrelativeIdAsName":{"enabled":false,"useType":"prefix","editable":true},"restrictedZones":{"enabled":false,"zones":[]},"showOtherReason":true,"allowsTemporaryStops":false},"scheduling":{"enabled":false,"allowSeatReservations":false,"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":false,"limitTime":null,"limitUnit":"minutes"},"reservation":{"restrictions":{"enabled":false,"amount":0,"time":1,"unit":"days","userSkip":[]}},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"admin":{"skipAllReservationsAssignedCheck":false},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4,"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"serviceCreationLimit":{"enabled":false,"date":null}},"budgetSystem":{"enabled":false},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"notifyAdmins":{"notifyIdleTime":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"amount":5,"unit":"minutes"}},"restrictiveLabels":{"enabled":false,"labels":[]},"validation":{"accessToken":{"enabled":true,"allowsSkip":false},"timestamp":{"userSkip":[],"enabled":false,"allowsSkip":false},"dailyLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null},"timeLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null,"time":null,"unit":""},"departureLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null},"DNIValidation":{"enabled":false,"field":"","allowsExternal":false},"bCValidation":{"enabled":false,"field":""},"customQRValidation":{"enabled":false,"field":""},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":false,"dataType":"text","options":[],"name":"","description":""},"customValidationParams":{"driverParams":[],"passengerParams":[],"maxValidationTime":{"amount":1,"unit":"hours"}},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"enabled":false,"allowsStatic":false,"usesTickets":false,"usesPasses":false,"ticketPrice":null,"internalNFCField":"","external":[]},"assistant":{"entryTimes":[],"departureTimes":[],"enabled":false,"collecting":false,"description":""},"poll":{"active":false,"answeredBy":[]},"rateRoute":{"enabled":false,"withValidation":false},"snapshots":{"service":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}}},"harassmentAssistanceSettings":{"enabled":false,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"reports":{"boardingReport":false,"visibleCode":"plate"},"driverApp":{"visibleCode":"plate","dataRefreshPeriod":null,"localValidationTime":null,"localStartDepartureTime":5,"localEndDepartureTime":5,"allowsWhatsAppMessages":false},"passengerApp":{"visibleCode":"plate","allowsWhatsAppMessages":false},"driverCustomParams":{"enabled":false,"params":[]},"fleetCustomParams":{"enabled":false,"params":[]},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":false},"emergencyCall":{"enabled":true},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"restrictRTL":{"enabled":false},"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"userApp":{"allowsMultipleReservations":{"enabled":false,"amountLimit":0},"exploreMode":"standard"},"speedAlert":{"enabled":false,"limit":27.78,"notify":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"inactiveGPSAlert":{"notify":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false,"notify":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"fineManagementSystem":{"enabled":false,"types":[],"possibleOrigins":[],"stateNotifications":[]},"ETA":{"enabled":false,"update":{"amount":0,"unit":"minutes"},"visibility":["admin"],"notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"chatSystem":{"defaultMessages":{"user":[],"driver":[]}},"enabled":true,"visible":true,"apportionCategories":[],"labels":[],"allowsRating":false,"allowsSnapshots":false,"allowsScreenshots":false,"usesPin":false,"noPassengerInfo":false,"allowGenericVehicles":false,"continuousGpsAlwaysOn":false,"locationCacheDuration":360,"driverCanCreateRoutes":false,"oDDServices":[],"auxiliaryTrackers":[],"showStandbyDrivers":true,"trackersVisibility":[],"standbyTrackersVisibility":[],"odd":{"pricing":{"timeDistanceConfig":{"tolls":{"manual":[]},"additionalCharges":[]},"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyPassengersWithoutReservation":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"notifyAdmins":{"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"driverReject":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"serviceCanceled":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"rejectedByProvider":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false}},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":false},"validateDeparture":{"enabled":false},"userRequests":{"enableToNewUsers":{"specificParams":{"enabled":false,"params":[]},"enabled":false},"reasons":{"list":[]},"adminApprovalByDefault":true,"schedules":[]},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false}},"restrictRequests":{"forService":{"settings":{"userCustomParams":{"params":[]},"geographical":{"zones":[]},"providers":[]}},"forProviders":{"settings":[]}},"endServiceLegAutomatically":{"estimatedDuration":{"byPercentage":{"timer":{"amount":5,"unit":"minutes"}},"byTime":{"timer":{"amount":5,"unit":"minutes"},"unit":"minutes"}},"timer":{"amount":5,"unit":"minutes"},"distance":100},"mandatoryUserParams":{"enabled":false,"params":[]},"enabled":false,"reasons":[],"hideEstimatedTimes":false,"allowsMultipleDrivers":false,"allowsDistance":false,"_id":"688c2f78a4c7c7ffe5c44b30","entryTimes":[],"exitTimes":[],"legOptions":[],"notifications":[],"approvers":[]},"harassmentAssistance":false},"parking":{"enabled":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCall":{"enabled":true},"enabled":false,"visible":true,"communityOptions":false,"routePublishingOptions":[],"routeSearchRestrictions":[],"divisionKey":null,"categories":{"perPassenger":false,"config":{"subsidy":{"enabled":true,"amount":0,"informationText":"","companyText":""},"priority":90,"_id":"688c2f3da4c7c7ffe5c44af0","name":"no_charge","enabled":true,"currency":"clp","description":"","params":[{"_id":"688c2f3da4c7c7ffe5c44af1","name":"communities","value":"688c2f3da4c7c7ffe5c44aeb","createdAt":"2025-08-01T03:06:37.153Z","updatedAt":"2025-08-01T03:06:37.153Z"}],"createdAt":"2025-08-01T03:06:37.155Z","updatedAt":"2025-08-01T18:47:08.898Z","__v":0}}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"enabled":true,"visible":true,"hasSOS":true},"schoolBus":{"enabled":false,"visible":true},"publicBus":{"enabled":true,"visible":true}},"custom":{"hasSubsidy":{"active":false,"subsidizedUsers":[]},"realTimeTransportSystem":{"buses":{"oDDSettings":{"enableToNewUsers":{"specificParams":{"enabled":false,"params":[]},"enabled":false},"joinNewAdminODDs":false},"scheduling":{"admin":{"skipAllReservationsAssignedCheck":false},"dynamicResourceAssignment":{"enabled":false,"limitTime":15,"limitUnit":"minutes"},"reservation":{"restrictions":{"customParams":{"enabled":false,"dataType":"text","options":[]},"unit":"days","userSkip":[]},"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"exceedValidationLimit":{"enabled":false},"notifyAdmins":{"fullService":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"driverReject":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false}},"autoAssignReservations":{"enabled":false},"apportioning":{"enabled":false,"type":"estimated"},"enabled":false,"serviceCreationAnticipation":4,"allowSeatReservations":false},"budgetSystem":{"enabled":false},"notifyPassBudgetPercentage":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"percentages":{"general":{"enabled":false,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}},"enabled":false},"restrictiveLabels":{"enabled":false,"labels":[]},"validation":{"accessToken":{"userSkip":[]},"timestamp":{"userSkip":[]},"dailyLimit":{"userSkip":[]},"timeLimit":{"userSkip":[]},"departureLimit":{"userSkip":[]},"DNIValidation":{"enabled":false,"failureMessage":"Solo puedes presentar el código de AllRideo o de tu cédula de identidad.","showRejected":true,"options":["qr"]},"bCValidation":{"enabled":false},"customQRValidation":{"enabled":false},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":false,"dataType":"text","options":[]},"customValidationParams":{"passengerParams":[],"driverParams":[]},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"external":[]},"assistant":{"entryTimes":[],"departureTimes":[]},"poll":{"active":false,"answeredBy":[]},"wfIntegration":{"enabled":false},"tracker":{"enabled":false},"rateRoute":{"enabled":false,"withValidation":false},"snapshots":{"service":{"enabled":false},"nonService":{"enabled":false}},"harassmentAssistanceSettings":{"enabled":false,"showTextAbove":true,"showInformation":true},"emergencyCall":{"enabled":true},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"custom":{"reports":{"visibleCode":"plate"},"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"}},"driverCustomParams":{"enabled":false,"params":[]},"fleetCustomParams":{"enabled":false,"params":[]},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"routeDeviation":{"notify":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"superCommunities":[]},"enabled":false},"maxDistance":100,"maxTime":5,"enabled":false},"fineManagementSystem":{"enabled":false,"types":[],"possibleOrigins":[],"stateNotifications":[]},"apportionCategories":[],"labels":[],"allowsRating":false,"allowsSnapshots":false,"allowsScreenshots":true,"usesPin":false,"harassmentAssistance":false,"noPassengerInfo":false,"allowGenericVehicles":false,"continuousGpsAlwaysOn":false,"oDDServices":[],"auxiliaryTrackers":[]},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCall":{"enabled":true},"enabled":true,"communityOptions":true,"routePublishingOptions":[],"routeSearchRestrictions":[]},"cabpool":{"hasSOS":true},"schoolbus":{"enabled":true}},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[]},"parkingLots":{"specificLots":{"enabled":false,"lotIds":[]},"exitReminderTime":{"time":5,"unit":"minutes"},"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hour"},"notifyInactiveUsers":{"enabled":false,"days":7},"fullName":{"enabled":false},"enabled":false,"enableToAllUsers":false,"busIntegration":false,"reservationByDay":false,"reservationModel":"priority","accessModel":"reservation","maxAvailableDays":5,"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"sections":false,"allowsScreenshots":true,"lotIdsAndKeysParams":[],"ranges":[]},"balance":{"enabled":true},"products":{"enabled":false},"betaFeatures":[],"allowsManualUsers":false,"replacesManualUser":true,"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"hasUserMessagingSystem":false},"emailSuffixes":["allrideapp.com"],"admins":[],"timezone":"Chile/Continental","type":"normal","distance":0,"allowAds":false,"assocCommunities":[],"public":true,"name":"Pruebas Nico (customJoin)","site":"http://adminstage.allrideapp.com","terms":null,"country":"cl","hasBusesSystem":true,"language":"es","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_688c2f3da4c7c7ffe5c44aeb_1754017655840.png","badge":"https://s3.amazonaws.com/allride.uploads/communityAvatar_688c2f3da4c7c7ffe5c44aeb_1754017656299.png","createdAt":"2025-08-01T03:06:37.105Z","updatedAt":"2025-08-01T18:47:08.936Z","__v":15}
    ...    headers=${headers}



Join Community Only email 2
    Skip
    [Documentation]     Joins a community using RUT and "Color" parameter, validates that both services are active
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json; charset=utf-8

    ${response}=    Post On Session
    ...    mysesion
    ...    url=${stage_url}/api/v1/communities/customJoin/688c2f3da4c7c7ffe5c44aeb
    ...    data={"email": "nicolas+comunidad@allrideapp.com"}
    ...    headers=${headers}

    ${json}=         Convert To Dictionary    ${response.json()}
    ${joinedUserId}=    Set Variable    ${json}[_id]
    Set Global Variable    ${joinedUserId}
    ${community}=    Get From List    ${json}[communities]    0

Delete user with only email from community 2
    Skip
    [Documentation]     Se une a una comunidad con rut, se valida que solo tenga el servicio Limitada Nico activo
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    
    ${response}=    Delete On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/${joinedUserId}?community=688c2f3da4c7c7ffe5c44aeb
    ...    headers=${headers}

    ${json}=    Set Variable    ${response.json()}
    # Validar que el nombre del usuario sea correcto
    Should Be Equal As Strings    ${json}[name]    Nico Comunidad
    ...    msg=❌ El nombre del usuario no coincide

    # Validar país
    Should Be Equal As Strings    ${json}[country]    cl
    ...    msg=❌ El país del usuario no es 'cl'

    # Validar que esté activo
    Should Be Equal As Strings    ${json}[active]    True
    ...    msg=❌ El usuario debería estar activo

    # Validar que no esté unido a ninguna comunidad
    Length Should Be    ${json}[communities]    0
    ...    msg=❌ El usuario no debería tener comunidades asociadas aún

    # Validar que tenga email cargado correctamente
    ${email}=    Get From List    ${json}[emails]    0
    Should Be Equal As Strings    ${email}[email]    nicolas+comunidad@allrideapp.com
    ...    msg=❌ El email del usuario no es el esperado

    # Validar token y config de privateBus visibles
    ${config}=    Get From Dictionary    ${json}    config
    ${privateBus}=    Get From Dictionary    ${config}    privateBus

    Should Be Equal As Strings    ${privateBus}[showSection]    True
    ...    msg=❌ privateBus.showSection debería ser True

    Should Be Equal As Strings    ${privateBus}[canBeValidated]    True
    ...    msg=❌ privateBus.canBeValidated debería ser True

    Should Be Equal As Strings    ${privateBus}[canBook]    True
    ...    msg=❌ privateBus.canBook debería ser True
  


