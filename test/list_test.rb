require "test_helper"

class ListTest < PinNoteUnitTest
  def test_list_notes
    run_command(%w[save --category greet Hello])
    run_command(%w[save --category greet Hi])
    run_command(%w[save Man])
    run_command(%w[save Woman])

    date = @now.strftime('%Y-%m-%d %H:%M:%S')
    expected = <<~EOF
    [#{date}] greet: Hello
    [#{date}] greet: Hi
    [#{date}] Man
    [#{date}] Woman
    EOF

    output = capture { run_command(%w[list]) }
    assert_equal(expected, output)
  end

  def test_list_notes_of_the_category
    run_command(%w[save --category greet Hello])
    run_command(%w[save --category greet Hi])
    run_command(%w[save Man])

    date = @now.strftime('%Y-%m-%d %H:%M:%S')
    expected = <<~EOF
    [#{date}] greet: Hello
    [#{date}] greet: Hi
    EOF

    output = capture { run_command(%w[list --category greet]) }
    assert_equal(expected, output)
  end

  def test_list_notes_of_the_empty_category
    run_command(%w[save --category greet Hi])
    run_command(%w[save Man])
    run_command(%w[save Woman])

    date = @now.strftime('%Y-%m-%d %H:%M:%S')
    expected = <<~EOF
    [#{date}] Man
    [#{date}] Woman
    EOF

    output = capture { run_command(%w[list --category _]) }
    assert_equal(expected, output)
  end
end