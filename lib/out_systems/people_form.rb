require_relative '../web/page'
require_relative 'login'

module OutSystems
  class PeopleForm < OutSystems::Web::Page
    include QAT::Logger

    elements_config QAT.configuration.dig(:web, :people_form)

    web_elements :new_people_text, :person_name_input, :person_surname_input, :person_date_of_birth, :save_person

    def initialize
      raise HomePageNotLoaded.new 'People form page was not loaded' unless has_selector? *selector_new_people_text
      #QAT::Reporter::Times.stop(:movie_loading)
      log.info "Loaded people form page with URL: #{current_url}"
    end

    def fill_person_form(person_name)
      log.info 'Filling person form...'
      person_full_name = person_name.split( )
      person_name_input.set(person_full_name.first)
      person_surname_input.set(person_full_name.last)
      person_date_of_birth.set('1993-04-09')
      log.info 'Saving person...'
      save_person.click
      log.info 'Person was saved.'
    end

    def edit_person(person_name, surname)
      log.info "Editing person #{person_name}..."
      person_surname_input.set(surname)
      log.info 'Saving person...'
      save_person.click
      log.info 'Person was saved.'
    end

    action :goto_people!, returns: [OutSystems::Web::Page] do
      log.debug 'Redirecting to people form page'
      OutSystems::People.new
    end

    #
    # def edit_movie(movie_to_edit, description)
    #   log.info "Editing movie #{movie_to_edit}..."
    #   movie_plot_input.set(description)
    #   log.info 'Saving movie changes...'
    #   save_movie_form.click
    #   log.debug 'Changes where successfully made.'
    # end
    #
    #
    # action :goto_movies!, returns: [OutSystems::Web::Page] do
    #   log.debug 'Redirecting to movies page'
    #   OutSystems::Movies.new
    # end

    private

    class HomePageNotLoaded < QAT::Web::Error
    end
    class AccountActivationError < QAT::Web::Error
    end
    class FailedLogin < QAT::Web::Error
    end
  end
end