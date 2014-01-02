require "bundler/gem_tasks"

# Tell Evernote to import file to notebook specified by environment variables:
#   - ENEX: the file to import, defaults to 'tmp/fixture.enex'
#   - NOTEBOOK: the target notebook, defaults to 'Test', must exist
# e.g. rake import ENEX=/tmp/notes.enex NOTEBOOK=Notes

desc "Imports ENEX=/path/to/enex into NOTEBOOK=name (OS X only)"
task :import do
  raise "task requires AppleScript" unless RUBY_PLATFORM =~ /darwin/

  ENV['ENEX'] ||= File.expand_path('../tmp/fixture.enex', __FILE__)
  ENV['NOTEBOOK'] ||= "Test"

  system "osascript -e 'tell application \"Evernote\" to import POSIX \
    file \"#{ENV['ENEX']}\" to notebook \"#{ENV['NOTEBOOK']}\"'"
end