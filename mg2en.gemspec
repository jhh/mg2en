# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mg2en'

Gem::Specification.new do |gem|
  gem.name          = "mg2en"
  gem.version       = Mg2en::VERSION
  gem.authors       = ["Jeff Hutchison"]
  gem.email         = ["jeff@jeffhutchison.com"]
  gem.description   = gem.summary
  gem.summary       = %q{Convert MacGourmet plist export format to Evernote import format}
  gem.homepage      = "https://github.com/jhh/mg2en"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency('plist', '~> 3.1')
  gem.add_dependency('builder', '~> 2.0')

  gem.add_development_dependency 'pry'
end
