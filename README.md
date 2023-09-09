# Hop Skip Test Drive Quickstart

Ruby 3.2.2
Rails 7.0.7

Setup:

- type `bundle isntall`
- type `rails:credentials:edit` and add your api key to google: :maps_api_key
- type `rails  db:create db:migrate db:seed`
  - Seedfile displayes progress text & displays when complete
- run tests with `rspec spec`

# API::V1::RidesController

## Index

Fetches paginated rides for a driver ordered by score in descending order.

URL: `/api/v1/rides`

Method: `GET`

URL Params:

`page=[integer]` - Optional page number for pagination

### Success Response:

Code: `200`

Content:

json

```json
{
  "status": 200,
  "body": [
    {
      "id": 2,
      "driver_id": 1,
      "distance_in_miles": "5",
      "duration_in_minutes": "15",
      "commute_distance_in_miles": "2",
      "commute_duration_in_minutes": "5",
      "earnings": 12.0,
      "score": 0.88,
      "start_address_attributes": {
        "addressable_id": 1,
        "addressable_type": "Ride",
        "street_address": "1745 T Street Southeast",
        "city": "Washington",
        "state": "DC",
        "zip_code": "20020"
      }
    }
  ]
}
```

### Error Response:

Condition: `Driver has no rides`

Code: `400`

Content:

json

```json
{
  "status": 400,
  "body": "No rides available, please try again shortly"
}
```

Notes:

- Fetches rides for driver, ordered by score descending
- Paginates results with page parameter (default page size is 20)
- Returns error if driver has no rides

Considerations:

- My thoughts on limiting external api usage while calculating the info
  - Use sidekiq/CRON jobs to schedule the requests instead of making them on-deman
  - Or roll my own cache like system where I could check for latest timestamp before making a new request
