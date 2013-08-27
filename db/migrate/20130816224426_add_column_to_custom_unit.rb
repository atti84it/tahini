class AddColumnToCustomUnit < ActiveRecord::Migration
  def change
    add_column :custom_units, :physical_type, :integer
  end
end
