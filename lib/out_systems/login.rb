require_relative '../web/page'

module OutSystems
  class Login < OutSystems::Web::Page
    include QAT::Logger

    elements_config QAT.configuration.dig(:web, :login)
    web_elements :login_button, :email_input, :password_input, :incorrect_login

    def initialize
      raise LoginPageNotLoaded.new 'Login page was not loaded.' unless has_selector? *selector_login_button
      # QAT::Reporter::Times.stop(:home_loading)
      log.info "Loaded login page with URL: #{current_url}"
    end

    def fill_credentials(username, password)
      raise CredentialsNotFound.new 'Input for inserting username/email not found.' unless has_selector? *selector_email_input
      log.info 'Setting username/email...'
      email_input.set(username)
      raise CredentialsNotFound.new 'Input for inserting password not found.' unless has_selector? *selector_password_input
      log.info 'Setting password...'
      password_input.set(password)
    end

    def incorrect_login
      if has_selector? *selector_incorrect_login
        log.debug 'Login incorrect!'
      else
        raise FailedLoginVerification.new 'Login error pop up message is not present!'
      end
    end

    def perform_login(username, password)
      fill_credentials(username, password)
      login_button.click unless username.nil? and password.nil?
    end

    action :goto_movies!, returns: [OutSystems::Web::Page] do
      log.debug 'Redirecting to movies page'
      OutSystems::Movies.new
    end

    class LoginPageNotLoaded < QAT::Web::Error
    end
    class CredentialsNotFound < QAT::Web::Error
    end
    class FailedLoginVerification < QAT::Web::Error
    end
  end
end