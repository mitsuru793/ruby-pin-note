require "thor"
require 'awesome_print'

module PinNote
  class Cli < Thor
    desc "save Here is note... #tag", "Save note."
    option :from

    def save(*word)
      config_path = File.expand_path('~/.pin-note.yml')
      data = [
          {
              id: 1,
              note: word.join(' '),
              category: nil,
              created_at: Time.now.to_s,
          }
      ]
      File.open(config_path, 'w') do |f|
        YAML.dump(data, f)
      end
    end
  end
end