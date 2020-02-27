require 'json'
require 'net/http'

def vk(url)
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
    return jresp["error"]["error_msg"]
  end

end

def twitter(url)
end

def facebook(url)
end