require 'redis'
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader'

set :bind, '172.22.1.76'

REDIS = Redis.new

route :get, :post, '/clearcache' do
  REDIS.rpush('all_urls', params['url'])
  json("response" => 1)

  # dev_mode
  # REDIS.del("all_urls")
  json( REDIS.lrange('all_urls', 0, 999) )
  #
end

not_found do
  status 404
  json("error" => {
    "error_code" => 404,
    "error_msg" => "Something wrong! Try to type URL correctly"
  })
end