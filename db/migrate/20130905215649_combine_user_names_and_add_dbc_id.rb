class CombineUserNamesAndAddDbcId < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :dbc_id, :integer
    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
