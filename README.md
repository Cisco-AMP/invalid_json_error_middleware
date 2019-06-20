# Rails rack middleware to catch JSON parse errors

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'invalid_json_error_middleware'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install invalid_json_error_middleware

## Testing

Simply run with rake

```
rake
```

## Usage

config/application.rb

```ruby
class Application < Rails::Application
  config.middleware.use InvalidJsonErrorMiddleware
end
```

For using additional filter checks or/and custom error message: 
```ruby
class Application < Rails::Application
  config.middleware.use InvalidJsonErrorMiddleware, filter_handler: ->(env) { env['HTTP_ACCEPT'] =~ /json/ }, error_handler: ->(error) { "Custom error message: #{error}" }
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at (invalid_json_error_middleware)[https://github.com/Cisco-AMP/invalid_json_error_middleware]. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Acknowledgements

This project was based off of similar gems such as (rack_middleware_json_error_msg)[https://rubygems.org/gems/rack_middleware_json_error_msg] and (catch_json_parse_errors)[https://rubygems.org/gems/catch_json_parse_errors]. Additionally code and design was taken and modified from (Thoughbot's article here)[https://thoughtbot.com/blog/catching-json-parse-errors-with-custom-middleware].

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
