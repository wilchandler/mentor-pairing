$LOAD_PATH.unshift("lib")
$LOAD_PATH.unshift("app")
$LOAD_PATH.unshift("app/models")
require 'rspec/autorun'
RSpec.configure do |config|
  config.order = "random"
end
