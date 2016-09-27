Gemika::Database.new.rewrite_schema! do

  create_table :pastries do |t|
    t.string :type
    t.string :flavor
    t.string :name
    t.string :maker
    t.string :weight
    t.string :main_ingredient
    t.string :health_benefits
  end

  create_table :model_without_defaults do |t|
  end

end
