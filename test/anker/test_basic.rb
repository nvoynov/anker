require_relative "../test_helper"

class Basic
  public :mkline, :mklist, :mkback
end

class TestBasic < Minitest::Test

  def test_mkline
    dummy = Basic.new([''])
    assert_equal "<p>face</p>", dummy.mkline("face")
    assert_equal "<p>face</br>field</p>", dummy.mkline("face | field")
  end

  def test_mklist
    dummy = Basic.new([''])
    lines = %w[first second]
    sample = "<ul><li>first</li><li>second</li></ul>"
    assert_equal sample, dummy.mklist(lines)
  end

  def test_new
    Basic.new(%w[face back])
    Basic.new(%w[face back back])
    Basic.new("face\nback\n- item 1\n- item 2".lines)
    Basic.new("face|field\nback|field".lines)
  end

  def test_cloze?
    refute Basic.new("face\nback".lines).cloze?
    assert Basic.new("{{c1::clozed::close}}\nback".lines).cloze?
  end

  def test_dummy
    sample = <<~EOF
      negligence | ˈneɡlɪdʒəns | noun
      the failure to give sb./sth. enough care or attention
      - The doctor was sued for medical negligence.
    EOF
    dummy = Basic.new(sample.lines)
    # puts <<~EOF
    #   #{dummy.face}
    #
    #   #{dummy.back}
    # EOF
  end
end
