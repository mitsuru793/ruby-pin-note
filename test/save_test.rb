require "test_helper"

class SaveTest < Minitest::Test
  def test_save_word
    home = File.expand_path('~')

    config_path = File.join(home, '.pin-note.yml')
    now = Time.now

    Time.stub :now, now do
      PinNote::Cli.start(%w[save Hello world!])
    end

    expected = [
        {
            id: 1,
            note: 'Hello world!',
            category: nil,
            created_at: now.to_s,
        }
    ]
    assert_equal(expected, YAML.load_file(config_path))
  end
end