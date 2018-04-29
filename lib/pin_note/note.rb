module PinNote
  class Note < Dry::Struct
    attribute :note, Types::String
    attribute :category, Types::String
    attribute :created_at, Types::Date
  end
end
