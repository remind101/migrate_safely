class TestMigration2 < ActiveRecord::Migration
  def self.up
    puts "test migration2 applied"
  end

  def self.down
    puts "test migration2 reverted"
  end
end

