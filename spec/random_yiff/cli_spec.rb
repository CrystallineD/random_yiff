require 'spec_helper'
require 'random_yiff/cli'

$0 = 'yiff'
ARGV.clear

describe RandomYiff::Cli do
  include_context :e621

  let(:launchy) { double(Launchy) }

  describe '#open' do
    it 'opens random furry pr0n via Launchy' do
      allow(Launchy).to receive(:open).with(e621_image_url)
      RandomYiff::Cli.start
      expect(Launchy).to have_received(:open).with(e621_image_url)
    end
  end
end
