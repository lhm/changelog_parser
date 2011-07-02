module ChangelogParser
  module Formats
    class Format

      RE_GEM_VERSION = /#{Gem::Version::VERSION_PATTERN}/   # '[0-9]+(\.[0-9a-zA-Z]+)*'

      def self.section_start;  raise NotImplementedError; end
      def self.headline;       raise NotImplementedError; end
      def self.version;        raise NotImplementedError; end
      def self.date;           raise NotImplementedError; end

    end
  end
end
