class Legislator < ActiveRecord::Base
  has_many :relationships
  has_many :users, through: :relationships

  attr_accessible :crp_id, :bioguide_id, :chamber, :contact_form, :facebook_id, :first_name, :last_name, :office, :party, :phone, :profile_picture, :state_name, :title, :twitter_id, :website 
end
