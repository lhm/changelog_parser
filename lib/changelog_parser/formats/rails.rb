module ChangelogParser
  module Formats
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
        /\(.+\)/
      end

    end
  end
end

