require "test_helper"

class SaveTest < PinNoteUnitTest
  def test_save_word_without_category
    saved = run_command(%w[save Hello world!])

    expected = [
        {
            id: 1,
            note: 'Hello world!',
            category: nil,
            created_at: @now,
        }
    ]
    assert_equal(expected, saved)
  end

  def test_save_word_with_category
    saved = run_command(%w[save --category greet Hello world!])

    expected = [
        {
            id: 1,
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
    assert_equal('cate', saved[0][:category])

    ENV.delete('PIN_NOTE_CATEGORY')
    saved = run_command(%w[save note])
    assert_nil(saved[0][:category])
  end
end