class Donut < Pastry

  has_defaults :flavor => "cream", :name => "Cream"
  has_defaults :maker => proc { "Dunkin Donuts" }
  has_defaults :weight => proc { weigh }
  has_defaults :health_benefits => proc { self.class.global_health_benefits }

  def flavor
    @flavor_getter_called = true
    read_attribute(:flavor)
  end

  def flavor=(value)
    @flavor_setter_called = true
    write_attribute(:flavor, value)
  end

  def weigh
    "a lot"
  end

  def self.global_health_benefits
    'none'
  end

end
