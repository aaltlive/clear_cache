require 'net/http'

uri = URI('http://localhost:4567/clearcache')
res = Net::HTTP.post_form(uri, 'url' => 'its post')
puts res.body