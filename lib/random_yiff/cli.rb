require 'thor'
require 'launchy'
require 'asciiart'

module RandomYiff
  class Cli < Thor
    desc 'open', 'Default action, open furry pr0n in webbrowser'
    def open
      RandomYiff::E621.new do |yiff|
        Launchy.open(yiff.file_url)
      end
    end

    desc 'ascii', 'Print furry pr0n as ascii'
    def ascii
      while yiff = RandomYiff::E621.new
        break unless yiff.file_ext == 'flv'
      end
      puts AsciiArt.new(yiff.file_url).to_ascii_art(color: true, width: 160)
    end

    desc 'download', 'Download furry pr0n'
    def download
      RandomYiff::E621.new do |yiff|
        File.open("./#{yiff.file_name}", 'w') do |f|
          f.write(yiff.file)
        end
      end
    end

    default_task :open
  end
end
