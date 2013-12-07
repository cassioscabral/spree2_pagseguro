$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spree2_pagseguro/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spree2_pagseguro"
  s.version     = Spree2Pagseguro::VERSION
  s.authors     = ["Cassio Cabral"]
  s.email       = ["cassioscabral@gmail.com"]
  s.homepage    = "https://github.com/cassioscabral/spree2_pagseguro"
  s.summary     = "Adaptação da gem spree_pag_seguro(https://github.com/heavenstudio/spree_pag_seguro) para a versão 2.1 do spree."
  s.description = "Integra o spree 2.1.X ao pagseguro"
  s.required_ruby_version = '>= 2.0.0'
  
  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.require_path = 'lib'

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "spree_core", "~> 2.1.3"
  s.add_dependency "pag_seguro", "~> 0.5.5"
  #s.add_dependency "pagseguro-oficial", git: "git://github.com/pagseguro/ruby.git"
  s.add_development_dependency "sqlite3"
end
