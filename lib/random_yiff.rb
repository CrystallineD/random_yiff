require "net/http"
require "random_yiff/version"

class RandomYiff
  def self.post_uri
    res = Net::HTTP.get_response(URI("https://e621.net/post/random"))
    URI(res['location'])
  end
end
