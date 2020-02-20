require 'redis'
require 'sinatra'
require 'sinatra/reloader' # developer mode

REDIS = Redis.new

get '/clearcache' do
  url = params['url']
  REDIS.rpush('all_urls', url)

  "#{REDIS.lrange('all_urls', 0, 999)}" # developer mode

end

post '/clearcache' do
  url = params['url']
  "#{REDIS.rpush('all_urls', url)}"

end