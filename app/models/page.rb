class Page < ActiveRecord::Base
  belongs_to :campaign
  has_many :pageobjects, :dependent => :destroy
  
  validates :number, :presence => true
  
  # used to get the pageobjects for a page
  def get_objects
    return self.pageobjects
  end
end
