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
        
        
## Documentation
Use the documentation at [hexdocs](https://hexdocs.pm/bahn_ex) or this file.

## Usage 
Please check the api documentation or use the help command inside `iex`. 

## Examples
    iex(1)> BahnEx.get_location("Köln")
    
## Issues
Please use the [issue traker at github](https://github.com/pfitz/bahn_ex/issues) to file issues. If you could I really like to 
have a pull request.

## Contribution
Feel free to make a pull request. 
    
## License
BahnEx is licensed under the MIT license.