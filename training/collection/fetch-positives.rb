require 'rubygems'
require 'open-uri'
require 'flickraw'

FlickRaw.api_key="0cc11cffc8a238efef4dfa6dca255a44"
FlickRaw.shared_secret="5f76a97053f99673"

$fetched = Hash.new

$dir = ARGV[0]

def getPage(page)
  args = {}
  args[:tag] = 'animal,portrait'
  args[:tag_mode] = 'any'
  args[:per_page] = 500
  args[:page] = page
  list = flickr.photos.getRecent args

  list.each do |photo|
    url = "http://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}.jpg"

    if $fetched[url] != 1
      $fetched[url] = 1

      name = rand(1000000000000000)

      file = "#{$dir}/#{name}.jpg"

      open(file, 'wb') do |file|
        begin 
          puts "Fetching #{url}"
          file << open(url).read
        rescue
          puts "Error fetching #{url}" 
        end
      end
    end
  end
end

# gets 120 x 500 = 60,000 images
120.times do |i|
  getPage(i)
end
