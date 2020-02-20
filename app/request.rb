require_relative 'server' # for redis
require_relative 'clearcache' # for clear function

def request()
  urls = []

  while urls.uniq.length != 10
    if u=REDIS.lpop('all_urls') then urls.append(u) else break end
  end

  for u in urls.uniq
    begin
      vk(u)
      # telegram(u)
      # twitter(u)
      # facebook(u)
    rescue
    end
  end

end

request() # developer mode

# while true
#   request()
#   sleep(5)
# end