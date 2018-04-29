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
    option :categories, aliases: :c, type: :array, desc: 'List notes of only CATEGORY. If CATEGORY is \'_\', list them only has no category.'

    def list
      categories = options[:categories]
      if categories.nil?
        load_saved.each do |note_hash|
          note = Note.new(note_hash)
          list_note(note)
        end
        return
      end

      selected_empty = options[:categories].include?('_')
      selected_list = categories.reject {|c| c === '_'}.join('|')
      selected = Regexp.new('(' + selected_list + ')')
      load_saved.each do |note_hash|
        note = Note.new(note_hash)

        if selected_empty && note.category.nil?
          list_note(note)
          next
        end

        if m = selected.match(note.category)
          selected_category = m[0]
        else
          next
        end

        next unless note.category === selected_category

        list_note(note)
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

    def list_note(note)
      date = note.created_at.strftime('%Y-%m-%d %H:%M:%S')

      if note.category.nil?
        puts sprintf('[%s] %s', date, note.note)
      else
        puts sprintf('[%s] %s: %s', date, note.category, note.note)
      end
    end
  end
end