class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :checkouts 

  validates :email, format: { with: /\A[a-zA-Z]+@wafflestudio.com\z/, message: "only allows @wafflestudio.com" }
end
