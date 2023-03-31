require_relative "../test_helper"

class TestReversible < Minitest::Test
  def test_new
    Reversible.new("face\nback\ny".lines)
    Reversible.new("face\nback\nn".lines)
    assert_raises(ArgumentError) { Reversible.new("face\nback".lines) }
    assert_raises(ArgumentError) { Reversible.new("face {{c1::}}\nback\ny".lines) }    
  end
end
