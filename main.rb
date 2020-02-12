require 'json'
require 'net/http'
require 'redis'

def redis()
  redis = Redis.new(host: "localhost")

  puts( redis.set("a", 1) )
  puts( redis.get("a") )
end


def vk_clear_cash(url)
  method_name = 'pages.clearCache'
  parameters = 'url=' + url
  access_token = 'f6326aeff6326aeff6326aef6bf65dc875ff632f6326aefa87022de6e220f3855a3bcd8'
  v = '5.103'

  api = "https://api.vk.com/method/#{method_name}?#{parameters}&access_token=#{access_token}&v=#{v}"

  resp = Net::HTTP.get_response(URI.parse(api))
  jresp = JSON.parse(resp.body)

  response = jresp["response"]
  if response
    puts(response)
  else
    error = jresp["error"]

    puts(error["error_code"])
    puts(error["error_msg"])
  end
end

def main()
  url = 'https://web.telegram.org/'

  redis()

  vk_clear_cash(url)
end

main()