require 'sinatra'
require 'json'
require_relative 'handler'

get '/' do
  erb :index
end

post '/compute/:request_id' do |request_id|
  body = request.body.read
  data = JSON.parse(body, symbolize_names: true)
  result = handle_request(data, request_id)
  JSON.dump(result)
end
