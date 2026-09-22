ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  setup do
    # Ensure a clean DB for model tests in a lightweight app setup.
  end
end
