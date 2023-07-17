ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

#1. Activar requerimientos de capybara
require "capybara/rails" 
require "capybara/minitest" 

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors) #2. , with: :threads eliminado

  #3. Habilitar capybara
  include Capybara::DSL
  include Capybara::Minitest::Assertions #Construye los assert_


  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  # Add more helper methods to be used by all tests here...
  #4. Añadir nuevos metodos
  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
