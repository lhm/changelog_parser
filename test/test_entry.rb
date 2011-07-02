require 'helper'

class TestEntry < MiniTest::Unit::TestCase

  def mock_format(opts={})
    format = Object.new
    opts.each_pair do |meth, regex|
      mock(format, meth.to_sym).returns { regex.nil? ? nil : Regexp.new(regex) }
    end
    format
  end

  def test_initialize
    entry = CP::Entry.new("some string", CP::Formats::Default)
    assert_equal "some string", entry.text
  end

  def test_headline
    format = mock_format :headline => '^(?=\={2}).+'
    text   = "== 2.1.3\n\n  * some more text\n"
    entry  = CP::Entry.new(text, format)
    assert_equal "== 2.1.3", entry.headline
  end

  def test_version
    format = mock_format :version => /#{Gem::Version::VERSION_PATTERN}/
    entry  = CP::Entry.new("some text", format)
    stub(entry).headline {"== 1.2.3 / 2011-11-21" }
    version = entry.version
    assert_kind_of Gem::Version, version
    assert_equal "1.2.3", version.to_s
  end

  def test_date_without_regex
    format = mock_format :date => nil
    entry  = CP::Entry.new("some text", format)
    stub(entry).headline {"== 1.2.3 / 2011-11-21"}
    date = entry.date
    assert_kind_of Date, date
    assert_equal Date.civil(2011, 11, 21), date
  end

  def test_date_with_regex
    format = Object.new
    mock(format).date.twice { /\(.+\)/}
    entry  = CP::Entry.new("some text", format)
    stub(entry).headline {"== 1.2.3 (2011-11-21)"}
    date = entry.date
    assert_kind_of Date, date
    assert_equal Date.civil(2011, 11, 21), date
  end

  def test_comparable
    old_entry, new_entry = Array.new(2) { CP::Entry.new("some text", mock_format) }
    stub(old_entry).version { Gem::Version.create("0.9.8") }
    stub(new_entry).version { Gem::Version.create("1.3.4") }
    assert (new_entry > old_entry)
    assert_equal [old_entry, new_entry], [new_entry, old_entry].sort
  end

end
