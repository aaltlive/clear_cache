require 'redis'
require 'sinatra'
require 'sinatra/contrib'

REDIS = Redis.new(host: "redis")

set :bind, '0.0.0.0'

route :get, :post, '/clearcache' do
  url = params['url']
  if url and url != ""
    REDIS.rpush('all_urls', url)
    json("response" => ARGV[0])
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