require "test_helper"

class ListTest < PinNoteUnitTest
  def test_list
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
end