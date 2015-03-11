require 'spec_helper'

describe RandomYiff do
  let(:e621_post_random) { File.new("spec/fixtures/e621_post_random_output.txt") }

  describe ".post_uri" do
    it "Returns the uri of a random furry post" do
      stub_request(:get, "https://e621.net/post/random").to_return(e621_post_random)
      expect(RandomYiff.post_uri).
        to eq(URI("https://e621.net/post/show/141529/azazial-breasts-cellphone-claws-clothed-clothing-f"))
    end
  end

end
