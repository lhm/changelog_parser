require 'helper'

class TestRails < MiniTest::Unit::TestCase

  def setup
    @text = <<-EOS
*Rails 3.1.0 (unreleased)*

* some new feature

*Rails 3.0.7 (April 18, 2011)*

* some bugfix xxx

*Rails 3.0.6 (April 5, 2011)*

* minor change yyy

    EOS

    @reader = CP::Reader.new(@text, CP::Formats::Rails)
  end

  def test_entry_split
    assert_equal 3, @reader.entries.count
  end

  def test_version
    assert_equal ["3.1.0", "3.0.7", "3.0.6"], @reader.entries.map(&:version).map(&:to_s)
  end

  def test_date
    assert_equal Date.civil(2011, 4, 5), @reader.entries.last.date
  end

  def test_text
    expected = "*Rails 3.0.6 (April 5, 2011)*\n\n* minor change yyy\n\n"
    assert_equal expected, @reader.entries.last.text
  end


end
