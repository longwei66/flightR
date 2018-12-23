context("Make Time Table Item Overview")
library(flightR)

## -- data from arrived flight no delay
## =============================================================================
arrived.flight <- jsonlite::fromJSON('
    {
        "type": ["arrival"],
        "status": ["landed"],
        "departure": {
            "iataCode": ["TMS"],
            "icaoCode": ["FPST"],
            "scheduledTime": ["2018-12-22T08:50:00.000"],
            "estimatedRunway": ["2018-12-22T09:46:00.000"],
            "actualRunway": ["2018-12-22T09:46:00.000"]
        },
        "arrival": {
            "iataCode": ["LIS"],
            "icaoCode": ["LPPT"],
            "terminal": ["1"],
            "scheduledTime": ["2018-12-22T14:05:00.000"],
            "estimatedRunway": ["2018-12-22T14:37:00.000"],
            "actualRunway": ["2018-12-22T14:37:00.000"]
        },
        "airline": {
            "name": ["euroAtlantic Airways"],
            "iataCode": ["YU"],
            "icaoCode": ["MMZ"]
        },
        "flight": {
            "number": ["508"],
            "iataNumber": ["YU508"],
            "icaoNumber": ["MMZ508"]
        },
        "codeshared": {
            "airline": {
                "name": ["STP Airways"],
                "iataCode": ["8F"],
                "icaoCode": ["STP"]
            },
            "flight": {
                "number": ["508"],
                "iataNumber": ["8F508"],
                "icaoNumber": ["STP508"]
            }
        }
    }'
)

arrived.flight.answer <- jsonlite::fromJSON('
{
  "airliner": ["euroAtlantic Airways"],
  "airliner.iata.code": ["YU"],
  "flight.iata.number": ["YU508"],
  "from.iata.code": ["TMS"],
  "from.scheduled.time": ["2018-12-22T08:50:00.000"],
  "from.estimated.time": [null],
  "from.actual.time": [null],
  "to.iata.code": ["LIS"],
  "to.scheduled.time": ["2018-12-22T14:05:00.000"],
  "to.estimated.time": [null],
  "to.actual.time": [null],
  "departure.delay": [null],
  "type": ["arrival"],
  "status": ["landed"],
  "arrival.delay": [null]
} ')

## -- Data from delayed flight
## =============================================================================
arrived.flight.delay <- jsonlite::fromJSON('
{
  "type": ["arrival"],
  "status": ["landed"],
  "departure": {
    "iataCode": ["TUN"],
    "icaoCode": ["DTTA"],
    "terminal": ["M"],
    "delay": [205],
    "scheduledTime": ["2018-12-22T13:05:00.000"],
    "estimatedTime": ["2018-12-22T16:30:00.000"],
    "actualTime": ["2018-12-22T16:30:00.000"]
  },
  "arrival": {
    "iataCode": ["LIS"],
    "icaoCode": ["LPPT"],
    "terminal": ["1"],
    "delay": [200],
    "scheduledTime": ["2018-12-22T15:00:00.000"],
    "estimatedTime": ["2018-12-22T18:20:00.000"],
    "actualTime": ["2018-12-22T18:20:00.000"],
    "estimatedRunway": ["2018-12-22T18:01:00.000"],
    "actualRunway": ["2018-12-22T18:01:00.000"]
  },
  "airline": {
    "name": ["Tunisair"],
    "iataCode": ["TU"],
    "icaoCode": ["TAR"]
  },
  "flight": {
    "number": ["318"],
    "iataNumber": ["TU318"],
    "icaoNumber": ["TAR318"]
  }
}
')

arrived.flight.delay.answer <- jsonlite::fromJSON('
                                                  {
  "airliner": ["Tunisair"],
  "airliner.iata.code": ["TU"],
  "flight.iata.number": ["TU318"],
  "from.iata.code": ["TUN"],
  "from.scheduled.time": ["2018-12-22T13:05:00.000"],
  "from.estimated.time": ["2018-12-22T16:30:00.000"],
  "from.actual.time": ["2018-12-22T16:30:00.000"],
  "to.iata.code": ["LIS"],
  "to.scheduled.time": ["2018-12-22T15:00:00.000"],
  "to.estimated.time": ["2018-12-22T18:20:00.000"],
  "to.actual.time": ["2018-12-22T18:20:00.000"],
  "departure.delay": [205],
  "type": ["arrival"],
  "status": ["landed"],
  "arrival.delay": [200]
} 
                                                  ')

test_that("makeTimetableItemOverview handle missing input", {
    expect_equal(makeTimetableItemOverviewAE(timetable.item = NULL), NULL)
})
test_that("makeTimetableItemOverview handle arrived no delay flight", {
    expect_equal(makeTimetableItemOverviewAE(timetable.item = arrived.flight), arrived.flight.answer)
})
test_that("makeTimetableItemOverview handle arrived delay flight", {
    expect_equal(makeTimetableItemOverviewAE(timetable.item = arrived.flight.delay), arrived.flight.delay.answer)
})




