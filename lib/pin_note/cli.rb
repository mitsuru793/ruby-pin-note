require "thor"
require 'awesome_print'

module PinNote
  class Cli < Thor
    desc "save Here is note... #tag", "Save a note."
    option :category, aliases: :c, type: :string, desc: 'Save note on CATEGORY'

    def save(*word)
      data = [
          {
              id: 1,
              note: word.join(' '),
              category: options[:category] || ENV['PIN_NOTE_CATEGORY'] || nil,
              created_at: Time.now,
          }
      ]
      File.open(config_path, 'w') do |f|
        YAML.dump(data, f)
      end
    end

    private
    def config_path
      File.expand_path('~/.pin-note.yml')
    end
  end
end