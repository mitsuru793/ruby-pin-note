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
        load_notes do |note|
          puts note
        end
        return
      end

      selected_empty = options[:categories].include?('_')
      selected_list = categories.reject {|c| c === '_'}.join('|')
      selected = Regexp.new('(' + selected_list + ')')
      load_notes do |note|
        if selected_empty && note.category.nil?
          puts note
          next
        end

        if m = selected.match(note.category)
          selected_category = m[0]
        else
          next
        end

        next unless note.category === selected_category

        puts note
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

    def load_notes
      load_saved.each do |note_hash|
        yield Note.new(note_hash)
      end
    end
  end
end