class FerdinandStartController < ApplicationController
  # controller used for the index page and the showcases
  
  def index
    if designer_signed_in?
      flash.keep
      redirect_to campaigns_path      
    elsif user_signed_in?
      redirect_to campaigns_path
    else
      @published_campaigns = Campaign.where(:published => true).order('publication_date DESC')
    end  
  end
  
  def three_latest
    @campaigns = Campaign.where(:published => true).order("publication_date DESC").limit(3)
  end
  
  def object_showcase
    
  end
end
