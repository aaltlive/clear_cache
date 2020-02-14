require 'redis'
require 'sinatra'
require 'sinatra/reloader'

REDIS = Redis.new

get '/clearcache' do
  url = params['url']
  REDIS.rpush('all_urls', url)

  # Для проверки, удалить!
  "#{REDIS.lrange('all_urls', 0, 999)}"

end

