class AuthenticationsController < ApplicationController
  # GET /authentications
  # GET /authentications.json
  def index
    @authentications = Authentication.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authentications }
    end
  end

  # POST /authentications
  # POST /authentications.json
  def create
    # the omniauth hash is defined in the callback from facebook
    omniauth = request.env["omniauth.auth"]
    # finds if there is an authentication from earlier, with the same provider and uid
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication # if the authentication exists the user is signed in
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user # if this authentication is the current_user then this authentication is added to authentications, not used at the moment but possible to add other providers
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else # if it does not exist the user is created by calling the apply_omniauth method
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
  
  # DELETE /authentications/1
  # DELETE /authentications/1.json
  
  # not used at the moment, but later it can be used to remove authentications 
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication"
    redirect_to root_path
  end
  
  protected

  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end
end
