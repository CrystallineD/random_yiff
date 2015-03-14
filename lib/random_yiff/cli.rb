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
      yiff = random_image
      puts AsciiArt.new(yiff.file_url).to_ascii_art(color: true, width: 160)
    end

    desc 'download', 'Download furry pr0n'

    method_option :path,
                  desc: 'path of directory to download furry pr0n into',
                  type: :string,
                  default: Dir.pwd

    def download
      RandomYiff::E621.new do |yiff|
        path = File.join(options[:path], yiff.file_name)
        File.open(path, 'w') do |f|
          f.write(yiff.file)
        end
      end
    end

    default_task :open

    private

    class NotAnImage < StandardError; end

    def random_image
      RandomYiff::E621.new do |yiff|
        fail NotAnImage if yiff.file_ext == 'flv'
      end
    rescue NotAnImage
      random_image
    end
  end
end
