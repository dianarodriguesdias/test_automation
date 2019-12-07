require_relative '../web/page'
require_relative 'movies'
require_relative 'people_form'

module OutSystems
  class People < OutSystems::Web::Page
    include QAT::Logger

    elements_config QAT.configuration.dig(:web, :people)

    web_elements :new_person, :person_name, :person_saved_success

    def initialize
      raise HomePageNotLoaded.new 'People page was not loaded' unless has_selector? *selector_new_person
      #$QAT::Reporter::Times.stop(:movie_loading)
      log.info "Loaded people page with URL: #{current_url}"
    end

    def check_created_person(person_name)
      log.debug 'Checking if person was created successfully...'
      raise FailedToCreateNewPerson.new 'Failed to create person.' unless has_selector? *selector_person_saved_success
      person_created = find(*extract_selector(config_person_name, person_name))
      if person_created
        log.debug "Person was created successfully with the name '#{person_name}'"
      else
        raise FailedToCreateNewPerson.new 'Failed to create person.'
      end
    end

    def check_person_existence(person_name)
      begin
        person = all(*extract_selector(config_person_name, person_name)).last
        if person
          log.debug 'Person exists.'
          true
        else
          log.debug 'Person does not exist.'
          false
        end
      rescue Capybara::ElementNotFound
        log.debug 'Person does not exist.'
        false
      end
    end

    action :goto_people_form!, returns: [OutSystems::Web::Page] do
      #QAT::Reporter::Times.start(:login_page_loading)
      new_person.click
      log.debug 'Redirecting to people form page'
      OutSystems::PeopleForm.new
    end
    action :goto_person_edit_form!, returns: [OutSystems::Web::Page] do |person_name|
      person_name = all(*extract_selector(config_person_name, person_name)).last
      person_name.click
      log.debug 'Redirecting to people form page'
      OutSystems::PeopleForm.new
    end


    private

    class HomePageNotLoaded < QAT::Web::Error
    end
    class AccountActivationError < QAT::Web::Error
    end
    class FailedLogin < QAT::Web::Error
    end
    class FailedToCreateNewPerson < QAT::Web::Error
    end
    class FailedToEditMovie < QAT::Web::Error
    end
  end
end