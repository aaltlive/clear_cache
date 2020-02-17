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

  for i in urls.uniq
    begin
      vk_clear(i)
    rescue
    end
  end

end

while 1
  do_request()
  sleep(5)
end