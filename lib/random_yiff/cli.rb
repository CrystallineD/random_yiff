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

    method_option :width,
                  desc: 'width to limit ascii to',
                  type: :numeric,
                  default: nil

    def ascii
      yiff = random_image
      ascii_opts = { color: true }
      ascii_opts.merge!(width: options[:width]) if options[:width]
      puts AsciiArt.new(yiff.file_url).to_ascii_art(ascii_opts)
    end

    desc 'download', 'Download furry pr0n'

    method_option :path,
                  desc: 'path of directory to download furry pr0n into',
                  type: :string,
                  default: './'

    def download
      RandomYiff::E621.new do |yiff|
        path = File.join(options[:path], yiff.file_name)
        File.write(path, yiff.file)
      end
    end

    default_task :open

    private

    class NotAnImage < StandardError; end

    def random_image
      RandomYiff::E621.new do |yiff|
        fail NotAnImage if non_image_formats.include?(yiff.file_ext)
      end
    rescue NotAnImage
      random_image
    end

    def non_image_formats
      ['flv']
    end
  end
end
