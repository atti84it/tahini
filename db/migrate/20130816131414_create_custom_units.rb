class CreateCustomUnits < ActiveRecord::Migration
  def change
    create_table :custom_units do |t|
      t.string :singular
      t.string :plural
      t.string :equivalence_unit
      t.float :equivalence_factor

      t.timestamps
    end
  end
end
