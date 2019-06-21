require 'rack/test'
require 'json'
require 'invalid_json_error_middleware'

include Rack::Test::Methods

module ActionDispatch
  module ParamsParser
    class ParseError < Exception
    end
  end

  module Http
    module Parameters
      class ParseError < Exception
      end
    end
  end
end
