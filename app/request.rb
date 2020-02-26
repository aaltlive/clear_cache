require_relative 'server' # for redis
require_relative 'clearcache' # for clear function

def request()
  urls = []

  while urls.uniq.length != 10
    if u=REDIS.lpop('all_urls') then urls.append(u) else break end
  end

  telegram(urls)

  for u in urls.uniq
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