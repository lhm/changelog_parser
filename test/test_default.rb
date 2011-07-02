require 'helper'

class TestDefault < MiniTest::Unit::TestCase

  def setup
    @text = <<-EOS
=== 1.0.1 / 2011-06-01
  * minor bugfix #123

=== 1.0.0pre1 / 2011-05-01
  * prerelease 1

=== 0.9.8 / 2011-04-01
  * new feature xxx

    EOS

    @reader = CP::Reader.new(@text, CP::Formats::Default)
  end

  def test_entry_split
    assert_equal 3, @reader.entries.count
  end

  def test_version
    assert_equal ["1.0.1", "1.0.0pre1", "0.9.8"], @reader.entries.map(&:version).map(&:to_s)
  end

  def test_date
    assert_equal Date.civil(2011, 6, 1), @reader.entries.first.date
  end

  def test_text
    expected = "=== 0.9.8 / 2011-04-01\n  * new feature xxx\n\n"
    assert_equal expected, @reader.entries.last.text
  end

end
