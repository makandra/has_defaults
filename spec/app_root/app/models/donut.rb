class Donut < ActiveRecord::Base
  has_defaults :flavor => "cream", :name => "Cream", :maker => proc { "Dunkin Donuts" }
end

