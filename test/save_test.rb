require "test_helper"

class SaveTest < PinNoteUnitTest
  def test_save_without_note
    skip
    assert_raises Thor::Error do
      run_command(%w[save])
    end
  end

  def test_save_to_loaded
    run_command(%w[save yeah])
    saved = run_command(%w[save --category greet hello])

    expected = [
        {
            note: 'yeah',
            category: 'inbox',
            created_at: @now,
        },
        {
            note: 'hello',
            category: 'greet',
            created_at: @now,
        }
    ]

    assert_equal(expected, saved)
  end

  def test_save_word_without_category
    saved = run_command(%w[save Hello world!])

    expected = [
        {
            note: 'Hello world!',
            category: 'inbox',
            created_at: @now,
        }
    ]
    assert_equal(expected, saved)
  end

  def test_save_word_with_category
    saved = run_command(%w[save --category greet Hello world!])

    expected = [
        {
            note: 'Hello world!',
            category: 'greet',
            created_at: @now,
        }
    ]
    assert_equal(expected, saved)
  end

  def test_set_category_env
    ENV['PIN_NOTE_CATEGORY'] = 'default'

    saved = run_command(%w[save note])
    assert_equal('default', saved[0][:category])

    saved = run_command(%w[save --category cate note])
    assert_equal('cate', saved[1][:category])

    ENV.delete('PIN_NOTE_CATEGORY')
    saved = run_command(%w[save note])
    assert_equal('inbox', saved[2][:category])
  end
end