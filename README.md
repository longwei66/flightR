# flightR

## Overview

### What is flightR

A package to deal with flight status data and related information.
Currently two sources are used, the REST API of [Aviation Edge](https://aviation-edge.com/developers/) & [OpenSky Network]()

### Available Services

- Aviation Edge API (status: partial) - https://aviation-edge.com/developers/
- Opensky network API (status: partial) - https://opensky-network.org/apidoc/#
- Flightstats API (status: pending) - https://developer.flightstats.com/getting-started/
- flightaware API (status: pending) - https://fr.flightaware.com/commercial/firehose/firehose_documentation.rvt
- OAG API (status: pending) - https://www.oag.com/flightview/flight-status-data-api



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
devtools::load_all()
devtools::test()
```
