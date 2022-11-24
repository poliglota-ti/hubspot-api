## Poli Hubspot
This gem was created to solve the problem of Hubspot connection, because we have multiple legacies services that share logic with this connection.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hubspot', git: 'https://github.com/poliglota-ti/hubspot-api', branch: 'main'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubspot

## For Develop Enviropment
First install docker and docker compose and
Build image:
  
    $ docker-compose build

And Up image:
  
    $ docker-compose up -d

Entry to bash
  Get the id of image of build_gem
  
    $ docker ps
  
  And paste the image id in this command
    
    $ docker exec -it YOUR_ID_OF_IMAGE bin/sh
  


  

Change the name .env.example to .env and paste the private key of hubspot account
## Usage Gem in Rails 
Create the file 

```sh
config/initializers/hubspot.rb
```
add the folow code to the file.
```ruby
Hubspot::Setting.configure do |config|
  config.key = Rails.env.production? ? 'production key' : 'development key'
end
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/poliglota-ti/hubspot-api