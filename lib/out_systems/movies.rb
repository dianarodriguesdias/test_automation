require_relative '../web/page'
require_relative 'login'
require_relative 'movie_form'
require_relative 'people'

module OutSystems
  class Movies < OutSystems::Web::Page
    include QAT::Logger

    elements_config QAT.configuration.dig(:web, :movies)

    web_elements :goto_login, :login_img, :login_user_text, :new_movie, :movie_title, :movie_description, :movie_saved_success, :people_tab

    def initialize
      #raise HomePageNotLoaded.new 'Movies page was not loaded' unless has_selector? *selector_new_movie
      # QAT::Reporter::Times.stop(:movie_loading)
      log.info "Loaded movies page with URL: #{current_url}"
    end

    def check_login
      log.debug 'Checking if user is logged in...'
      user_text = find(*extract_selector(config_login_user_text, 'QS_DEMO'))
      if has_selector? *selector_login_img and user_text.present?
        log.debug "User: '#{user_text.text}' is logged in"
      else
        raise FailedLogin.new 'Login not successful.'
      end
    end

    def check_movie_creation(movie_title)
      log.debug 'Checking if movie was created successfully...'
      raise FailedToCreateNewMovie.new 'Failed to create new movie.' unless has_selector? *selector_movie_saved_success
      movie_created = find(*extract_selector(config_movie_title, movie_title))
      if movie_created
        log.debug "Movie was created successfully with the title '#{movie_title}'"
      else
        raise FailedToCreateNewMovie.new 'Failed to create new movie.'
      end
    end

    def check_movie_edition(description)
      log.debug 'Checking if movie was edited successfully...'
      raise FailedToEditMovie.new 'Failed to edit movie.' unless has_selector? *selector_movie_saved_success
      movie_description = all(*extract_selector(config_movie_description, description)).last
      if movie_description
        log.debug "Movie was edited successfully with the new description '#{description}'"
      else
        raise FailedToEditMovie.new 'Failed to edit movie.'
      end
    end

    def check_movie_existence(movie_title)
      begin
        movie = all(*extract_selector(config_movie_title, movie_title)).last
        if movie
          log.debug 'Movie exists.'
          true
        else
          log.debug 'Movie does not exist.'
          false
        end
      rescue Capybara::ElementNotFound
        log.debug 'Movie does not exist.'
        false
      end
    end

    action :goto_login!, returns: [OutSystems::Web::Page] do
      #QAT::Reporter::Times.start(:login_page_loading)
      goto_login.click
      log.debug 'Redirecting to login page'
      OutSystems::Login.new
    end

    action :goto_movie_form!, returns: [OutSystems::Web::Page] do
      new_movie.click
      log.debug 'Redirecting to movie form page'
      OutSystems::MovieForm.new
    end

    action :goto_movie_edit_form!, returns: [OutSystems::Web::Page] do |movie_title|
      movie = all(*extract_selector(config_movie_title, movie_title)).last
      movie.click
      log.debug 'Redirecting to movie form page'
      OutSystems::MovieForm.new
    end

    action :goto_people!, returns: [OutSystems::Web::Page] do
      people_tab.click
      log.debug 'Redirecting to people form page'
      OutSystems::People.new
    end

    private

    class HomePageNotLoaded < QAT::Web::Error
    end
    class AccountActivationError < QAT::Web::Error
    end
    class FailedLogin < QAT::Web::Error
    end
    class FailedToCreateNewMovie < QAT::Web::Error
    end
    class FailedToEditMovie < QAT::Web::Error
    end
  end
end