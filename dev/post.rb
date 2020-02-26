require 'net/http'

# url = 'one'

url = [
  '1',
  '2',
  '3',
  'https://advermedia.ua/',
  '5',
  'https://vk.com/',
  'https://twitter.com/',
  '_',
  '8',
  '9',
  '10',
  '11',
  '12'
]

uri = URI('http://localhost:4567/clearcache')
res = Net::HTTP.post_form(uri, 'url[]' => url)
puts res.body