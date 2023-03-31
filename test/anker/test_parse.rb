require_relative "../test_helper"
require "stringio"

class Parse
  public_class_method :new
  public :note, :read
end

class TestParse < Minitest::Test

  def subject
    Parse.new
  end

  def test_note
    par = subject
    assert_kind_of Basic, par.note(%w[face])
    assert_kind_of Basic, par.note(%w[face back])
    assert_kind_of Reversible, par.note(%w[face back y])
  end

  def test_read
    src = "./test/proper.anki"
    ary = []
    par = subject
    File.open(src){|f| par.read(f){|lines| ary << lines} }
    assert_equal 6, ary.size

    src = "./test/faulty.anki"
    ary = []
    par = subject
    assert_raises(Anker::Parse::Failure) {
      File.open(src){|f|
        par.read(f){|lines| ary << par.note(lines)}
      }
    }
  end

  def test_call
    notes = Parse.("./test/proper.anki")
    assert_equal 6, notes.size
    notes.each{ assert_kind_of Basic, _1 }
    assert_raises(Anker::Parse::Failure) {
      Parse.("./test/faulty.anki")
    }
  end

end
