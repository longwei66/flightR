## =============================================================================
##
##		flightR is a package to interract with aviation-edge.com API
##
##
##		Requirements :
##		a valid account on : https://aviation-edge.com/developers/
##
##
##		Aviation Edge – Database and API
##		--------------------------
##          Developers hub for all aviation data from live tracking flights 
##          to actual airport schedules, airline routes and much more
##
##
##		Few concepts to undersdand
##		--------------------------
##      [ Flight schedules and Timetables]
##      For the departure timetable of a certain airport. 
##      GET http://aviation-edge.com/v2/public/timetable?key=[API_KEY]&iataCode=JFK&type=departure
##      For the arrival timetable of a certain airport. 
##      GET http://aviation-edge.com/v2/public/timetable?key=[API_KEY]&iataCode=JFK&type=arrival
##      Status can be: (landed, scheduled, cancelled, active, incident, diverted, redirected, unknown)
##
## =============================================================================



## =============================================================================
## 	[0] Load necessary libraries
## =============================================================================
library(jsonlite)
library(httr)
library(readr)

## --
source("./conf/aviation-edge.R")

## -- Set-up a new environment (used for token authentification)
#myEnv <- new.env()


## =============================================================================
## 	[1] Functions
##
##	DSSgetAuthenticationToken ....... Manage authentication
##
## =============================================================================

getFlightSchedulesTimetables <- function(iata.code="JFK",
                                         type="departure", #"arrival"
                                         api.key){
    ## Define aviation-edge API URL
    url.base <- "http://aviation-edge.com/v2/public/timetable?"
    url.param <- paste0("key=",api.key,"&iataCode=",iata.code,"&type=",type)
    url <- paste0(url.base, url.param)
    message(url)
    
    ## GET request
    request <- GET(url
                   #, add_headers(prefer = "respond-async", Authorization = token)
    )
    stop_for_status(request)
    if(status_code(request) == 200){
        answer <- content(request, "parsed", "application/json", encoding="UTF-8")
    } else {
        answer <- NULL
    }
    return(answer)
}



##
makeFlightOverview <- function(flight){
    
    quickCheck <- function(x){
        if(is.null(x)){ 
            return(NA)
        } else { 
            return(x) }
    }
    
    return(
        list(
            "airliner" = flight$airline$name,
            "airliner" = flight$airline$iataCode,
            "flight.iata.number" = flight$flight$iataNumber,
            "from.iata.code" = flight$departure$iataCode,
            "from.scheduled.time" = quickCheck(flight$departure$scheduledTime),
            "from.estimated.time" = quickCheck(flight$departure$estimatedTime),
            "from.actual.time" = quickCheck(flight$departure$actualTime),
            "to.iata.code" = flight$arrival$iataCode,
            "to.scheduled.time" = quickCheck(flight$arrival$scheduledTime),
            "to.estimated.time" = quickCheck(flight$arrival$estimatedTime),
            "to.actual.time" = quickCheck(flight$arrival$actualTime),
            "departure.delay" = quickCheck(flight$departure$delay),
            "type" = flight$type,
            "status" = flight$status,
            "arrival.delay" = quickCheck(flight$arrival$delay)
        )
    )
}

## -- example
flights.to.lis <- getFlightSchedulesTimetables(iata.code = "LIS", type = "arrival", api.key = aviation.edge.api.key)
report.to.lis <- data.table::rbindlist(lapply(flights.to.lis, makeFlightOverview))

flights.from.lis <- getFlightSchedulesTimetables(iata.code = "LIS", type = "departure", api.key = aviation.edge.api.key)
report.from.lis <- data.table::rbindlist(lapply(flights.from.lis, makeFlightOverview))

flights.to.belo <- getFlightSchedulesTimetables(iata.code = "CNF", type = "arrival", api.key = aviation.edge.api.key)
report.to.belo <- data.table::rbindlist(lapply(flights.to.belo, makeFlightOverview))

flights.from.belo <- getFlightSchedulesTimetables(iata.code = "CNF", type = "departure", api.key = aviation.edge.api.key)
report.from.belo <- data.table::rbindlist(lapply(flights.from.belo, makeFlightOverview))


## =============================================================================
##
##
##
##		Few concepts to undersdand
##		--------------------------
##		[ Instruments ]
##		These are commodities, index, stocks, currencies, etc... mainly defined
##		by their RIC (Reuters Identification Code).
##		For instance, Vallourec SA on the Paris stock market is identified
##		by it's RIC : VLLP.PA
##
##		[ Report Templates]
##		Depending on your contract you will have access to several types of 
##		Report Templates, they contain all parameters and fields exported for 
##		each instruments. 
##		For instance, we use 'Intraday Pricing' to Retrieve intraday pricing
##		from Thomson Reuters real‐time network, ... and we created in DSS web
##		a report template named "basic" containing only the following fields
## 			"Instrument ID Type", "Instrument ID", "RIC", "ISIN"                
##			"Ticker", "Exchange Code", "Exchange Description"
##			"Security Description", "Currency Code", 
##			"Open Price", "Official Close Price", "Official Close Date" 
##
##
##		[ Instrument Lists ]
##		These are defined in the Datascope Select web interface, they consist
##		in named lists containing all the instruments you may be interested in
##		For instance, you could create a list named "test" containing two
##		instruments, VLLP.PA and IBM.N which are respectively IBM & Vallourec
##		stocks respectively in New York and Paris, the best is to use RIC 
##		(Reuters Identification Code) as Identifier Type
##	
##		[ Getting the data ]
##		To get IntraDay data using DSS API, you need, after authentication :
##		- get IntraDay data using pre-defined instruments lists ID in DSS Web
##		  as well as list of fields
##		- get IntraDay data using as argumgent a list of instruments RIC
##		  as well as list of fields
##		List of fields can be extrated from a ReportTemplate by its name
##
##
##		Example :
##		myToken <- DSSgetAuthenticationToken(user.login = "xxxx",
##											 user.password = "zzz")
##
##		myListId <- DSSgetInstrumentListIdentifier(instrument.list.name = "test",
##												   token = myToken)$ListId
##
##		vk.basic.report <- DSSgetReportTemplateByName(
##									report.template.name = "vk-basic-report",
##									token = myToken)
##		vk.fields.basic <- DSSreportTemplateToFieldNames(
##									report.template = vk.basic.report)
##
##		data <- DSSgetIntradayDataFromListId(
##									listID = myListId,
##									field.name = vk.fields.basic,
##									token = myToken)
##
##
##
##      [Other documentation for python]
##      https://community.developers.thomsonreuters.com/questions/26823/how-to-get-fx-rates-from-datascope-select-rest-api.html
##
## =============================================================================

## =============================================================================
## 	[0] Load necessary libraries
## =============================================================================
library(jsonlite)
library(httr)
library(readr)


## -- Set-up a new environment (used for token authentification)
#myEnv <- new.env()


## =============================================================================
## 	[1] Functions
##
##	DSSgetAuthenticationToken ....... Manage authentication
##	DSSgetUserInfo .................. Check details of authenticated user
##	DSSgetInstrumentListIdentifier .. Return the identifer or an InstrumentList
##	DSSgetReportTemplateByName ...... Get Report Template (and fields)
##	DSSreportTemplateToFieldNames ... Extract FieldNames from a report template
##	DSSgetIntradayDataFromListId .... Get IntraDay Data from list and report
##
## =============================================================================

#' DSSgetAuthenticationToken
#' 
#' This function will return an authentication token for a registered user using
#' his login and password. Authentication token are valid 24 hours
#' Web access to datascope is : https://hosted.datascope.reuters.com
#' 
#' @param user.login datascope user login
#' @param user.password datascope user password
#' 
#' @import httr
#' @import jsonlite
#' 
#' @return An authentication token that must be applied to all requests
DSSgetAuthenticationToken <- function(user.login, user.password) {
    
    ## Define Reuters Datascope API Authentication URL
    url <- "https://hosted.datascopeapi.reuters.com/RestApi/v1/Authentication/RequestToken"
    
    ## Prepare the HTTP Request Body
    body <- list(
        Credentials = list(
            Username = jsonlite::unbox(user.login),
            Password = jsonlite::unbox(user.password)
        )
    )
    ## build the POST request in json including Body request above
    request <- httr::POST(
        url,
        add_headers(prefer = "respond-async"),
        content_type_json(),
        body = body,
        encode = "json"
    )
    stop_for_status(request)
    ## Get the result content
    a <- httr::content(request, "parsed", "application/json", encoding="UTF-8")
    
    ## Post Processing
    token <- paste('Token',a[[2]],sep=" ")
    
    return(token)
}


#' DSSgetUserInfo
#' 
#' This function gets the information associated to the logged user associated
#' to authentication token used
#' 
#' @import httr
#' 
#' @param user.login datascope login name
#' @return Return User description list containing UserId, UserName, Email and Phone
DSSgetUserInfo <- function(user.login, token) {
    ## Define Reuters Datascope API URL
    url <- paste0("https://hosted.datascopeapi.reuters.com/RestApi/v1/Users/Users(",user.login,")")
    
    ## GET request
    request <- GET(url, add_headers(prefer = "respond-async", Authorization = token))
    stop_for_status(request)
    a <- content(request, "parsed", "application/json", encoding="UTF-8")
    return(a)
}



#' DSSgetInstrumentListIdentifier
#' 
#' Finding the identifier of a pre-existing instrument list, 
#' stored on the DSS server
#' 
#' @import httr
#' @param uname instrument.list.name
#' @return a identifier of the instrument list
DSSgetInstrumentListIdentifier <- function(instrument.list.name, token) {
    ## Define Reuters Datascope API URL
    url <- paste0("https://hosted.datascopeapi.reuters.com/RestApi/v1/Extractions/InstrumentListGetByName(ListName='",instrument.list.name,"')")
    
    ## GET request
    request <- GET(url,add_headers(prefer = "respond-async",Authorization = token))
    stop_for_status(request)
    a<-content(request, "parsed", "application/json", encoding="UTF-8")
    return(a)
}



#' DSSgetReportTemplateByName
#' 
#' Finding the identifier of a pre-existing instrument list, stored on the DSS server
#' 
#' @import httr
#' 
#' @param uname report.template.name
#' @return Return list of ID, Name, Phone, and Email
DSSgetReportTemplateByName <- function(report.template.name, token) {
    ## Define Reuters Datascope API URL
    url <- paste0("https://hosted.datascopeapi.reuters.com/RestApi/v1/Extractions/ReportTemplateGetByName(Name='",report.template.name,"')")
    
    ## GET request
    request <- GET(url,add_headers(prefer = "respond-async",Authorization = token))
    stop_for_status(request)
    a<-content(request, "parsed", "application/json", encoding="UTF-8")
    return(a)
}



#' DSSreportTemplateToFieldNames
#' 
#' Return Field list from a DSS reportTemplate (as list)
#' 
#' 
#' @param uname report.template as returned by DSSgetReportTemplateByName
#' @return Return verctor of FieldNames
DSSreportTemplateToFieldNames <- function(report.template){
    field.names <- sapply(report.template$ContentFields, function(x) x$FieldName)
    return(field.names)
}



#' DSSgetIntradayDataFromListId
#' 
#' Get intraday data - HTTP request, using defined FieldNames, if these are
#' missing, use a standard set of FieldNames
#' 
#' @import httr
#' 
#' @param listID the ID of the instrument list in datascope server
#' @param field.names a vector of FieldNames to include in the answer
#' @param token and authentication token
#' 
#' @return Return
DSSgetIntradayDataFromListId <- function(listID, field.names = NULL, token) {
    
    ## Performs an on demand extraction.
    ## If the results are ready before the request times out, 
    ## it will return the result. If not, it will return a 202 response
    ## for the client to try to get the results from the ExtractResults method.
    url <- paste0("https://hosted.datascopeapi.reuters.com/RestApi/v1/Extractions/ExtractWithNotes")
    
    ## -- if the field.names is NULL, use a standard set of FieldName
    ## -- if not, use the field.names parameter provided
    if(is.null(field.names)){
        field.names.list <- list(
            jsonlite::unbox("RIC"),
            jsonlite::unbox("Ask Price"),
            jsonlite::unbox("Asset Type"),
            jsonlite::unbox("Bid Price"),
            jsonlite::unbox("Currency Code"),
            jsonlite::unbox("Exchange Code"),
            jsonlite::unbox("High Price"),
            jsonlite::unbox("Instrument ID"),
            jsonlite::unbox("Instrument ID Type"),
            jsonlite::unbox("Low Price"),
            jsonlite::unbox("Open Price"),
            jsonlite::unbox("Previous Close Date"),
            jsonlite::unbox("Previous Close Price"),
            jsonlite::unbox("Security Description"),
            jsonlite::unbox("Settlement Price"),
            jsonlite::unbox("Trade Date"),
            jsonlite::unbox("User Defined Identifier"),
            jsonlite::unbox("Volume")
        )
    } else {
        field.names.list <- lapply(field.names, jsonlite::unbox)
    }
    
    ## Prepare the HTTP Request Body using listID
    body <- list(
        "ExtractionRequest" = list (
            "@odata.type" =  jsonlite::unbox("#ThomsonReuters.Dss.Api.Extractions.ExtractionRequests.IntradayPricingExtractionRequest"),
            "ContentFieldNames" = field.names.list,
            "IdentifierList" = list(
                "@odata.type" = jsonlite::unbox("#ThomsonReuters.Dss.Api.Extractions.ExtractionRequests.InstrumentListIdentifierList"),
                "InstrumentListId" = jsonlite::unbox(listID)
            ),
            "Condition" = list( "ScalableCurrency" = jsonlite::unbox(TRUE) )
        )
    )
    
    ## build the POST request in json including Body request above
    
    ## @@ This code must be improve to handle the various response from the API
    ## see : https://developers.thomsonreuters.com/thomson-reuters-tick-history-trth/thomson-reuters-tick-history-trth-rest-api/learning?content=11307&type=learning_material_item
    
    # Request data - HTTP response On Demand extraction requests are executed as
    # soon as possible. There is no guarantee on the delivery time, it depends on
    # the amount of requested data, and the server load.
    #
    # In the request we set a preference for an asynchronous response. We will get
    # a response in 30 seconds (default wait time) or less.
    #
    # The HTTP status of the response can have one of several values, here we shall
    # detail the most likely ones:
    #
    # 202 Accepted - this is the one we are most likely to receive.
    #
    # It means the request was accepted, but processing has not yet completed.
    #
    # The next step is to check the request status by polling it regularly until it
    # returns a 200 OK. 200 OK - this one may happen if the request was very small.
    #
    # It means the request processing has completed.
    #
    # We can skip the step where we check the request status, and proceed directly
    # to the last step, which is to retrieve the data. Other codes: follow this
    # link for a full list with detailed explanations. It is strongly recommended
    # that you ensure your code handles all possible status codes.
    #
    # When requests take more than 30 seconds, a 202 Accepted is returned as the
    # first response. Usually Tick History requests will take more than 30 seconds,
    # which means that 202 Accepted will be the normal first response.
    #
    # You can customize the wait time, but this is not recommended.
    
    
    request <- httr::POST(
        url,
        add_headers(prefer = "respond-async", Authorization = token),
        content_type_json(),
        body = body,
        encode = "json"
    )
    message(request)
    stop_for_status(request)
    ## Get the result content
    answer <- httr::content(request, "parsed", "application/json", encoding="UTF-8")
    return(answer)
}



## =============================================================================
## 	[2] Examples
##
## =============================================================================

## -- Authentication
myToken <- DSSgetAuthenticationToken(user.login = myLogin, user.password = myPass)

## -- User Info
me <- DSSgetUserInfo(user.login = myLogin, token = myToken)
me

## -- Get Id of some instrument lists
test.list.id <- DSSgetInstrumentListIdentifier(instrument.list.name = "test", token = myToken)$ListId
test.list.id
vk.list.id <- DSSgetInstrumentListIdentifier(instrument.list.name = "billet-predictor", token = myToken)$ListId
vk.list.id

## -- Get some report templates
vk.standard.report <- DSSgetReportTemplateByName(report.template.name = "vk-standard-report", token = myToken)
vk.basic.report <- DSSgetReportTemplateByName(report.template.name = "vk-basic-report", token = myToken)
#v <- toJSON(vk.report, pretty = TRUE, auto_unbox = TRUE)

## -- Get these report templates field Names
vk.fields.standard <- DSSreportTemplateToFieldNames(report.template = vk.standard.report)
vk.fields.standard
vk.fields.basic <- DSSreportTemplateToFieldNames(report.template = vk.basic.report)
vk.fields.basic

## -- Get data from lists
data.basic <- DSSgetIntradayDataFromListId(listID = test.list.id, field.name = vk.fields.basic, token = myToken)
data.standard <- DSSgetIntradayDataFromListId(listID = vk.list.id, field.name = vk.fields.standard, token = myToken)