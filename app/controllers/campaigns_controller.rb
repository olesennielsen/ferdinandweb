# this controller is not authorized, but each controller action is authorized  

class CampaignsController < ApplicationController  
  # GET /campaigns
  # GET /campaigns.json
  def index
    # gathering the information for the campaigns/index.html.erb 
    if designer_signed_in?
      @campaigns = Campaign.where(:company_id => current_designer.company_id)
    else
      @campaigns = Campaign.where(:published => true)
    end   
    
    if user_signed_in?
      # the user's favorite companies are fetched from the database
      @companies = current_user.companies
      
      # the recommendations are fetched as facebook friends' favorite companies latest campaigns
      @recommended_companies = []
      users = User.all      
      
      # get the user's friends
      me = FbGraph::User.me current_user.authentications.where(:provider => :facebook).first.token
      @friends = me.friends     

      # for each friend and each user if the friend's and user's uid is the same the companies are added to the @recommended_companies array
      # can be seriously optimized
      @friends.each do |friend|
        users.each do |user|
          if friend.identifier == user.authentications.where(:provider => :facebook).first.uid
            tmp_companies = user.companies
            tmp_companies.each do |tmp_comp|
              @recommended_companies.push([tmp_comp, friend.name])
            end
          end
        end          
      end      
    end
    
    
    
    @json_campaigns = @campaigns.collect do |campaign|
      {:name => campaign.name, :company_name => campaign.company.name, :latitude => params[:lat], :longitude => params[:long]}
    end    
    
    respond_to do |format|
      format.html # index.html.erb      
      format.json { render json: @json_campaigns }
    end
    
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show    
    @campaign = Campaign.find(params[:id])
    @pages = Page.where(:campaign_id => @campaign.id)
    
    authorize! :show, @campaign
    # the count of number of hits
    if @campaign.published
      if @campaign.num_of_hits == nil
        @campaign.update_attribute(:num_of_hits, 1)
      else
        @campaign.update_attribute(:num_of_hits, @campaign.num_of_hits+1)
      end      
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campaign }
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.json
  def new    
    @campaign = Campaign.new    
    
    authorize! :new, @campaign
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campaign }
    end
  end

  # GET /campaigns/1/edit
  def edit
    
    @campaign = Campaign.find(params[:id])
    @pages = Page.where(:campaign_id => @campaign)
    
    authorize! :edit, @campaign
    
    if (params[:page_number])
      @page = Page.where(:campaign_id => @campaign, :number => params[:page_number]).first
    end
    
  end

  # POST /campaigns
  # POST /campaigns.json
  def create    
    @campaign = Campaign.new(params[:campaign])
    authorize! :create, Campaign
    respond_to do |format|
      if @campaign.save
        @page = Page.new(:number => 1, :campaign_id => @campaign.id)
        @page.save
        format.html { redirect_to edit_campaign_path(@campaign.id, :page_number => 1), notice: 'Campaign was successfully created.' }
        format.json { render json: @campaign, status: :created, location: @campaign }
      else
        format.html { render action: "new" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.json
  def update
    
    @campaign = Campaign.find(params[:id])
    authorize! :update, @campaign
    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    
    @campaign = Campaign.find(params[:id])
    authorize! :destroy, @campaign
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to campaigns_url }
      format.json { head :ok }
    end
  end
  
  def publish
    
    @campaign = Campaign.find(params[:id])
    
    authorize! :publish, @campaign
    if @campaign.published
      @campaign.update_attribute(:published, false)
      @campaign.update_attribute(:publication_date, nil)
    else
      @campaign.update_attribute(:published, true)
      @campaign.update_attribute(:publication_date, Date.today)
    end    
    redirect_to :back     
  end
  
  def add_new_page
    @campaign = Campaign.find(params[:id])
    authorize! :add_new_page, @campaign
    
    @pages = Page.where(:campaign_id => @campaign.id)
    
     @page = Page.new(:number => @pages.count + 1, :campaign_id => @campaign.id)
     @page.save
     
     redirect_to edit_campaign_path(@campaign.id, :page_number => @page.number)    
  end
  
  def make_favorite
    current_user.companies << Company.find(params[:company_id]) unless current_user.companies.include?(Company.find(params[:company_id]))
    redirect_to :back    
  end
end
