class User < ActiveRecord::Base
  has_many :relationships
  has_many :legislators, through: :relationships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name

  validates :username, presence: true
  #validates :username, presence: true, on: :edit
  # attr_accessible :title, :body

end


