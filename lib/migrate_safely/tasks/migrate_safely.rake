namespace :migrate_safely do
  task :outline => :environment do
    require 'migrate_safely/migration_outliner'

    version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil # to_i is intentional, replicates ActiveRecord behavior
    actions = MigrateSafely::MigrationOutliner.pending_actions(version)

    unless actions.any?
      abort "There are no migrations to be applied or reverted"
    end

    puts "\ndatabase: #{ActiveRecord::Base.connection_config[:database]}\n\n"
    puts "#{'Action'.center(8)}  #{'Migration ID'.ljust(14)}  Migration Name"
    puts "-" * 50
    actions.each do |action|
      puts "#{action.action.center(8)}  #{action.version.to_s.ljust(14)}  #{action.name}"
    end
    puts
  end

  task :confirm do
    print "Are you sure you want to proceed? [y/n]: "
    input = STDIN.gets.chomp
    abort "Aborting" unless  %w(y yes yeah).include?(input.downcase)
  end
end

Rake::Task["db:migrate"].enhance ["migrate_safely:outline", "migrate_safely:confirm"]
