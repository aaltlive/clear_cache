require 'json'
require 'net/http'
require_relative 'server'

def vk(url)
  method_name = 'pages.clearCache'
  access_token = ''
  v = '5.103'

  parameters = 'url=' + url
  api = "https://api.vk.com/method/#{method_name}?#{parameters}&access_token=#{access_token}&v=#{v}"

  resp = Net::HTTP.get_response(URI.parse(api))
  jresp = JSON.parse(resp.body)
  
  response = jresp["response"]

  if response
    return response
  else
    return jresp["error"]["error_msg"]
  end
end

def facebook(url)
  access_token = ''
  uri = URI('http://graph.facebook.com/')
  res = Net::HTTP.post_form(uri, 'id' => url, 'scrape' => true)
  
  return res.body
end