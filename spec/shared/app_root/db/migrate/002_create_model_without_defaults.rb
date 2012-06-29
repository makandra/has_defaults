class CreateModelWithoutDefaults < ActiveRecord::Migration

  def self.up
    create_table :model_without_defaults do |t|
    end
  end

  def self.down
    drop_table :model_without_defaults
  end
  
end
