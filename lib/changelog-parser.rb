require 'date'

module ChangelogParser

  class Reader

    attr_accessor :changelog

    def initialize(changelog_string, format=ChangelogParser::Formats::Default)
      @changelog = changelog_string
      @format    = format
    end

    def self.read(path, format=ChangelogParser::Formats::Default)
      self.new(File.read(path), format)
    end

    def entries
      @entries ||= @changelog.split(@format.section_start).map {|section| Entry.new(section, @format)}
    end

  end


  class Entry

    include Comparable

    attr_accessor :text

    def initialize(section_string, format)
      @text   = section_string
      @format = format
    end

    def lines
      @lines ||= @text.split(@format.line_seperator)
    end

    def headline
      @headline ||= @text[@format.headline]
    end

    def version
      @version ||= Gem::Version.create(headline[@format.version])
    end

    def date
      @date ||= if @format.date
                          headline[@format.date]
                        else
                          begin
                            Date.parse(headline)
                          rescue ArgumentError # date unparseable
                            nil
                          end
                        end
    end

    def <=> other
      return unless ChangelogParser::Entry === other
      self.version.<=>(other.version)
    end

  end

  module Formats

    class Format

      RE_GEM_VERSION = /#{Gem::Version::VERSION_PATTERN}/   # '[0-9]+(\.[0-9a-zA-Z]+)*'

      def self.section_start;  raise NotImplementedError; end
      def self.line_seperator; raise NotImplementedError; end
      def self.headline;       raise NotImplementedError; end
      def self.version;        raise NotImplementedError; end
      def self.date;           raise NotImplementedError; end
    end

    class Default < Format

      def self.section_start
        /^(?=\={1,3}.+#{self.version})/
      end

      def self.line_seperator
        /\n(?:\s)?/
      end

      def self.headline
        /#{self.section_start}.+$/
      end

      def self.version
        RE_GEM_VERSION
      end

      def self.date
        nil
      end

    end

    class Rails < Format

      def self.section_start
        /^(?=\*(?:Rails|#{self.version}))/
      end

      def self.line_seperator
        /\n+(?=\*)/
      end

      def self.headline
        /#{self.section_start}.+$/
      end

      def self.version
        RE_GEM_VERSION
      end

      def self.date
        nil
      end

    end


  end

end
