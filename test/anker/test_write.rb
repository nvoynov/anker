require_relative "../test_helper"

class Write
  public_class_method :new
  public :write
end

class TestWrite < Minitest::Test
  def subject
    Write.new
  end

  def test_write

  end

  def test_call
    notes = Parse.("./test/proper.anki")
    Sandbox.() {
      capture_io { Write.("proper", notes) }
      assert_equal 3, Dir.glob('*.csv').size
      # Dir.glob('*.csv').each{|file|
      #   puts "\n --- #{file}"
      #   puts File.read(file)
      # }
    }
  end
end
