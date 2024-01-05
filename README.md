# Conductivity Backend
Public Rest API used to calculate if a 2D array has continuous conductive path

## Features

- Fetch list of paths for a 2D array
- Fetch history of 2D arrays
- Store history of 2D arrays
- Clean history of 2d arrays

## Tech

Technologies, libraries, gems and other tools used for this development:

- Ruby On Rails: Full stack web framework
- SQLite: Free and open-source relational database management system
- RSpec - Testing tool for Ruby, created for behavior-driven development

## Installation

Conductivity Backend requires [Ruby](https://www.ruby-lang.org/) v3.0.0+ to run
Install the dependencies and and start the server

```sh
cd conductivity-backend
bundle install
rails s -p 4000
```
## Run tests

This application uses RSpec as testing library, first you need to setup the test database in the `config/database.yml` file, then run the following command in terminal:

```sh
cd question_vault
bundle exec rspec
```
# REST API
The different requests are exlpained below.

## Get grids history

### Request

`GET /grids`

    curl -i -H 'Accept: application/json' http://localhost:4000/grids

### Response

    HTTP/1.1 200 OK
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 200 OK
    Connection: close
    Content-Type: application/json
    Content-Length: 120

    [
        {
            "id": 1,
            "values": [[1,0],[1,1]],
            "timestamp": "2024-01-05T14:34:14+00:00",
            "vertical_path_indexes": [1],
            "horizontal_path_indexes": []
        },
        {
            "id": 2,
            "values": [[1,0],[0,1]],
            "timestamp": "2024-01-06T14:34:14+00:00",
            "vertical_path_indexes": [0],
            "horizontal_path_indexes": []
        }
    ]
    
## Create history

### Request

`POST /grids`

    curl -X POST -i -H 'Accept: application/json' http://localhost:4000/grids -d '{"values":"[[1,0],[1,1]]"}'

### Response

    HTTP/1.1 200 OK
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 200 OK
    Connection: close
    Content-Type: application/json
    Content-Length: 56

    {
        "id": 1,
        "values": [[1,0],[1,1]],
        "timestamp": "2024-01-05T14:34:14+00:00",
        "vertical_path_indexes": [1],
        "horizontal_path_indexes": []
    }

## Clear history

### Request

`DELETE /grids/clear`

    curl -X DELETE -i -H 'Accept: application/json' http://localhost:4000/grids/clear

### Response

    HTTP/1.1 200 OK
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 200 OK
    Connection: close
    Content-Type: application/json
    Content-Length: 20

    {
        "deleted_records": 10,
    }
    
## Find paths

### Request

`GET /grids/find_paths`

    curl -i -H 'Accept: application/json' http://localhost:4000/grids/find_paths?values=[[1,0],[1,0]]

### Response

    HTTP/1.1 200 OK
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 200 OK
    Connection: close
    Content-Type: application/json
    Content-Length: 20

    {
        "vertical_path_indexes": [1],
        "horizontal_path_indexes": [0],
        "has_paths": true
    }

## License
MIT