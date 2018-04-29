require "thor"
require 'awesome_print'

module PinNote
  class Cli < Thor
    desc "save Here is note... #tag", "Save a note."
    option :category, aliases: :c, type: :string, desc: 'Save note on CATEGORY'

    def save(word, *words)
      words.unshift(word)

      note = Note.new(
          note: words.join(' '),
          category: options[:category] || ENV['PIN_NOTE_CATEGORY'] || nil,
          created_at: Time.now,
          )
      saved = load_saved
      saved.push(note.to_h)

      File.open(config_path, 'w') do |f|
        YAML.dump(saved, f)
      end
    end

    private
    def config_path
      File.expand_path('~/.pin-note.yml')
    end

    def load_saved
      if File.exist?(config_path)
        saved = YAML.load_file(config_path)
      else
        saved = []
      end

      saved
    end
  end
end