require "thor"
require 'awesome_print'

module PinNote
  class Cli < Thor
    desc "save Here is note... #tag", "Save a note."
    option :category, aliases: :c, type: :string, desc: 'Save note on CATEGORY'

    def save(*word)
      if File.exist?(config_path)
        saved = YAML.load_file(config_path)
      else
        saved = []
      end

      note = Note.new(
          note: word.join(' '),
          category: options[:category] || ENV['PIN_NOTE_CATEGORY'] || nil,
          created_at: Time.now,
          )
      saved.push(note.to_h)

      File.open(config_path, 'w') do |f|
        YAML.dump(saved, f)
      end
    end

    private
    def config_path
      File.expand_path('~/.pin-note.yml')
    end
  end
end