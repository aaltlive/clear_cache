require 'json'
require 'net/http'
require 'redis'
require 'sinatra'
require 'sinatra/reloader'

def vk_clear_cash(url)
  method_name = 'pages.clearCache'
  access_token = 'f6326aeff6326aeff6326aef6bf65dc875ff632f6326aefa87022de6e220f3855a3bcd8'
  v = '5.103'

  parameters = 'url=' + url
  api = "https://api.vk.com/method/#{method_name}?#{parameters}&access_token=#{access_token}&v=#{v}"

  resp = Net::HTTP.get_response(URI.parse(api))
  jresp = JSON.parse(resp.body)

  response = jresp["response"]
  if response
    return response
  else
    return 0
  end

end

def social_clear_cache(url)
  vk_clear_cash(url)

end

def urls_group(urls)
  urls = urls.each_slice(10).to_a

  return urls

end

def req(urls)
  for group in urls
    for url in group
      social_clear_cache(url)      
    end
  end

end

get '/clearcache' do
  # matches "GET /clearcache?url="
  url = params['url']

  redis = Redis.new(host: "localhost")
  redis.sadd('urls', url)

  urls = redis.smembers('urls')
  urls = urls_group(urls)
  # redis.del('urls')

  "#{req(urls)}"

end

# URI::InvalidURIError at /clearcache
# URI must be ascii only "https://api.vk.com/method/pages.clearCache?url=aaasdad\u0432\u0444\u044B\u0432
# 