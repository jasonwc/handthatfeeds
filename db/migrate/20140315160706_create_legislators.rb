class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :title
      t.string :bioguide_id
      t.string :first_name
      t.string :last_name
      t.string :chamber
      t.string :state_name
      t.string :party
      t.string :office
      t.string :phone
      t.string :facebook_id
      t.string :twitter_id
      t.string :contact_form
      t.string :website
      t.attachment :profile_picture

      t.timestamps
    end
  end
end
