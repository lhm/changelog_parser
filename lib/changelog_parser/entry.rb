module ChangelogParser

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

end
