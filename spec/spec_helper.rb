require 'capybara'
require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require 'rack_session_access'
require 'rack_session_access/capybara'
require './spec/features/web_helpers.rb'

ENV['RACK_ENV'] = 'test'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  SimpleCov::Formatter::HTMLFormatter
])

SimpleCov.start

require File.join(File.dirname(__FILE__), '..', 'app.rb')

Capybara.app = RPS

RPS.configure do |app|
  app.use RackSessionAccess::Middleware
end
