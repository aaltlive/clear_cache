require_relative 'server'
require_relative 'clearcache'

def do_request()
  urls = []

  while urls.uniq.length != 10
    if u=REDIS.lpop('all_urls')
      urls.append(u)
    else
      break
    end
  end

  for u in urls.uniq
    begin
      vk_clear_cash(u)
    rescue
    end
  end

end

do_request() # developer mode

# while 1
#   do_request()
#   sleep(5)
# end