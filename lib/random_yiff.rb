require "net/http"
require "json"

require "random_yiff/version"

class RandomYiff

  attr_reader :post_uri

  def initialize
    @post_uri = RandomYiff.post_uri
  end

  def post
    JSON.load(Net::HTTP.get(post_uri))
  end

  def file_uri
    URI(post['file_url'])
  end

  def file
    Net::HTTP.get(file_uri)
  end

  def self.post_uri
    res = Net::HTTP.get_response(URI("https://e621.net/post/random"))
    URI(res['location'] + '?format=json')
  end

end
