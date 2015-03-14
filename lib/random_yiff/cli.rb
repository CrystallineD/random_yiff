require 'thor'
require 'launchy'

require 'random_yiff/e621'

module RandomYiff
  class Cli < Thor
    desc 'open', 'Open furry pr0n in browser'
    def open
      RandomYiff::E621.new do |yiff|
        Launchy.open(yiff.file_url)
      end
    end
    default_task :open
  end
end
