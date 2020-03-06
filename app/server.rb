require 'redis'
require 'sinatra'
require 'sinatra/contrib'
# require 'sinatra/reloader'

set :bind, '172.22.1.76'

REDIS = Redis.new

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