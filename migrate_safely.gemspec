$:.push File.expand_path("../lib", __FILE__)

require "migrate_safely/version"

Gem::Specification.new do |s|
  s.name        = "migrate_safely"
  s.version     = MigrateSafely::VERSION
  s.authors     = ["Vlad Yarotsky"]
  s.email       = ["vlad@remind101.com"]
  s.summary     = "Adds a confirmation prompt to rake db:migrate"
  s.description = "Adds a confirmation prompt to rake db:migrate; Lists migrations to be applied/reverted before proceeding."

  s.files = Dir["{lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_development_dependency "sqlite3"
end
