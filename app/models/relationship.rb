class Relationship < ActiveRecord::Base
  attr_accessible :legislator_id, :user_id

  belongs_to :user
  belongs_to :legislator
end
