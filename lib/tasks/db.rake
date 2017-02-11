namespace :db do
  task :environment do
    require File.expand_path('../../../config/environment.rb',  __FILE__)
    Sequel.extension :migration
  end

  desc "Creates the database from DATABASE_NAME environment variable"
  task create: :dotenv do
    %x( createdb -E UTF8 -T template0 #{ENV['DATABASE_NAME']} )
    puts "Database #{ENV['DATABASE_NAME']} created successfully"
  end

  desc "Drops the database from DATABASE_URL environment variable"
  task drop: :dotenv do
    %x( dropdb #{ENV['DATABASE_NAME']} )
    puts "Database #{ENV['DATABASE_NAME']} dropped successfully"
  end

  desc "Migrate the database (options: VERSION environment variable)"
  task migrate: :environment do |t, args|
    target = ENV['VERSION'].to_i unless ENV['VERSION'].nil?
    Sequel::Migrator.run(DB, "db/migrate", target: target)
    puts "Database migrated successfully"
    DB.disconnect
  end

  desc "Rolls the schema back to the previous version"
  task rollback: :environment do |t, args|
    current = DB[:schema_info].first
    target = current[:version] - 1 if current[:version] > 0
    Sequel::Migrator.run(DB, "db/migrate", target: target)
    puts "Database rolled back successfully"
    DB.disconnect
  end

  desc "Drop the database, create and run all migrations"
  task setup: [:drop, :create, :migrate]

  desc "Retrieves the current schema version number"
  task version: :environment do |t, args|
    current = DB[:schema_info].first
    puts "The current schema version number is: #{current[:version]}"
    DB.disconnect
  end
end
