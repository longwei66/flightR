# flightR

## Overview

### What is flightR

A package to deal with flight status data and related information.
Currently two sources are used, the REST API of [Aviation Edge](https://aviation-edge.com/developers/) & [OpenSky Network]()

### How to install flightR

`devtools::install_github(repo = "https://github.com/longwei66/flightR")`


## Aviation Edge API


## Opensky Network API

### Overview

> [...] The API lets you retrieve live airspace information for research and non-commerical purposes. See our terms and conditions for more details on the data license model. [...] Information is provided in the form of State Vectors

> Airplanes seen by the OpenSky Network are associated with flight state information derived from ADS-B and Mode S messages. The state of an aircraft is a summary of all tracking information (mainly position, velocity, and identity) at a certain point in time. These states of aircraft can be retrieved as state vectors in the form of a JSON object.
In ADS-B, each aircraft (actually each transponder) is identified with a unique address, the ICAO 24-bit address. Usually this address is displayed in its 6-character hex representation (e.g. c0ffee).
As soon as an ADS-B message of an airplane arrives at our servers, we create a record for the aircraft – the so called state vector. All information required to track the airplane, including its identity (ICAO address + call sign), time information (Unix timestamps), and spatial information (position, velocity, heading, …) will be represented in this state vector.

### Resources
https://opensky-network.org/apidoc/#

### Api implemented in this package

#### All State Vectors `flightR::getAllStateVectorsOSN()`
Retrieve any state vector of the OpenSky for a given time in the last hour, could be limited in a geographical bounding box

#### Arrivals / Departure by Airport `flightR::getFlightsByAirportOSN()`

Retrieve flights for a certain airport which arrived / departed within a given time interval.


## Package Workflow

```
devtools::document()
devtools::load_all()
devtools::test()
```
