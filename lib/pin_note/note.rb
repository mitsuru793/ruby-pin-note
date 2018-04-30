module PinNote
  class Note < Dry::Struct
    attribute :text, Types::String
    attribute :category, Types::String
    attribute :created_at, Types::Date

    def to_s
      date = created_at.strftime('%Y-%m-%d %H:%M:%S')

      if category.nil?
        sprintf('[%s] %s', date, text)
      else
        sprintf('[%s] %s: %s', date, category, text)
      end
    end
  end
end
