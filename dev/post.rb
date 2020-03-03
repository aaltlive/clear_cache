require 'net/http'

# url = 'one'

url = [
  'ITS NOT REF',
  'https://advermedia.ua/',
  'https://vk.com/',
  'https://twitter.com/',
  'https://core.telegram.org/',
  'https://zeus.rnds.pro/',
  '1234213213',
  'fadsasd',
  'http://sinatrarb.com/',
  'https://ru.wikipedia.org/',
]

uri = URI('http://localhost:4567/clearcache')
res = Net::HTTP.post_form(uri, 'url[]' => url)
puts res.body

# id = 'https://vk.com/'

# uri = URI('http://graph.facebook.com/')
# res = Net::HTTP.post_form(uri, 'id' => id, 'scrape' => true)
# puts res.body