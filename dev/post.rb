require 'net/http'

# url = 'one'

url = [
  '1',
  '2',
  '3'
]

uri = URI('http://localhost:4567/clearcache')
res = Net::HTTP.post_form(uri, 'url[]' => url)
puts res.body