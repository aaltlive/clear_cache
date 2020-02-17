require 'json'
require 'net/http'

def vk_clear(url)
  method_name = 'pages.clearCache'
  access_token = 'f6326aeff6326aeff626aef6bf65dc875ff632f6326aefa87022de6e220f3855a3bcd8'
  v = '5.103'

  parameters = 'url=' + url
  api = "https://api.vk.com/method/#{method_name}?#{parameters}&access_token=#{access_token}&v=#{v}"

  resp = Net::HTTP.get_response(URI.parse(api))
  jresp = JSON.parse(resp.body)
  
  return jresp["response"]

end