require 'json'
require 'net/http'
require_relative 'server'

def vk(url)
  method_name = 'pages.clearCache'
  access_token = 'f6326aeff6326aeff6326aef6bf65dc875ff632f6326aefa87022de6e220f3855a3bcd8'
  v = '5.103'

  parameters = 'url=' + url
  api = "https://api.vk.com/method/#{method_name}?#{parameters}&access_token=#{access_token}&v=#{v}"

  resp = Net::HTTP.get_response(URI.parse(api))
  jresp = JSON.parse(resp.body)
  
  response = jresp["response"]

  errors = [
    # Произошла неизвестная ошибка.
    1,
    # Слишком много запросов в секунду.
    6,
    # Слишком много однотипных действий.
    9,
    # Произошла внутренняя ошибка сервера.
    10
    # Требуется ввод кода с картинки (Captcha).
    # 14,
    # Достигнут количественный лимит на вызов метода
    # 29,
    # Recaptcha needed
    # 3300
  ]

  if response
    return response
  else
    if errors.include? jresp["error"]["error_code"]
      REDIS.rpush('all_urls', url)
    end
    return jresp["error"]["error_msg"]
  end
end

def facebook(url)
  access_token = ''
  uri = URI('http://graph.facebook.com/')
  res = Net::HTTP.post_form(uri, 'id' => url, 'scrape' => true)
  
  return res.body
end