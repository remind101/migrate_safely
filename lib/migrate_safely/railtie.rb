module MigrateSafely
  class Railtie < Rails::Railtie
    rake_tasks do
      load "migrate_safely/tasks/migrate_safely.rake"
    end
  end
end
