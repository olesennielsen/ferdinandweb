# this model is used to authorize the designers for the app
# the admin role are not used at the moment but can easily be implemented

class Ability
  include CanCan::Ability
  
  def initialize(designer)
    designer ||= Designer.new 
    
    can [:index, :show], Campaign, :published => true
    can [:new, :create], Company
    can [:new, :create], Designer
    can [:new, :create], User
    
    if designer.role == 0 # Admin
      can :manage, :all
          
    elsif designer.role == 1 # Company Admin can create and invite new designers
      can :manage, Designer, :company_id => designer.company.id
      can :manage, Company, :id => designer.company.id
      can [:new, :create], Campaign
      can [:new, :create], Pageobject 
      can [:index, :show, :edit, :update, :destroy, :publish, :add_new_page], Campaign, :company_id => designer.company.id
      @campaigns = Campaign.where(:company_id => designer.company.id)
      @pages = []
            
      @campaigns.each do |campaign|
        can :manage, Page, :campaign_id => campaign.id
        @pages_tmp = Page.where(:campaign_id => campaign.id)
        
        @pages_tmp.each do |tmp|
          @pages.push(tmp)
        end
      end
      
      @pages.each do |page|
        can :manage, Pageobject, :page_id => page.id
      end      
       
    elsif designer.role == 2 # Designer, can create new campaigns and edit them
      can :manage, Designer, :id => designer.id
      can [:new, :create], Pageobject
      can [:new, :edit, :create, :update, :destroy], Campaign, :company_id => designer.company.id
      @campaigns = Campaign.where(:company_id => designer.company.id)
      @pages = []
            
      @campaigns.each do |campaign|
        can :manage, Page, :campaign_id => campaign.id
        @pages_tmp = Page.where(:campaign_id => campaign.id)
        
        @pages_tmp.each do |tmp|
          @pages.push(tmp)
        end
      end
      
      @pages.each do |page|
        can :manage, Pageobject, :page_id => page.id
      end
      
    end
  end
end
