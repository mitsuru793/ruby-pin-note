# PinNote [![Build Status](https://travis-ci.org/mitsuru793/ruby-pin-note.svg?branch=master)](https://travis-ci.org/mitsuru793/ruby-pin-note) [![Maintainability](https://api.codeclimate.com/v1/badges/2db5e897884af5270127/maintainability)](https://codeclimate.com/github/mitsuru793/ruby-pin-note/maintainability) [![Inline docs](http://inch-ci.org/github/mitsuru793/ruby-pin-note.svg?branch=master)](http://inch-ci.org/github/mitsuru793/ruby-pin-note)

Save one text like tweet from cli. This means you tweet on private as note. Your notes are saved in your local.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pin_note'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pin_note

## Usage

```
❯ pin-note
Commands:
  pin-note help [COMMAND]             # Describe available commands or one specific command
  pin-note list                       # List notes.
  pin-note save Here is note... #tag  # Save a note.
```

Options:
 + c means category.
 + f means format.

```
pin-note save Today is happy.
pin-note save -c todo by my room
pin-note save -c todo clean my room
pin-note save -c want car

$ pin-note list
[2018-04-30 16:51:46] inbox: Today is happy.
[2018-04-30 16:51:47] todo: by my room
[2018-04-30 16:51:47] todo: clean my room
[2018-04-30 16:53:26] want: car

$ pin-note list -c todo
[2018-04-30 16:51:47] todo: by my room
[2018-04-30 16:51:47] todo: clean my room

$ pin-note list -c inbox want
[2018-04-30 16:51:46] inbox: Today is happy.
[2018-04-30 16:53:26] want: car

$ pin-note list -f json
# => List notes as json. You can use them with jq.
```

[jq](https://stedolan.github.io/jq/) is like sql for json.

You can change default category with an Evironment variable.

```
$ export PIN_NOTE_DEFAULT_CATEGORY=todo
$ pin-note save buy milk
$ pin-note save clean my room

$ unset PIN_NOTE_DEFAULT_CATEGORY
$ pin-note save Today is happy!

$ pin-note list
[2018-04-30 17:04:55] todo: buy milk
[2018-04-30 17:05:04] todo: clean my room
[2018-04-30 17:05:15] inbox: Today is happy!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pin_note.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
