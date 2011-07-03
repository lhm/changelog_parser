require 'slop'

module ChangelogParser

  class Runner

    def initialize
    end

    def run(args=ARGV)
      filename, opts = parse_options(args)
      reader  = ChangelogParser::Reader.new get_text(filename)
      entries = reader.entries[0..opts['number']-1]
      puts entries.map(&:text).join("")
    end

    def parse_options(args)
      opts = Slop.new :help => true do
        on :n, :number,  'number of entries to print', true, :as => Integer, :default => 1
      end
      filenames = []
      opts.parse(args) {|arg| filenames << arg}
      [filenames.first, opts.to_hash]
    end

    def get_text(filename)
      if filename.nil?
        STDIN.gets(nil)
      else
        File.read(filename)
      end
    end

  end

end
