require "net/http"
require "random_yiff/version"

class RandomYiff

  attr_reader :post

  def initialize
    @post = JSON.load(Net::HTTP.get(post_uri))
  end

  def file_uri
    URI(post['file_url'])
  end

  def image
    Net::HTTP.get(file_uri)
  end

  private

  def post_uri
    res = Net::HTTP.get_response(URI("https://e621.net/post/random"))
    URI(res['location'] + '?format=json')
  end
end
