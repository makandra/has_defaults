class CreateDonuts < ActiveRecord::Migration

  def self.up
    create_table :donuts do |t|
      t.string :flavor, :name, :maker
    end
  end

  def self.down
    drop_table :donuts
  end
  
end
