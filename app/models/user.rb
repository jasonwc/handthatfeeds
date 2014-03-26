class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :avatar, :lunicorn
  acts_as_follower
  has_attached_file :avatar
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :avatar
  has_attached_file :avatar, :styles => { 
    :small  => "150x150>",
    :thumb => "100x100>",
    :medium => "300x300>"}, 
    :default_url => "/images/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  #validates :username, presence: true
  #validates :username, presence: true, on: :edit
  # attr_accessible :title, :body

  def is_admin?
    self.lunicorn?
  end

end


