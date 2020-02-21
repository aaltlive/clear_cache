require 'redis'
require 'sinatra'
require 'sinatra/reloader' # developer mode

REDIS = Redis.new

get '/clearcache' do
  REDIS.rpush('all_urls', params['url'])

  "#{REDIS.lrange('all_urls', 0, 999)}" # developer mode

end

post '/clearcache' do
  "#{REDIS.rpush('all_urls', params['url'])}"

end