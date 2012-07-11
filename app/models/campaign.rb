class Campaign < ActiveRecord::Base
  ## Relations
  belongs_to :company
  has_many :pages, :dependent => :destroy
  has_and_belongs_to_many :locations
  
  ## Validations
  validates :name, :presence => true
  
end
