class AddIsLunicornToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lunicorn, :boolean, default: false
  end
end
