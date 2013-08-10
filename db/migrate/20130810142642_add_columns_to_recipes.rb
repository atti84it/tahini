class AddColumnsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :ingredients_text, :text
  end
end
