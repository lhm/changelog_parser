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

end
