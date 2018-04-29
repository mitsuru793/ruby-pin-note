# stdlib
require 'yaml'

# 3rd party
require 'dry-struct'
require 'thor'

module PinNote
  module Types
    include Dry::Types.module
  end
end

require "pin_note/version"
require "pin_note/cli"
require "pin_note/note"
