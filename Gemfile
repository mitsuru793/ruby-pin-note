source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in pin_note-note.gemspec
gemspec

gem "thor", "~> 0.20.0"
gem "dry-struct", "~> 0.4.0"

group :test do
  gem "fakefs", "~> 0.13.3"
end

group :test, :development do
  gem "awesome_print", "~> 1.8"
end
