$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

# stdlib
require 'yaml'
require 'fileutils'

# 3rd party
require "minitest/mock"
require "minitest/autorun"
require 'fakefs/safe'

require "pin_note"

class PinNoteUnitTest < Minitest::Test
  def setup
    @now = Time.new
  end

  private
  def run_command(args, config_path = '~/.pin-note.yml')
    saved = nil
    FakeFS do
      FileUtils.mkdir_p(File.expand_path('~'))

      Time.stub :now, @now do
        PinNote::Cli.start(args, debug: true)
      end

      saved = YAML.load_file(File.expand_path(config_path))
    end
    saved
  end
end

