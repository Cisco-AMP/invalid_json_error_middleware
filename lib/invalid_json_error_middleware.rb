class InvalidJsonErrorMiddleware
  def initialize(app, filter_handler: ->(_) { true }, error_handler: ->(error) { error_message(error) })
    @app = app
    @filter_handler = filter_handler
    @error_handler = error_handler
  end

  def call(env)
    begin
      @app.call(env)
    rescue parse_error_class => error
      if raise_custom_error?(env)
        return [
          400, { 'Content-Type' => 'application/json' },
          [{ status: 400, error: @error_handler.call(error) }.to_json]
        ]
      else
        raise error
      end
    end
  end

  private

  def parse_error_class
    if defined?(ActionDispatch::Http::Parameters::ParseError)
      ActionDispatch::Http::Parameters::ParseError
    else
      ActionDispatch::ParamsParser::ParseError
    end
  end

  def raise_custom_error?(env)
    @filter_handler.call(env) && content_type?(env)
  end

  def content_type?(env)
    env['CONTENT_TYPE'] =~ /application\/json/
  end

  def error_message(error)
    "There was a problem in the JSON you submitted: #{error}"
  end
end
