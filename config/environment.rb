# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
BillSplit::Application.initialize!

Money.default_currency = Money::Currency.new("EUR")
