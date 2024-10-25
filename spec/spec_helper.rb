$: << File.join(File.dirname(__FILE__), "/../../lib" )

require 'has_defaults'
require 'gemika'
require 'pry'

if ActiveRecord::VERSION::MAJOR >= 7
  ActiveRecord.default_timezone = :local
else
  ActiveRecord::Base.default_timezone = :local
end

Dir["#{File.dirname(__FILE__)}/support/*.rb"].sort.each {|f| require f}
Dir["#{File.dirname(__FILE__)}/shared_examples/*.rb"].sort.each {|f| require f}

Gemika::RSpec.configure_clean_database_before_example
Gemika::RSpec.configure_should_syntax
