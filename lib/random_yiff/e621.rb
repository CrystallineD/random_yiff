require 'json'
require 'net/http'

module RandomYiff
  class E621
    def self.post_uri
      res = Net::HTTP.get_response(URI('https://e621.net/post/random'))
      URI(res['location'] + '?format=json')
    end

    attr_reader :post_uri, :post

    def initialize
      @post_uri = self.class.post_uri
      @post = JSON.load(Net::HTTP.get(post_uri))
      yield self if block_given?
    end

    def file_uri
      URI(file_url)
    end

    def file_name
      "#{md5}.#{file_ext}"
    end

    def file
      Net::HTTP.get(file_uri)
    end

    def method_missing(m, *args, &block)
      post["#{m}"] || super(m, *args, &block)
    end
  end
end
