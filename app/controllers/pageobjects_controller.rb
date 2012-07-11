class PageobjectsController < ApplicationController
  # stock scaffold controller 
  
  load_and_authorize_resource
  
  # GET /pageobjects
  # GET /pageobjects.json
  def index
    @pageobjects = Pageobject.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pageobjects }
    end
  end

  # GET /pageobjects/1
  # GET /pageobjects/1.json
  def show
    #@pageobject = Pageobject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pageobject }
    end
  end

  # GET /pageobjects/new
  # GET /pageobjects/new.json
  def new
    #@pageobject = Pageobject.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pageobject }
    end
  end

  # GET /pageobjects/1/edit
  def edit
    #@pageobject = Pageobject.find(params[:id])
  end

  # POST /pageobjects
  # POST /pageobjects.json
  def create
    #@pageobject = Pageobject.new(params[:pageobject])

    respond_to do |format|
      if @pageobject.save
        format.html { redirect_to edit_campaign_path(Campaign.find(@pageobject.page.campaign.id), :page_number => @pageobject.page.number), notice: 'Pageobject was successfully created.' }
        format.json { render json: @pageobject, status: :created, location: @pageobject }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @pageobject.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /pageobjects/1
  # PUT /pageobjects/1.json
  def update
    #@pageobject = Pageobject.find(params[:id])

    respond_to do |format|
      if @pageobject.update_attributes(params[:pageobject])
        format.html { redirect_to @pageobject, notice: 'Pageobject was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pageobject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pageobjects/1
  # DELETE /pageobjects/1.json
  def destroy
    #@pageobject = Pageobject.find(params[:id])
    @pageobject.destroy

    respond_to do |format|
      format.html { redirect_to pageobjects_url }
      format.json { head :ok }
    end
  end
end
