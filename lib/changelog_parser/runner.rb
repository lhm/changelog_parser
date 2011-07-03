require 'slop'

module ChangelogParser

  class Runner

    def initialize
    end

    def run
      entries = reader.entries[0..@opts['number']-1]
      puts entries.map(&:text).join("\n")
    end

    def reader
      @reader ||= ChangelogParser::Reader.new(get_text)
    end

    def parse_options(args)
      opts = Slop.new :help => true do
        on :n, :number,  'number of entries to print', true, :as => Integer, :default => 1
      end
      filenames = []
      opts.parse {|arg| filenames << arg}
      @filename, @opts = [filenames.first, opts.to_hash]
    end

    def get_text
      if from_stdin?
        STDIN.gets(nil)
      else
        File.read(@filename)
      end
    end

    def from_stdin?
      @filename.nil?
    end

  end

end
