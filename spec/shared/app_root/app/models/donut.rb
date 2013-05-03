class Donut < Pastry

  has_defaults :flavor => "cream", :name => "Cream"
  has_defaults :maker => proc { "Dunkin Donuts" }
  has_defaults :weight => proc { self.class.weigh }

  def flavor
    @flavor_getter_called = true
    read_attribute(:flavor)
  end

  def flavor=(value)
    @flavor_setter_called = true
    write_attribute(:flavor, value)
  end

  def self.weigh
    "a lot"
  end

end
