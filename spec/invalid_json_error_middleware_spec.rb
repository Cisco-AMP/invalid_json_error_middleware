require 'spec_helper'

describe 'InvalidJsonErrorMiddleware' do
  let(:test_app) { double('Test Rack App') }
  let(:error_message) { 'some error message' }

  before do
    allow(test_app).to receive(:call).and_raise(ActionDispatch::Http::Parameters::ParseError.new(error_message))
  end

  context 'app without additional params' do
    let(:app) { InvalidJsonErrorMiddleware.new(test_app) }

    it 'raises default error when CONTENT_TYPE header is not application/json' do
      expect {
        post '/', {}, { 'CONTENT_TYPE' => 'text/html' }
      }.to raise_error(ActionDispatch::Http::Parameters::ParseError, error_message)
    end

    it 'raises custom error when CONTENT_TYPE header is application/json' do
      post '/', {}, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eql 400
      expect(last_response.content_type).to eql 'application/json'
      expect(last_response.body).to match error_message
    end

    it 'raises custom error when undefined ActionDispatch::Http::Parameters::ParseError' do
      allow(test_app).to receive(:call).and_raise(ActionDispatch::ParamsParser::ParseError.new(error_message))
      allow(app).to receive(:parse_error_class).and_return(ActionDispatch::ParamsParser::ParseError)

      post '/', {}, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eql 400
      expect(last_response.content_type).to eql 'application/json'
      expect(last_response.body).to match error_message
    end
  end

  context 'app with additional filter param' do
    let(:app) { InvalidJsonErrorMiddleware.new(test_app, filter_handler: filter_handler) }

    context 'when additional filter param true' do
      let(:filter_handler) { ->(_) { true } }

      it 'raises custom error' do
        post '/', {}, { 'CONTENT_TYPE' => 'application/json' }

        expect(last_response.status).to eql 400
        expect(last_response.content_type).to eql 'application/json'
        expect(last_response.body).to match error_message
      end
    end

    context 'when additional filter param false' do
      let(:filter_handler) { ->(_) { false } }

      it 'raises default error' do
        expect {
          post '/', {}, { 'CONTENT_TYPE' => 'application/json' }
        }.to raise_error(ActionDispatch::Http::Parameters::ParseError, error_message)
      end
    end
  end

  context 'app with additional error param' do
    let(:custom_error_message) { 'Some custom error message' }
    let(:app) { InvalidJsonErrorMiddleware.new(test_app, error_handler: ->(_) { custom_error_message }) }

    it 'raises custom error' do
      post '/', {}, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response.status).to eql 400
      expect(last_response.content_type).to eql 'application/json'
      expect(last_response.body).to match custom_error_message
    end
  end
end
