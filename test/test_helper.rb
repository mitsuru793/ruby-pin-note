$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

# stdlib
require 'yaml'
require 'fileutils'

# 3rd party
require "minitest/mock"
require "minitest/autorun"
require 'fakefs'

require "pin_note"

FakeFS.activate!
FileUtils.mkdir_p(File.expand_path('~'))
