# -*- encoding : utf-8 -*-

############################################
# Requires for your code libraries go here #
############################################
require 'qat/logger'
#turn off QAT::Configuration Logger
Log4r::YamlConfigurator.load_yaml_file(File.join(File.dirname(__FILE__), '..', '..', 'config', 'common', 'basic_logger.yml'))

require 'selenium-webdriver'
require 'qat/cucumber'
require 'qat/configuration'
require 'qat/web/cucumber'
require_relative '../../lib/web/world'

World OutSystems::Web::World

ENV['FIREFOX_PATH']&.tap do |path|
  Selenium::WebDriver::Firefox::Binary.path = path
end
