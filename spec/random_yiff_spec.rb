require 'spec_helper'

describe RandomYiff do
  random_post_response = File.read("spec/fixtures/random_post_response.txt")
  random_post_raw = File.read("spec/fixtures/random_post.txt")
  random_post_json = JSON.load(File.read("spec/fixtures/random_post.json"))
  random_post_uri = "https://e621.net/post/show/141529/azazial-breasts-cellphone-claws-clothed-clothing-f?format=json"

  subject(:yiff) { RandomYiff.new }

  before do
    stub_request(:get, "https://e621.net/post/random").to_return(random_post_response)
    stub_request(:get, random_post_uri).to_return(random_post_raw)
  end

  describe "#post_uri" do
    it "Returns the uri of a random e621 post" do
      expect(yiff.send(:post_uri)).to eq(URI(random_post_uri))
    end
  end

  describe "#post" do
    it "Returns json for a random post from e621" do
      expect(yiff.post).to eq(random_post_json)
    end
  end

end
