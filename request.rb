require "redis"
require 'json'
require 'net/http'

def do_request()
  urls = []

  for i in 0..10
    if u=REDIS.lpop('all_urls')
      urls.append(u)
    else
      break
    end
  end

  for i in urls.uniq
    REDIS.rpush('all_urls', i) if not vk_clear(i)
  end

  return REDIS.lrange('all_urls', 0, 999)

end

def vk_clear(url)
  method_name = 'pages.clearCache'
  access_token = 'f6326aeff6326aeff6326aef6bf65dc875ff632f6326aefa87022de6e220f3855a3bcd8'
  v = '5.103'

  parameters = 'url=' + url
  api = "https://api.vk.com/method/#{method_name}?#{parameters}&access_token=#{access_token}&v=#{v}"

  resp = Net::HTTP.get_response(URI.parse(api))
  jresp = JSON.parse(resp.body)
  
  return jresp["response"]

end



# URI::InvalidURIError at /clearcache
# URI must be ascii only "https://api.vk.com/method/pages.clearCache?url=aaasdad\u0432\u0444\u044B\u0432
# 
# Если запрос не удался, то вернуть ссылку в очередь. Делать так ограниченное кол-во раз