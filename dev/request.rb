require_relative 'server'
require_relative 'tg_server'
require_relative 'clearcache'

def request()
  urls = []

  while urls.uniq.length != 10
    if u=REDIS.lpop('all_urls') then urls.append(u) else break end
  end

  mes = ""

  for u in urls.uniq
    mes += u + "\n"
    begin
      # vk(u)
      # twitter(u)
      # facebook(u)
    rescue
    end
  end

  

end

# while true
#   request()
#   sleep(5)
# end

request() # developer_mode