require 'bundler' 
Bundler.require(:default) 

EM.run do
  telegram = Telegram::Client.new do |cfg, auth|
    cfg.daemon = './tg/bin/telegram-cli'
    cfg.key = './tg/tg-server.pub'
  end

  telegram.connect do

    puts telegram.profile

    message = "hello"
  
    while true
      message = get_message()
      telegram.msg('Webpage_Bot', message) do |success, data|
        puts success # => true
        puts data # => {"event": "message", "out": true, ...}
      end
    end

    telegram.on_disconnect = Proc.new do
      puts 'Connection with telegram-cli is closed'
    end

  end

end