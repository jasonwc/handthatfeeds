class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :avatar, :lunicorn

  has_attached_file :avatar
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  #validates :username, presence: true
  #validates :username, presence: true, on: :edit
  # attr_accessible :title, :body

  def is_admin?
    self.lunicorn?
  end

end


