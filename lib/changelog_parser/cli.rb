require 'slop'

module ChangelogParser

  class CLI

    def initialize
      opts = Slop.new :help => true do
        on :n, :number,  'number of entries to print', true, :as => Integer, :default => 1
      end

      @filename = extract_args(opts).first
      @opts     = opts.to_hash
      @reader   = ChangelogParser::Reader.new(get_text)
    end

    def run
      entries = @reader.entries[0..@opts['number']-1]
      puts entries.map(&:text).join("\n")
    end

    def get_text
      if @filename.nil?
        STDIN.gets(nil)
      else
        File.read(@filename)
      end
    end

    def extract_args(opts)
      args = []
      opts.parse {|arg| args << arg}
      args
    end

  end

end
