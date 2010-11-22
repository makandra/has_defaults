class CreatePastries < ActiveRecord::Migration

  def self.up
    create_table :pastries do |t|
      t.string :type
      t.string :flavor
      t.string :name
      t.string :maker
      t.string :weight
      t.string :main_ingredient
    end
  end

  def self.down
    drop_table :pastries
  end
  
end
