module ChangelogParser

  module Formats

    class Format

      RE_GEM_VERSION = /#{Gem::Version::VERSION_PATTERN}/   # '[0-9]+(\.[0-9a-zA-Z]+)*'

      def self.section_start;  raise NotImplementedError; end
      def self.headline;       raise NotImplementedError; end
      def self.version;        raise NotImplementedError; end
      def self.date;           raise NotImplementedError; end
    end

    class Default < Format

      def self.section_start
        /^(?=\={1,3}.+#{self.version})/
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
