require "bundler/gem_tasks"
require 'pathname'

# defaults for environment variables
ENV['ENEX'] ||= File.expand_path('../tmp/fixture.enex', __FILE__)
ENV['NOTEBOOK'] ||= "Test"
ENV['MG3'] ||= File.expand_path('../spec/fixtures/1.mgourmet3', __FILE__)

# display task description paths as relative paths
pwd = Pathname.new(Dir.getwd)
enex_path = Pathname.new(ENV['ENEX']).relative_path_from(pwd)
mg3_path = Pathname.new(ENV['MG3']).relative_path_from(pwd)

task :default => [:preview]

# Convert to/from files specified by environment vairiables:
#   - MG3: conversion source file, defaults as above
#   - ENEX: conversion destination file, defaults as above
# e.g. MG3=/tmp/notes.macgourmet3 ENEX=/tmp/notes.enex rake convert
desc "Convert MG3=#{mg3_path} to ENEX=#{enex_path}"
task :convert do
  r = Mg2en::parse_xml(ENV['MG3'])
  Mg2en::emit_enex(r, ENV['ENEX'])
end

# Tell Evernote to import file to notebook specified by environment variables:
#   - ENEX: the file to import, defaults as above
#   - NOTEBOOK: the target notebook, defaults as above, must exist
# e.g. ENEX=/tmp/notes.enex NOTEBOOK=Notes rake import

desc "Imports ENEX=#{enex_path} into NOTEBOOK=#{ENV['NOTEBOOK']} (OS X only)"
task :import do
  raise "task requires AppleScript" unless RUBY_PLATFORM =~ /darwin/

  system "osascript -e 'tell application \"Evernote\" to import POSIX \
    file \"#{ENV['ENEX']}\" to notebook \"#{ENV['NOTEBOOK']}\"'"
end

desc "Convert and preview MG3=#{mg3_path} in NOTEBOOK=#{ENV['NOTEBOOK']} (OS X only)"
task :preview => [:convert, :import]