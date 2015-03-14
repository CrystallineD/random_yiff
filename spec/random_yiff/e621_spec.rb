require 'spec_helper'

describe RandomYiff::E621 do
  include_context :e621
  subject(:yiff) { RandomYiff::E621.new }

  describe '.post_uri' do
    it 'Returns a uri object for a random e621 post' do
      RandomYiff::E621.post_uri
      expect(WebMock).to have_requested(:get, e621_random_route)
    end
  end

  describe '#post_uri' do
    it 'Returns a uri object for a random e621 post' do
      expect(yiff.post_uri).to eq(URI(e621_post_url))
    end
  end

  describe '#post' do
    it 'Returns a json object for a random post from e621' do
      expect(yiff.post).to eq(e621_post_json)
    end
  end

  describe '#file_uri' do
    it 'Returns a uri object for a random furry pr0n file' do
      expect(yiff.file_uri).to eq(URI(e621_image_url))
    end
  end

  describe '#file' do
    it 'Download random furry pr0n file' do
      yiff.file
      expect(WebMock).to have_requested(:get, e621_image_url)
    end
  end

  describe '#file_name' do
    it 'Returns the file name' do
      expect(yiff.file_name).to eq(e621_image_name)
    end
  end

  describe '#initialize' do
    it 'yields self if block given' do
      expect { |b| RandomYiff::E621.new(&b) }
        .to yield_with_args(RandomYiff::E621)
    end
  end

  describe '#not_a_method' do
    it 'Raises NoMethodError' do
      expect { yiff.not_a_method }.to raise_error(NoMethodError)
    end
  end
end
