require_relative '../web/page'
require_relative 'movies'

module OutSystems
  class MovieForm < OutSystems::Web::Page
    include QAT::Logger

    elements_config QAT.configuration.dig(:web, :movie_form)

    web_elements :new_movie_text, :movie_title_input, :movie_year_input, :movie_plot_input, :movie_genre_combo, :movie_genre,
                 :movie_gross_takings, :movie_available_dvd, :save_movie_form
    def initialize
      raise HomePageNotLoaded.new 'Movie form page was not loaded' unless has_selector? *selector_new_movie_text
      log.info "Loaded movie form page with URL: #{current_url}"
    end

    def fill_movie_form(movie_title)
      log.info 'Filling movie form...'
      movie_title_input.set(movie_title)
      movie_year_input.set(2018)
      movie_plot_input.set('Brief description')
      movie_genre_combo.click
      within movie_genre_combo do
        option_list = all(:xpath, ".//option[not(contains(@value,'ossli'))]")
        option_list.sample.hover.click
      end
      movie_gross_takings.set(0)
      movie_available_dvd.click
      log.info 'Saving movie...'
      save_movie_form.click
      log.info 'Movie was saved.'
    end

    def edit_movie(movie_to_edit, description)
      log.info "Editing movie #{movie_to_edit}..."
      movie_plot_input.set(description)
      log.info 'Saving movie changes...'
      save_movie_form.click
      log.debug 'Changes where successfully made.'
    end

    action :goto_movies!, returns: [OutSystems::Web::Page] do
      log.debug 'Redirecting to movies page'
      OutSystems::Movies.new
    end

    private

    class HomePageNotLoaded < QAT::Web::Error
    end
    class AccountActivationError < QAT::Web::Error
    end
    class FailedLogin < QAT::Web::Error
    end
  end
end