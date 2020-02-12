require 'sinatra'

get '/posts' do
  # matches "GET /posts?url="
  url = params['url']
end