require 'json'
require 'logger'
require 'bundler' 
require 'net/http'

require_relative 'server'

Bundler.require(:default)

STDOUT.sync
$logger = Logger.new(STDOUT)
$logger.level = ENV.fetch('LOG_LEVEL', 'debug')

def get_urls()
  urls = []

  while urls.uniq.size < 10
    if u=REDIS.lpop('all_urls') then urls.append(u) else break end
  end

  return urls.uniq
end

def vk(url)
  method_name = 'pages.clearCache'
  access_token = 'f6326aeff6326aeff6326aef6bf65dc875ff632f6326aefa87022de6e220f3855a3bcd8'
  v = '5.103'

  parameters = 'url=' + url
  api = "https://api.vk.com/method/#{method_name}?#{parameters}&access_token=#{access_token}&v=#{v}"

  begin
    resp = Net::HTTP.get_response(URI.parse(api))
  rescue
    $logger.error("GET-response error")
    return
  end

  jresp = JSON.parse(resp.body)
  
  response = jresp["response"]

  if response
    $logger.debug(response)
  else
    $logger.error(jresp["error"]["error_msg"])
    # ВОЗВРАТ ССЫЛКИ В РЕДИС
  end
end

def process_messages(telegram, urls)
  $logger.debug("Processing #{urls.size} urls")

  urls.each do |u|
    vk(u)
  end

  msg = urls.join(' ')

  telegram.msg('Webpage_Bot', msg) do |success, data|
    if data["result"] == "SUCCESS"
      $logger.debug("tg - success")
    else
      $logger.error("Telegram-cli error: " + data.inspect)
      # ВОЗВРАТ ССЫЛКИ В РЕДИС
    end
  end
end

EM.run do
  telegram = Telegram::Client.new do |cfg|
    cfg.daemon = './.telegram-cli/telegram-cli'
    cfg.key = './.telegram-cli/tg-server.pub'
  end

  telegram.connect do

    EventMachine::add_periodic_timer(5) do
      $logger.debug("New Round")

      urls = get_urls()

      if urls.empty?
        $logger.debug("No Urls")
        next
      end

      process_messages(telegram, urls)
      
    end
  end
end