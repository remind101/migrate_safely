module MigrateSafely
  class MigrationOutliner
    Action = Struct.new(:version, :action, :name)

    def self.pending_actions(target_version = nil)
      current_version = ActiveRecord::Migrator.current_version
      return [] if current_version == 0 && target_version == 0

      direction = case
      when target_version.nil?
        :up
      when current_version > target_version
        :down
      else
        :up
      end

      migrations = ActiveRecord::Migrator.migrations(ActiveRecord::Migrator.migrations_paths)
      runnable_migrations = ActiveRecord::Migrator.new(direction, migrations, target_version).runnable
      action = direction == :up ? "apply" : "revert"

      runnable_migrations.map do |m|
        Action.new(m.version, action, m.name)
      end
    end
  end
end
