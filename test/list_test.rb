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

    output = capture { run_command(%w[list --categories c1]) }
    assert_equal(expected, output)
  end

  def test_list_notes_of_the_empty_category
    date = @now.strftime('%Y-%m-%d %H:%M:%S')
    expected = <<~EOF
    [#{date}] 1
    [#{date}] 2
    EOF

    output = capture { run_command(%w[list --categories _]) }
    assert_equal(expected, output)
  end

  def test_list_notes_of_some_categories
    run_command(%w[save --category c2 c2-1])
    run_command(%w[save --category c3 c3-1])

    date = @now.strftime('%Y-%m-%d %H:%M:%S')
    expected = <<~EOF
    [#{date}] c2: c2-1
    [#{date}] c3: c3-1
    EOF

    output = capture { run_command(%w[list --categories c2 c3]) }
    assert_equal(expected, output)
  end

  def test_list_notes_as_json_filtering_category
    run_command(%w[save --category c2 c2-1])
    run_command(%w[save --category c3 c3-1])

    date = @now.strftime('%Y-%m-%d %H:%M:%S %z')
    expected = JSON.generate([
        {
            note: 'c2-1',
            category: 'c2',
            created_at: date,
        },
        {
            note: 'c3-1',
            category: 'c3',
            created_at: date,
        },
    ]) + "\n"

    output = capture { run_command(%w[list --categories c2 c3 --format json]) }
    assert_equal(expected, output)
  end
end