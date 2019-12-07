require_relative 'page'
require_relative 'blank_page'
require 'qat/web/page_manager'

module OutSystems::Web
  class PageManager < QAT::Web::PageManager
    manages OutSystems::Web::Page
    initial_page OutSystems::Web::BlankPage
  end
end