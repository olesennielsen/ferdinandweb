class Company < ActiveRecord::Base
  # Relations
  has_many :campaigns
  has_and_belongs_to_many :users
  has_many :designers
  
  # Validations
  validates :name, :presence => true, :uniqueness => true
  
  
  # method to get the latest campaign by a company used in favorites and recommendations
  def get_latest_campaign
    return Campaign.where(:company_id => self.id, :published => true).order('publication_date DESC').first
  end 
    
end
