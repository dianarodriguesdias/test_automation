require_relative 'page_manager'
require_relative '../../lib/out_systems/movies'
require 'qat/web'
require 'selenium-webdriver'

require_relative 'remote_driver'

QAT::Web::Browser::AutoLoad.load_browsers!
QAT::Web::Screen::AutoLoad.load_screens!

module OutSystems
  module Web
    module World

      def browser
        unless @browser
          QAT::Web::Browser::Factory.for :remote_firefox
          @browser = OutSystems::Web::PageManager.new
        end
        @browser
      end

    end
  end
end