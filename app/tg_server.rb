require_relative 'server'
require_relative 'clearcache'

require 'bundler' 
Bundler.require(:default)

def request()
  urls = []
  mes = ""

  while urls.uniq.length != 10
    if u=REDIS.lpop('all_urls') then urls.append(u) else break end
  end

  for u in urls.uniq
    mes += u + " "
    begin
      print("VK:", vk(u), ":", u, "\n")
      # facebook(u)
    rescue
    end
  end

  return mes
end

def output(out)
  puts("---------", out, "---------")
end

EM.run do
  telegram = Telegram::Client.new do |cfg, auth|
    cfg.daemon = './tg/bin/telegram-cli'
    cfg.key = './tg/tg-server.pub'
  end

  telegram.connect do
    telegram.msg('Webpage_Bot', '/start')

    telegram.on[Telegram::EventType::SEND_MESSAGE] = Proc.new do |event|
      mes = request()

      telegram.msg('Webpage_Bot', mes) do |success, data|
        puts("TELEGRAM:")
        puts(data, "\n\n\n")

        if data["error_code"] == 71
          output("WAITING 60 sec")
          sleep(60)
          output("New Round")
          telegram.msg('Webpage_Bot', 'New Round!')
        end
      end
      
      output("WAITING 5 sec")
      sleep(5)
    end
  end
end