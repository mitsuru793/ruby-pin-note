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

    desc "list", "List notes."
    option :category, aliases: :c, type: :string, desc: 'List notes of only CATEGORY. If CATEGORY is \'_\', list them only has no category.'

    def list
      load_saved.each do |note_hash|
        note = Note.new(note_hash)
        date = note.created_at.strftime('%Y-%m-%d %H:%M:%S')

        case options[:category] || nil
          when nil
            # not next
          when '_'
            next unless note.category.nil?
          else
            next unless note.category === options[:category]
        end

        if note.category.nil?
          puts sprintf('[%s] %s', date, note.note)
        else
          puts sprintf('[%s] %s: %s', date, note.category, note.note)
        end
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