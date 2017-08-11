# bahn_ex [![Build Status](https://travis-ci.org/pfitz/bahn_ex.svg?branch=master)](https://travis-ci.org/pfitz/bahn_ex) [![Hex.pm](http://img.shields.io/hexpm/v/bahn_ex.svg?style=flat)](https://hex.pm/packages/bahn_ex)

An Elixir wrapper for the api of [Deutsche Bahn Fahrplan API](https://developer.deutschebahn.com/store/apis/info?name=Fahrplan&version=v1&provider=DBOpenData)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bahn_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bahn_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/bahn_ex](https://hexdocs.pm/bahn_ex).

## Configuration
To access the api one needs an api key from Deutsche Bahn. Either you write an request via Email or 
you could register at the [Bahn Developer Portal](https://developer.deutschebahn.com/) and retrieve
on api key there.
Once you got an api key add it to the config like so:

1) Make a file in `config/` called `bahn_ex_secret.exs`
2) Fill it with the following content

        use Mix.Config
        config :bahn_ex, api_key: "your api key here"
        
Or define the enviroment variable `BAHNEX_API_KEY`.        
        
        
## Documentation
Use the documentation at [hexdocs](https://hexdocs.pm/bahn_ex) or this file.

## Usage 
Please check the api documentation or use the help command inside `iex`. 

## Examples
Get the location for Köln:

    iex(1)> BahnEx.get_location("Köln")
    
Get the arrival board for Dresden at `2017-08-23T19:00:00Z`:

    iex(1)> BahnEx.arrival_board(8010085, "2017-08-23T19:00:00Z")
         [%BahnEx.Train{boardId: 8010085, dateTime: #DateTime<2017-08-23 19:35:00Z>,
           detailsId: "304116%2F104694%2F528716%2F162986%2F80%3fstation_evaId%3D8010085",
           name: "ICE 1653", origin: "Frankfurt(M) Flughafen Fernbf", stopId: 8010085,
           stopName: "Dresden Hbf", track: "3", type: "ICE"},
          %BahnEx.Train{boardId: 8010085, dateTime: #DateTime<2017-08-23 20:36:00Z>,
           detailsId: "521202%2F179326%2F919084%2F285808%2F80%3fstation_evaId%3D8010085",
           name: "IC 2047", origin: "Dortmund Hbf", stopId: 8010085,
           stopName: "Dresden Hbf", track: "1", type: "IC"}]
           
Get the departure board for Dresden at `2017-08-23T19:00:00Z`:

    iex(1)> BahnEx.arrival_board(8010085, "2017-08-23T19:00:00Z")
         [%BahnEx.Train{boardId: 8010085, dateTime: #DateTime<2017-08-23 19:35:00Z>,
           detailsId: "304116%2F104694%2F528716%2F162986%2F80%3fstation_evaId%3D8010085",
           name: "ICE 1653", origin: "Frankfurt(M) Flughafen Fernbf", stopId: 8010085,
           stopName: "Dresden Hbf", track: "3", type: "ICE"},
          %BahnEx.Train{boardId: 8010085, dateTime: #DateTime<2017-08-23 20:36:00Z>,
           detailsId: "521202%2F179326%2F919084%2F285808%2F80%3fstation_evaId%3D8010085",
           name: "IC 2047", origin: "Dortmund Hbf", stopId: 8010085,
           stopName: "Dresden Hbf", track: "1", type: "IC"}] 
           
Get the journey information for `EC 171` from Dresden to Prague:

    iex(1)> BahnEx.journey_details("475620%252F175342%252F176320%252F70380%252F80%253fstation_evaId%253D8010085")
          https://api.deutschebahn.com/fahrplan-plus/v1/journeyDetails/475620%252F175342%252F176320%252F70380%252F80%253fstation_evaId%253D8010085
          [%BahnEx.TrainLoc{arrTime: nil, depTime: ~T[07:03:00], lat: "52.525589",
            lon: "13.369549", operator: "DPN", stopId: 8098160,
            stopName: "Berlin Hbf (tief)", train: "EC 171", type: "EC"},
           %BahnEx.TrainLoc{arrTime: ~T[07:08:00], depTime: ~T[07:10:00],
            lat: "52.475043", lon: "13.365315", operator: "DPN", stopId: 8011113,
            stopName: "Berlin Südkreuz", train: "EC 171", type: "EC"}]          
    
    
## Issues
Please use the [issue traker at github](https://github.com/pfitz/bahn_ex/issues) to file issues. If you could I really like to 
have a pull request.

## Contribution
Feel free to make a pull request. 
    
## License
BahnEx is licensed under the MIT license.