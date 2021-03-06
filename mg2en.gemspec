# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mg2en/version'

Gem::Specification.new do |gem|
  gem.name          = "mg2en"
  gem.version       = Mg2en::VERSION
  gem.authors       = ["Jeff Hutchison"]
  gem.email         = ["jeff@jeffhutchison.com"]
  gem.description   = gem.summary
  gem.summary       = %q{Convert MacGourmet plist export format to Evernote import format}
  gem.homepage      = "https://github.com/jhh/mg2en"
  gem.license       = 'MIT'
  gem.date          = Time.now.utc.strftime("%Y-%m-%d")

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('plist', '~> 3.1')
  gem.add_runtime_dependency('builder', '~> 3.2')
  gem.add_runtime_dependency('haml', '~> 4.0')
  gem.add_runtime_dependency('image_science', '~> 1.2')
  gem.add_runtime_dependency('activesupport', '~> 4.0')

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'ruby_gntp'
  gem.add_development_dependency 'libxml-ruby'
end
