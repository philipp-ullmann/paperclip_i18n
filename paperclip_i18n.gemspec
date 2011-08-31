# -*- encoding: utf-8 -*-
$:.push(File.expand_path('../lib', __FILE__))
require('paperclip_i18n/version')

Gem::Specification.new do |s|
  s.name        = 'paperclip_i18n'
  s.version     = PaperclipI18n::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Rene Gross', 'Philipp Ullmann']
  s.email       = ["rg@create.at", 'philipp.ullmann@create.at']
  s.homepage    = ""
  s.summary     = 'Adding I18n image upload support to paperclip plugin'
  s.description = "This gem depends on the paperclip gem and Rails 3.1. A separate file can be uploaded for each language."

  s.rubyforge_project = 'paperclip_i18n'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  
  s.add_dependency('paperclip', ['>= 2.3.8'])
  s.add_dependency('sqlite3', ['>= 1.3.4'])
  s.add_development_dependency('activemodel', ['>= 3.1.0.rc8'])
  s.add_development_dependency('activerecord', ['>= 3.1.0.rc8'])
  s.add_development_dependency('rspec', ['>= 2.6.0'])
end
