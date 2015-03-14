require 'thor'
require 'launchy'

module RandomYiff
  class Cli < Thor
    desc 'open', 'Default action, open furry pr0n in webbrowser'
    def open
      RandomYiff::E621.new do |yiff|
        Launchy.open(yiff.file_url)
      end
    end
    default_task :open
  end
end
