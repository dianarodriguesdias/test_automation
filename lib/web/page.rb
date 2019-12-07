require 'capybara/dsl'
require 'qat/logger'
require 'qat/configuration'
require 'qat/web/page'
require 'qat/web/finders'
require 'active_support/core_ext/hash/indifferent_access'


module OutSystems
  module Web
    class Page < QAT::Web::Page
      include Capybara::DSL
      include QAT::Logger
      include QAT::Web::Finders

      action :navigate_movies!, returns: [OutSystems::Web::Page] do
        #QAT::Reporter::Times.start(:movie_loading)
        visit URI::Generic.build(QAT.configuration[:hosts][:home].symbolize_keys).to_s
        OutSystems::Movies.new
      end


      action :navigate_application!, returns: [OutSystems::Web::Page] do
        #QAT::Reporter::Times.start(:movie_loading)
        visit URI::Generic.build(QAT.configuration[:hosts][:home].symbolize_keys).to_s
        OutSystems::Login.new
      end
    end
  end
end