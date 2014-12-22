require 'rubygems'
require 'bundler/setup'

require 'nobrainer'
require 'nobrainer/tree'

require 'rspec'

NoBrainer.configure do |config|
  config.app_name = :nobrainer_tree
  config.environment = :test
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec
  config.after(:each) { NoBrainer.purge! }
end
