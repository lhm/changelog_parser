require 'date'

module ChangelogParser

  RE_SECTION_START = /^(?=\={3})/
  RE_HEADLINE      = /#{RE_SECTION_START}.+$/
  RE_LINE_SEP      = /\n(?:\s*)?/
  RE_SEMVER        = /\d+.\d+.\d/

  class Reader

    attr_accessor :changelog

    def initialize(changelog_string)
      @changelog = changelog_string
    end

    def self.read(path)
      self.new(File.read(path))
    end

    def versions
      @versions ||= @changelog.split(RE_SECTION_START).map {|section| Version.new(section)}
    end

  end


  class Version

    attr_accessor :text

    def initialize(section_string)
      @text = section_string
    end

    def lines
      @lines ||= @text.split(RE_LINE_SEP)
    end

    def headline
      @headline ||= @text[RE_HEADLINE]
    end

    def number
      @number ||= lines.first[RE_SEMVER]
    end

    def release_date
      @release_date ||= Date.parse(headline)
    end

  end

end
