require 'redis'
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader'

REDIS = Redis.new

route :get, :post, '/clearcache' do
  REDIS.rpush('all_urls', params['url'])
  json('response' => 1)

  # dev_mode
  # REDIS.del("all_urls")
  json( REDIS.lrange('all_urls', 0, 999) )
  #
end