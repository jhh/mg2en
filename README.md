# MacGourmet to Evernote

A library to parse a MacGourmet 3 export file and convert into an Evernote
export file. The resulting Evernote export file (*.enex) can be imported into
Evernote.

This converts most, but not all, MacGourmet recipe attributes.

## Installation

Download and install [FreeImage](http://sourceforge.net/projects/freeimage/).
  [Homebrew](http://brew.sh) users can:

    brew install freeimage

Add this line to your application's Gemfile:

    gem 'mg2en'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mg2en

## Usage

    mg2en -h

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
