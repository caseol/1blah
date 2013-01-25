class SessionsController < ApplicationController
  def index
    render "new"
  end

  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = t("messages.session_created")
      redirect_to root_url
    else
      flash.now[:alert] = t("messages.invalid_login")
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = t("messages.session_ended")
    redirect_to root_url
  end
end
