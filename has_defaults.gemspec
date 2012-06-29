$:.push File.expand_path("../lib", __FILE__)
require "has_defaults/version"

Gem::Specification.new do |s|
  s.name = 'has_defaults'
  s.version = HasDefaults::VERSION
  s.authors = ["Henning Koch"]
  s.email = 'henning.koch@makandra.de'
  s.homepage = 'https://github.com/makandra/has_defaults'
  s.summary = 'Default values for ActiveRecord models.'
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('activerecord')
end
