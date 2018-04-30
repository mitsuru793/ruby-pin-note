module PinNote
  class Cli < Thor
    desc "save Here is note... #tag", "Save a note."
    option :category, aliases: :c, type: :string, desc: 'Save note on CATEGORY'

    def save(word, *words)
      words.unshift(word)

      note = Note.new(
          text: words.join(' '),
          category: options[:category] || ENV['PIN_NOTE_CATEGORY'] || 'inbox',
          created_at: Time.now,
          )
      saved = load_saved
      saved.push(note.to_h)

      File.open(config_path, 'w') do |f|
        YAML.dump(saved, f)
      end
    end

    desc "list", "List notes."
    option :categories, aliases: :c, type: :array, desc: 'List notes of only CATEGORY.'
    option :format, aliases: :f, type: :string, default: 'human', desc: 'List note as FORMAT.'

    def list
      categories = options[:categories]
      if categories.nil?
        list_notes(load_notes, options[:format])
        return
      end

      selected = categories.join('|')
      notes = load_notes.select {|note|
        selected.match?(note.category)
      }
      list_notes(notes, options[:format])
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

    def load_notes
      load_saved.map {|h| Note.new(h)}
    end

    def list_notes(notes, format)
      case format
        when 'human'
          puts notes
        when 'json'
          puts JSON.generate(notes.map(&:to_h))
      end
    end
  end
end