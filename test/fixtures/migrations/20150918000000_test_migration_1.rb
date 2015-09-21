class TestMigration1 < ActiveRecord::Migration
  def self.up
    puts "test migration1 applied"
  end

  def self.down
    puts "test migration1 reverted"
  end
end
