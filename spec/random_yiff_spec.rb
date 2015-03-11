require 'spec_helper'

describe RandomYiff do
  random_post_response = File.read("spec/fixtures/random_post_response.txt")
  random_post_raw = File.read("spec/fixtures/random_post.txt")
  random_post_json = JSON.load(File.read("spec/fixtures/random_post.json"))
  random_post_url = "https://e621.net/post/show/141529/azazial-breasts-cellphone-claws-clothed-clothing-f?format=json"
  random_image_url = "https://static1.e621.net/data/d7/74/d7745463ef599bb21702fd173c103d41.jpg"
  subject(:yiff) { RandomYiff.new }

  before do
    stub_request(:get, "https://e621.net/post/random").to_return(random_post_response)
    stub_request(:get, random_post_url).to_return(random_post_raw)
    stub_request(:get, random_image_url).to_return(body: 'yiff yiff yiff')
  end

  describe ".post_uri" do
    it "Gets a random e621 post url" do
      RandomYiff.post_uri
      expect(WebMock).to have_requested(:get, "https://e621.net/post/random")
    end
  end

  describe "#post_uri" do
    it "Returns a uri object for a random e621 post" do
      expect(yiff.post_uri).to eq(URI(random_post_url))
    end
  end

  describe "#post" do
    it "Returns a json object for a random post from e621" do
      expect(yiff.post).to eq(random_post_json)
    end
  end

  describe "#file_uri" do
    it "Returns a uri object for a random furry pr0n file" do
      expect(yiff.file_uri).to eq(URI(random_image_url))
    end
  end

  describe "#file" do
    it "Download random furry pr0n" do
      yiff.file
      expect(WebMock).to have_requested(:get, random_image_url)
    end
  end

  describe "#initialize" do
    it "instance_evals blocks passed to it" do
      expect{ RandomYiff.new { print file_ext }}.to output('jpg').to_stdout
    end
  end

end
