require 'redis'
require 'sinatra'
require 'sinatra/contrib'
# require 'sinatra/reloader'

REDIS = Redis.new

set :bind, '0.0.0.0'

route :get, :post, '/clearcache' do
  url = params['url']
  if url and url != ""
    REDIS.rpush('all_urls', params['url'])
    json("response" => 1)
  else
    json("error" => {
      "error_code" => 400,
      "error_msg" => "URL parameter is empty"
    })
  end
end

not_found do
  status 404
  json("error" => {
    "error_code" => 404,
    "error_msg" => "Something wrong! Try to type URL correctly"
  })
end