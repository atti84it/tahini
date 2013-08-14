class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.references :menu, index: true
      t.integer :yields
      t.references :recipe, index: true

      t.timestamps
    end
  end
end
