# When using Bundler, let it load all libraries
require 'bundler' 
Bundler.require(:default) 

# Otherwise, require 'telegram', which will load its dependencies
# require 'telegram'
require 'eventmachine'

EM.run do
  telegram = Telegram::Client.new do |cfg|
    cfg.daemon = './tg/bin/telegram-cli'
    cfg.key = './tg/tg-server.pub'
  end

  telegram.connect do
    puts telegram.profile
    telegram.contacts.each do |contact|
      puts contact
    end
    telegram.chats.each do |chat|
      puts chat
    end
    
    telegram.on[Telegram::EventType::RECEIVE_MESSAGE] = Proc.new { |ev|
      
    }

  end
end