FIXTURES_ROOT = File.expand_path("../fixtures", __FILE__)

require 'active_record'
require 'active_support/testing/autorun'
require 'active_support/test_case'
require 'migrate_safely'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: File.join(FIXTURES_ROOT, "db.sqlite3"),
  pool: 1,
  timeout: 5000
)
ActiveRecord::Migrator.migrations_paths = [File.join(FIXTURES_ROOT, "migrations")]
