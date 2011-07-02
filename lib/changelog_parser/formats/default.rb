module ChangelogParser
  module Formats
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
  end
end
