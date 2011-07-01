require 'date'

module ChangelogParser

  class Reader

    attr_accessor :changelog

    def initialize(changelog_string, format)
      @changelog = changelog_string
      @format    = format
    end

    def self.read(path, format)
      self.new(File.read(path), format)
    end

    def releases
      @releases ||= @changelog.split(@format.section_start).map {|section| Release.new(section, @format)}
    end

  end


  class Release

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
      @version ||= headline[@format.version]
    end

    def release_date
      @release_date ||= if @format.release_date
                         headline[@format.release_date]
                        else
                          begin
                            Date.parse(headline)
                          rescue ArgumentError # date unparseable
                            nil
                          end
                        end
    end

  end

  module Formats

    class Format

      RE_GEM_VERSION = /#{Gem::Version::VERSION_PATTERN}/   # '[0-9]+(\.[0-9a-zA-Z]+)*'

      def self.section_start;  raise NotImplementedError; end
      def self.line_seperator; raise NotImplementedError; end
      def self.headline;       raise NotImplementedError; end
      def self.version;        raise NotImplementedError; end
      def self.release_date;   raise NotImplementedError; end
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

      def self.release_date
        nil
      end

    end

    class Rails < Format

      def self.section_start
        /^(?=\*(?:Rails|#{self.number}))/
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

      def self.release_date
        nil
      end

    end


  end

end
