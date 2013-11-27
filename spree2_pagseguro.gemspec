$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree2_pagseguro/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree2_pagseguro"
  s.version     = Spree2Pagseguro::VERSION
  s.authors     = ["Cassio Cabral"]
  s.email       = ["cassioscabral@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Spree2Pagseguro."
  s.description = "TODO: Description of Spree2Pagseguro."
  s.required_ruby_version = '>= 2.0.0'
  
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.require_path = 'lib'

  s.add_dependency "rails", "~> 4.0.1"
  s.add_dependency "pag_seguro", "~> 0.5.5"

  s.add_development_dependency "sqlite3"
end
