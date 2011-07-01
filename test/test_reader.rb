require 'helper'

class TestFormat < CP::Formats::Format
end

class TestReader < MiniTest::Unit::TestCase

  def test_initialize_signature
    assert_raises(ArgumentError) { CP::Reader.new }
  end

  def test_changelog_accessor
    reader = CP::Reader.new("some string")
    assert_equal "some string", reader.changelog
  end

  def test_read
    stub(File).read {"some string"}
    mock(CP::Reader).new("some string", CP::Formats::Default)
    CP::Reader.read "/path/to/file"
  end

  def test_entries
    def TestFormat.section_start; /^(?=\={2})/; end;
    reader = CP::Reader.new "== version 0.1.1\n\n== version 0.1.2\n\n", TestFormat
    assert_equal 2, reader.entries.size
    assert_equal "== version 0.1.1\n\n", reader.entries.first.text
    assert_equal "== version 0.1.2\n\n", reader.entries.last.text
  end

end
