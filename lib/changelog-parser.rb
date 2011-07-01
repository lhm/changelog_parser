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

    def versions
      @versions ||= @changelog.split(@format.section_start).map {|section| Version.new(section, @format)}
    end

  end


  class Version

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

    def number
      @number ||= headline[@format.number]
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

      RE_SEMVER = /\d+.\d+.\d/

      def self.section_start;  raise NotImplementedError; end
      def self.line_seperator; raise NotImplementedError; end
      def self.headline;       raise NotImplementedError; end
      def self.number;         raise NotImplementedError; end
      def self.release_date;   raise NotImplementedError; end
    end

    class Default < Format

      def self.section_start
        /^(?=\={1,3}.+#{self.number})/
      end

      def self.line_seperator
        /\n(?:\s)?/
      end

      def self.headline
        /#{self.section_start}.+$/
      end

      def self.number
        RE_SEMVER
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

      def self.number
        RE_SEMVER
      end

      def self.release_date
        nil
      end

    end


  end

end
