$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "manybots-gmail-madpizza/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "manybots-gmail-madpizza"
  s.version     = ManybotsGmailMadpizza::VERSION
  s.authors     = ["Alexandre L. Solleiro"]
  s.email       = ["alex@webcracy.org"]
  s.homepage    = "https://www.manybots.com"
  s.summary     = "Convert email order confirmations from Madpizza to meal order activities."
  s.description = <<-DESC
  This Manybots Agent relies on the Manybots Gmail Observer to get any emails from Madpizza.pt 
  order confirmation system and convert them to quantifiable activities.
  DESC

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  s.add_dependency "httparty"
  
  s.add_development_dependency "sqlite3"
end
