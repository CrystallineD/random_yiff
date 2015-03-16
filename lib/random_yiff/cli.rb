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
  end
end
