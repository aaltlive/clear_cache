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
    # vk_clear(i) # удалить это, нужен чтобы чистить "застрявшие" ссылки
    # REDIS.rpush('all_urls', i) if not vk_clear(i)
  end

end

do_request()

# URI::InvalidURIError at /clearcache
# URI must be ascii only "https://api.vk.com/method/pages.clearCache?url=aaasdad\u0432\u0444\u044B\u0432
# 
# Если запрос не удался, то вернуть ссылку в очередь. Делать так ограниченное кол-во раз

# Задачи:
# 1. Принимать несколько ссылок (в каком виде будет поступать массив ссылок?)
# 2. Ограниченние на возврат в очередь в случае ошибки обновления кеша
# 3. Ошибка при попытке обновить кеш у ссылки не из аскей символов
# 4. 