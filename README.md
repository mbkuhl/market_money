# Market Money

This repository is one of a pair of repositories for the Market Money project. You can find the front end repository [here](https://github.com/mbkuhl/market_money_fe).

### About this Project

"You are working for a company developing an interface to help people find sustainable and local alternatives for their lifestyle in their area. One of their features to encourage supporting local growers/crafters/etc., is a Farmers Market lookup. Your company uses a Micro Service Architecture, and needs you to build out the service that is responsible for providing functionality for Farmers Market & Vendors."

My job is to expose the data that powers this part of the site through an API that the front end would consume. I would then build the front end that consumes this API.

### Context

This project was completed 14 weeks into learning coding. This was a solo project, and the timeline for completion was 4 days. 

### Learning Goals

- Expose an API

- Use serializers to format JSON responses

- Test API exposure

- Error Handling

- Use SQL and AR to gather data

- Consume an API 

## Setup

1. Fork and Clone the repo

2. Insert your API key from [TomTom](https://developer.tomtom.com/):

    a. Open your credentials file using `EDITOR="code --wait" rails credentials:edit`

    b. Copy and paste your key using the format. Indentation is important

    ```sh
      tomtom:
        key: 
    ```
2. Setup the database: `rails db:{drop,create,migrate,seed}`
5. Run: `rails db:schema:dump`
6. Run on local: `rails s`. 
7. Endpoints can be tested using `http://localhost:5000/` and then the proper route if the front end is not running.


## Versions

- Ruby 3.2.2

- Rails 7.1.2

