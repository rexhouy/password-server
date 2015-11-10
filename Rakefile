require 'active_record'
require 'yaml'
require 'erb'

desc "Migrate the database through scripts in db/migrate."
task :migrate => :environment do
        ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
end

# Use "rake create[name]" to create migration files
desc "Create migration file in db/migrate"
task :create, [:name] do | t, args |
        file_name = Time.now.strftime("%Y%m%d%H%M%S")+ "_#{args.name}"
        File.new("db/migrate/#{file_name}.rb", "w").close
end

task :environment do
        ActiveRecord::Base.establish_connection(YAML.load((ERB.new File.new("config/database.yml").read).result))
        ActiveRecord::Base.logger = Logger.new(STDOUT)
end
