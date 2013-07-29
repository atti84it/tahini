class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.float :number
      t.string :unit
      t.string :name
      t.references :recipe, index: true

      t.timestamps
    end
  end
end
