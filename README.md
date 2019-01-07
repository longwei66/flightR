# flightR

## Overview

### What is flightR

A package to deal with flight status data and related information.
Currently two sources are used, the REST API of [Aviation Edge](https://aviation-edge.com/developers/) & [OpenSky Network]()

### Available Services

- Aviation Edge API (status: partial) - https://aviation-edge.com/developers/
- Opensky network API (status: complete) - https://opensky-network.org/apidoc/#
- Flightstats API (status: pending) - https://developer.flightstats.com/getting-started/
- flightaware API (status: pending) - https://fr.flightaware.com/commercial/firehose/firehose_documentation.rvt
- OAG API (status: pending) - https://www.oag.com/flightview/flight-status-data-api

### Included data

- `countries` list of countries with names and iso code as a data.table
- `airports` list of airports resulting of combined data from http://ourairports.com/data/, https://en.wikipedia.org/wiki/List_of_airports_by_IATA_and_ICAO_code, https://datahub.io )


### How to install flightR

`devtools::install_github(repo = "https://github.com/longwei66/flightR")`


## Aviation Edge API

### Overview

> We collect data from hundreds of sources. Official authorities as well as other established industry partners such as airlines and airports. This data we compile in our extensive database. We’ve developed a system where we combine software as well as manual checks to assure our data is always up to date. That way Aviation-Edge can deliver accurate data to our clients in a quick and easy manner. On top of this we offer complete support all the way through your implementation process and thereafter.

This service isn't free

> We have divided the subscription options into 5 levels. Free, which gives you 100 API calls for a limited amount of time, developer which is for small-scale development projects, business for medium-sized enterprise solutions, business gold for large enterprises and we have the unlimited package for international enterprises and government projects.

### Resources
https://aviation-edge.com/developers/

### Api implemented in `flightR` package


#### Flight Tracker API `flightR::getAEflightTracker()`

> Clients can connect to the flight tracking through the API key which gives direct access to all the live flight data. The flight tracker API allows clients to display within their applications or on their websites and other platforms, the actual tracking of flights including all their relevant information. This service is central to our aviation data and maintained constantly within our database. Since the data is live, the updates happen within short intervals of just a few minutes. Aviation Edge’s function is to gather and maintain the complete aviation data for our clients so that they can create the functional tools for their customers.

#### Aiport Timetables API `flightR::getAEtimetables()`

> The API service provides the flight schedules and timetables of all airports and airlines around the world and maintains this for the clients in a central database, always accessible with the personal API key. The airport and airline timetables and schedules API is one of Aviation Edge’s core features. Making it easy for developers to provide their customers with actual airport departure and arrival times through API on their applications or websites. Our function is to gather and maintain the aviation data and format this into workable flight schedules and airport timetables for the clients so that they can focus on their core business of providing this information to their customers.

#### Airport API `flightR::getAEairports()`

> World airport database with detailed data on every airport. The database can be downloaded or reached through API. It actually contains data about all aviation platforms, including private and public airports, airstrips, helipads, seaports and much more. It’s possible to download in excel, csv or sql format. Most of our clients initially download this as a stand-alone document or in combination with the other databases in a complete package. Aviation Edge has developed dedicated software to connect with our partners and airports directly to maintain the data actual. When downloading the database you will automatically receive mayor updates on the email used for registration. An other option is to connect to the API service which also allows you access to our other features which make use of the airport database.

> Airport details: Name, IATA code ICAO code, Name translations, routes. Locational information: Name and ISO of country, IATA of nearby city, Latitude and Longitude coordinates, Timezone, GMT offset, geoname ID. Contact information: website and phone nr (when available)

#### Airline API `flightR::getAEairlines()`

> A complete database of all the airlines in the world. Used often in combination with other API solutions such as the flight tracker, airline schedules and routes. The database is a foundation for a wide range of software applications. There are two ways to obtain the airline database, either by downloading it in excel, csv or sql format or by connecting to the API service which Aviation Edge provides. When you download the database individually or in combination with other databases, you will receive important updates automatically by mail and you can also access your account at any time to download the database. The other option through API will allow you to develop a software to automatically check for updates.

> Data included in Airline Database download : Codes: Aside from the airline Name, the database includes IATA code and IATA prefix and IATA accounting code, ICAO code / Related data: IATA code of the Hub airport of the airline, name and ISO code of country / Airline details: Status of airline (active, closed, etc), Type of airline, Founding year, Fleet size, average age of fleet / Contact information: Website, twitter, facebook, phone nr (when available)

#### Aircrafts API `flightR::getAEaircrafts()`

> Aviation Edge maintains an aircraft registry in the form of a database of all aircraft types which can be downloaded in excel, csv or sql format. It is also possible to connect to this database through the API service. The database is used internally for flight tracking and by the clients for a wide range of software applications. By downloading the airplane database you will receive support and mayor updates for the period of one year. The data we provide saves clients a lot of time of manually aggregating the data from various sources. On top of this we have developed software to control the validity of the data where possible. This allows clients to focus on their core business while relying on our aviation database.

> Data included in Aircraft Database : Aircraft basic: Name, model, registration number, IATA typecode, ICAO24 hex code, IATA short and long / Historic data: Date of rollout, first flight, delivery and registration of aircraft / Production data: Construction number, production line, airplane series / Owner information: Owner of plane, airline IATA and ICAO code / Aircraft details: Classes, seats, Amount of engines, age of airplane and status.

#### Cities API `flightR::getAEcities()`

> The database contains all cities in the world with their aviation and travel related data. It is possible to download the city database in excel, csv or sql format so that it functions for all of our clients. The other way to reach this data is through our API system which will automatically be updated with new information as we aggregate them. Many of the clients initially download the city database followed by signing up to obtain their own API key. There is a free sample available to verify if the data contains what you are looking for before committing to it. When downloading you will receive updates of any mayor changes automatically by mail.

> Data included in City Database : City basic: Name, IATA, ISO-2 related country / Location data: Latitude, Longitude, Timezone, GMT offset, Geoname ID / Translations: Translations of the city name (when available).

## Opensky Network API

### Overview

> [...] The API lets you retrieve live airspace information for research and non-commerical purposes. See our terms and conditions for more details on the data license model. [...] Information is provided in the form of State Vectors

> Airplanes seen by the OpenSky Network are associated with flight state information derived from ADS-B and Mode S messages. The state of an aircraft is a summary of all tracking information (mainly position, velocity, and identity) at a certain point in time. These states of aircraft can be retrieved as state vectors in the form of a JSON object.
In ADS-B, each aircraft (actually each transponder) is identified with a unique address, the ICAO 24-bit address. Usually this address is displayed in its 6-character hex representation (e.g. c0ffee).
As soon as an ADS-B message of an airplane arrives at our servers, we create a record for the aircraft – the so called state vector. All information required to track the airplane, including its identity (ICAO address + call sign), time information (Unix timestamps), and spatial information (position, velocity, heading, …) will be represented in this state vector.


### Resources
https://opensky-network.org/apidoc/#

### Api implemented in `flightR` package

#### All State Vectors `flightR::getOSNallStateVectors()`
Retrieve any state vector of the OpenSky for a given time in the last hour, could be limited in a geographical bounding box

#### Own State Vector
This API will not be implemented in this project

#### Flights by Aircraft `flightR::getOSNflightsByAircraft()`
This API call retrieves flights for a particular aircraft within a certain time interval. Resulting flights departed and arrived within [begin, end]. If no flights are found for the given period, HTTP stats 404 - Not found is returned with an empty response body.

#### Arrivals / Departure by Airport `flightR::getOSNflightsByAirport()`

Retrieve flights for a certain airport which arrived / departed within a given time interval.


#### Track by Aircraft `flightR::getOSNtrackByAircraft()`

Retrieve the trajectory for a certain aircraft at a given time. The trajectory is a list of waypoints containing position, barometric altitude, true track and an on-ground flag.


## Package Workflow

```
devtools::document()
usethis::use_data()
devtools::build()
devtools::build_vignettes()
devtools::test()
devtools::load_all()

```
