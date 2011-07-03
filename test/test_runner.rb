require 'helper'
require 'changelog_parser/runner'

class TestRunner < MiniTest::Unit::TestCase

  def setup
    @runner = CP::Runner.new
  end

  def test_parse_options
    filename, options = @runner.parse_options %w(/foo/bar -n2)
    assert_equal "/foo/bar", filename
    assert_equal 2, options['number']

    filename, options = @runner.parse_options []
    assert_equal nil, filename
    assert_equal 1, options['number']
  end

  def test_get_text_from_stdin
    mock(STDIN).gets.with(nil) {"some text"}
    assert_equal "some text", @runner.get_text(nil)
  end

  def test_get_text_from_file
    mock(File).read.with('/some/file') {"some text"}
    assert_equal "some text", @runner.get_text("/some/file")
  end

  def test_run
    changelog =<<-EOS
== 0.0.1 / 2011-06-01

== 0.0.2 / 2011-06-03

    EOS
    argv = ["/some/file", "-n2"]
    stub(@runner).parse_options.with(argv) { ["/some/file", {"number" => 2}] }
    stub(@runner).get_text.with("/some/file") { changelog }

    assert_output(changelog) do
      @runner.run(argv)
    end
  end


end
