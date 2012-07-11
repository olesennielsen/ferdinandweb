class Designer < ActiveRecord::Base
  # Relations  
  belongs_to :company
  
  # Validations
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable  
  
  # hash used to get the name of a Role
  ROLE = { 0 => 'Admin',
           1 => 'Company Admin',
           2 => 'Designer' }
  # returns the fullname of a designer         
  def fullname
    "#{first_name} #{last_name}"
  end
end
