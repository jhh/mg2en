require "bundler/gem_tasks"
require 'pathname'

task :default => [:preview]

# defaults for environment variables:
# MG3=spec/fixtures/1.mgourmet3
# ENEX=tmp/<basename of MG3>.enex
# NOTEBOOK=Test
# TEMPLATE=default

notebook = ENV['NOTEBOOK'] || "Test"
Mg2en::Options.defaults[:template] = ENV['TEMPLATE'] || "default"

# paths to source (mg3) and dest (enex)
mg3 = ENV['MG3'] ? File.absolute_path(ENV['MG3']) :
  File.expand_path( '../spec/fixtures/1.mgourmet3', __FILE__)
enex = ENV['ENEX'] ? File.absolute_path(ENV['ENEX']) :
  File.join(File.expand_path( '../tmp', __FILE__), File.basename(mg3, '.mgourmet3') + '.enex')

# display task description paths as relative paths to fit rake -T line
pwd = Pathname.new(Dir.getwd)
enex_relpath = Pathname.new(enex).relative_path_from(pwd)
mg3_relpath = Pathname.new(mg3).relative_path_from(pwd)

# Convert to/from files specified by environment vairiables:
#   - MG3: conversion source file, defaults as above
#   - ENEX: conversion destination file, defaults as above
# e.g. MG3=/tmp/notes.macgourmet3 ENEX=/tmp/notes.enex rake convert
desc "Convert MG3=#{mg3_relpath} to ENEX=#{enex_relpath}"
task :convert do
  r = Mg2en::parse_xml(mg3)
  Mg2en::emit_enex(r, enex)
end

# Tell Evernote to import file to notebook specified by environment variables:
#   - ENEX: the file to import, defaults as above
#   - NOTEBOOK: the target notebook, defaults as above, must exist
# e.g. ENEX=/tmp/notes.enex NOTEBOOK=Notes rake import

desc "Imports ENEX=#{enex_relpath} into NOTEBOOK=#{notebook} (OS X only)"
task :import do
  raise "task requires AppleScript" unless RUBY_PLATFORM =~ /darwin/

  system "osascript -e 'tell application \"Evernote\" to import POSIX \
    file \"#{enex}\" to notebook \"#{notebook}\" tags true'"
end

desc "Convert and preview MG3=#{mg3_relpath} in NOTEBOOK=#{notebook} (OS X only)"
task :preview => [:convert, :import]

desc "Render ENML for #{mg3_relpath}"
task :enml do
  recipes = Mg2en::parse_xml(mg3)
  recipes.each do |r|
    puts r.enml
  end
end