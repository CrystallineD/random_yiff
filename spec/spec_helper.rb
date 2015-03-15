require 'coveralls'
Coveralls.wear!

require 'rspec'
require 'webmock/rspec'
require 'random_yiff'

RSpec.shared_context :e621 do
  let(:e621_random_route) do
    'https://e621.net/post/random'
  end

  let(:e621_post_response) do
    File.read('spec/fixtures/random_post_response.txt')
  end

  let(:e621_post_raw) do
    File.read('spec/fixtures/random_post.txt')
  end

  let(:e621_post_json) do
    JSON.load(File.read('spec/fixtures/random_post.json'))
  end

  let(:e621_post_url) do
    'https://e621.net/post/show/141529/azazial-breasts-cellphone-claws-clothed-clothing-f?format=json'
  end

  let(:e621_image_url) do
    'https://static1.e621.net/data/d7/74/d7745463ef599bb21702fd173c103d41.jpg'
  end

  let(:e621_image_name) do
    'd7745463ef599bb21702fd173c103d41.jpg'
  end

  before do
    stub_request(:get, e621_random_route).to_return(e621_post_response)
    stub_request(:get, e621_post_url).to_return(e621_post_raw)
    stub_request(:get, e621_image_url).to_return(body: 'yiff')
  end
end
