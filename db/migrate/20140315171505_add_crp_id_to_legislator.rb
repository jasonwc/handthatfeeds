class AddCrpIdToLegislator < ActiveRecord::Migration
  def change
    add_column :legislators, :crp_id, :string
  end
end
