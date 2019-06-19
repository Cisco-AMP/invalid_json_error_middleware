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

Bug reports and pull requests are welcome on GitHub at https://github.com/Snick555/invalid_json_error_middleware. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
