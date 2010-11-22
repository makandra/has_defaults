class Pastry < ActiveRecord::Base
  
  has_defaults :main_ingredient => "flour", :maker => "Mom"
  
end

