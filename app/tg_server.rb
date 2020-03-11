require 'logger'

require_relative 'server'
require_relative 'clearcache'

require 'bundler' 
Bundler.require(:default)

STDOUT.sync
$logger = Logger.new(STDOUT)
$logger.level = ENV.fetch('LOG_LEVEL', 'info')


def get_urls
  urls = []

  loop do 
    if u = REDIS.lpop('all_urls')
      urls.append(u)
      urls.uniq!
      break if urls.size >= 10 
    else
      break
    end
  end

  urls
end

def process_messages telegram, urls
  $logger.info("Processing #{urls.size} urls")

  telegram.msg('Webpage_Bot', 'New Round!')

  urls.each do |u|
    vk(u)
  end

  msg = urls.join(' ')

  telegram.msg('Webpage_Bot', msg) do |success, data|
    if data["error_code"]
      $logger.error("WebpageBot error: " + data.inspect)
    end
  end

#rescue StandardError=> e
#$logger.error "Exception in process: #{e}"
# push
end

# def request()
#   urls = []
#   mes = ""

#   while urls.uniq.length != 10
#     if u=REDIS.lpop('all_urls') then urls.append(u) else break end
#   end

#   for u in urls.uniq
#     mes += u + " "
#     begin
#       print("VK:", vk(u), ":", u, "\n")
#       # facebook(u)
#     rescue
#     end
#   end

#   return mes
# end

def output(out)
  puts("---------", out, "---------")
end

EM.run do
  telegram = Telegram::Client.new do |cfg, auth|
    cfg.daemon = './.telegram-cli/telegram-cli'
    cfg.key = './.telegram-cli/tg-server.pub'
  end

  telegram.connect do

    EventMachine::add_periodic_timer(5) do
      $logger.debug("New Round!")

      urls = get_urls()

      if urls.empty?
        $logger.debug("no urls")
        next
      end

      process_messages(telegram, urls)
      
    end

    # telegram.msg('Webpage_Bot', '/start')

    # telegram.on[Telegram::EventType::SEND_MESSAGE] = Proc.new do |event|
      

    #   telegram.msg('Webpage_Bot', mes) do |success, data|
    #     puts("TELEGRAM:")
    #     puts(data, "\n\n\n")

    #     if data["error_code"] == 71
    #       output("WAITING 60 sec")
    #       sleep(5)
    #       output("New Round")
    #       telegram.msg('Webpage_Bot', 'New Round!')
    #     end
    #   end
      
    #   output("WAITING 5 sec")
    #   sleep(5)
    # end
  end
end