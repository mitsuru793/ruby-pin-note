require "test_helper"

class ListTest < PinNoteUnitTest
  def setup
    super
    run_command(%w[save --category c1 c1-1])
    run_command(%w[save --category c1 c1-2])
    run_command(%w[save 1])
    run_command(%w[save 2])
  end

  def test_list_notes
    date = @now.strftime('%Y-%m-%d %H:%M:%S')
    expected = <<~EOF
    [#{date}] c1: c1-1
    [#{date}] c1: c1-2
    [#{date}] 1
    [#{date}] 2
    EOF

    output = capture { run_command(%w[list]) }
    assert_equal(expected, output)
  end

  def test_list_notes_of_the_category
    date = @now.strftime('%Y-%m-%d %H:%M:%S')
    expected = <<~EOF
    [#{date}] c1: c1-1
    [#{date}] c1: c1-2
    EOF

    output = capture { run_command(%w[list --category c1]) }
    assert_equal(expected, output)
  end

  def test_list_notes_of_the_empty_category
    date = @now.strftime('%Y-%m-%d %H:%M:%S')
    expected = <<~EOF
    [#{date}] 1
    [#{date}] 2
    EOF

    output = capture { run_command(%w[list --category _]) }
    assert_equal(expected, output)
  end
end