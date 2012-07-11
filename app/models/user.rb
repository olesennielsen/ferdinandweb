class User < ActiveRecord::Base
  has_many :authentications  
  has_and_belongs_to_many :companies
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  # The apply_omniauth method used to create the user, called from the authentications controller
  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
end
