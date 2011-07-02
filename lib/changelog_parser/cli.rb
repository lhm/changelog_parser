require 'slop'

module ChangelogParser

  class CLI

    attr_reader :opts, :reader

    def initialize
      opts = Slop.new :help => true do
        on :n, :number,  'number of entries to print', true, :as => Integer, :default => 1
        on :f, :file,    'path to the changelog file to parse; defaults to STDIN if not given', true
        # on :f, :format,  'specify format of changelog for parsing; currently supported: default, rails.'
      end

      @opts = opts.parse.to_hash

      @reader = ChangelogParser::Reader.new(get_text)

    end

    def run
      entries = reader.entries[0..n-1]
      puts entries.map(&:text).join('\n')
    end

    def get_text
      if opts['file'].nil?
        STDIN.gets(nil)
      else
        File.read(opts['file'])
      end
    end

  end

end
