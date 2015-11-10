require "erb"
class Application
        config = YAML.load((ERB.new File.new("config/database.yml").read).result)
        ActiveRecord::Base.establish_connection(config)
        ActiveRecord::Base.logger = Logger.new(STDERR)
end
