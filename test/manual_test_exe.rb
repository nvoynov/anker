require_relative "test_helper"

class TestExe < Minitest::Test
  def test_help
    out, _ = capture_subprocess_io {
      system "bundle exec ruby exe/anker"
    }
    assert_match "Anker", out
  end

  def test_anker
    sample = File.read("./test/proper.anki")
    Sandbox.() {
      File.write("sample.anki", sample)
      system "anker sample.anki"
      assert File.exist? "sample.basic.csv"
      assert File.exist? "sample.cloze.csv"
      assert File.exist? "sample.rever.csv"
    }
  end
end
