require 'test_helper'

module MigrateSafely
  class MigrationOutlinerTest < ActiveSupport::TestCase
    setup do
      ActiveRecord::Base.connection.begin_transaction(joinable: false)
    end

    teardown do
      if ActiveRecord::Base.connection.transaction_open?
        ActiveRecord::Base.connection.rollback_transaction
      end
    end

    test "lists all pending migrations when version is not specified" do
      pending_actions = MigrationOutliner.pending_actions
      assert_equal [
        MigrationOutliner::Action.new(20150918000000, "apply", "TestMigration1"),
        MigrationOutliner::Action.new(20150918000001, "apply", "TestMigration2"),
        MigrationOutliner::Action.new(20150918000002, "apply", "TestMigration3")
      ], pending_actions
    end

    test "says will apply migrations up to version (inclusive) when the version is newer than current" do
      pending_actions = MigrationOutliner.pending_actions(20150918000001)
      assert_equal [
        MigrationOutliner::Action.new(20150918000000, "apply", "TestMigration1"),
        MigrationOutliner::Action.new(20150918000001, "apply", "TestMigration2")
      ], pending_actions
    end

    test "says will revert migrations that are newer than version (not inclusive) when version is older than current" do
      ActiveRecord::SchemaMigration.create!(version: "20150918000000")
      ActiveRecord::SchemaMigration.create!(version: "20150918000001")

      pending_actions = MigrationOutliner.pending_actions(20150918000000)
      assert_equal [
        MigrationOutliner::Action.new(20150918000001, "revert", "TestMigration2")
      ], pending_actions
    end

    test "returns an empty list of actions if the version is equal to current" do
      current_version = 20150918000000
      ActiveRecord::SchemaMigration.create!(version: current_version.to_s)

      pending_actions = MigrationOutliner.pending_actions(current_version)
      assert_equal [], pending_actions
    end
  end
end
