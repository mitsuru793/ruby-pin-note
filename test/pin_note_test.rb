require "test_helper"

class PinNoteTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PinNote::VERSION
  end
end
