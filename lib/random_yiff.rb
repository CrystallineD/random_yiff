require "net/http"
require "json"

require "random_yiff/version"

class RandomYiff
  class << self
    def post
      JSON.load(Net::HTTP.get(post_uri))
    end

    def file_uri
      URI(post['file_url'])
    end

    def file
      Net::HTTP.get(file_uri)
    end

    def post_uri
      res = Net::HTTP.get_response(URI("https://e621.net/post/random"))
      URI(res['location'] + '?format=json')
    end
  end
end
