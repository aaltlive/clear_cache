require 'redis'
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader'

REDIS = Redis.new

route :get, :post, '/clearcache' do
  REDIS.rpush('all_urls', params['url'])
  json('response' => 1)

  # dev_mode
  json( REDIS.lrange('all_urls', 0, 999) )
  #

end