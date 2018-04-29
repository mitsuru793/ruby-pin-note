require "test_helper"

class SaveTest < Minitest::Test
  def setup
    @now = Time.new
  end

  def test_save_word_without_category
    saved = run_command(%w[save Hello world!])

    expected = [
        {
            id: 1,
            note: 'Hello world!',
            category: nil,
            created_at: @now.to_s,
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
            created_at: @now.to_s,
        }
    ]
    assert_equal(expected, saved)
  end

  private
  def run_command(args, config_path = '~/.pin-note.yml')
    saved = nil
    FakeFS do
      FileUtils.mkdir_p(File.expand_path('~'))

      Time.stub :now, @now do
        PinNote::Cli.start(args)
      end

      saved = YAML.load_file(File.expand_path(config_path))
    end
    saved
  end
end