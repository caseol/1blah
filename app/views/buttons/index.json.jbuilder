json.blahs @buttons do |json, b|
   json.blah b.attributes
   json.url b.media.url
   json.count b.count.value
end