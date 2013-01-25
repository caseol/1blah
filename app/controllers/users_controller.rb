class UsersController < ApplicationController
  def index
    redirect_to new_user_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, flash.now[:notice] => "Obrigado por se cadastrar!"
    else
      render "new"
    end
  end

  def ranking
    @ranking_publicadores = User.ranking_publicadores
    @ranking_tocadores    = User.ranking_tocadores
    @ranking_media_toques = User.ranking_media_toques

    respond_to do |format|
      format.html # ranking.html.erb
      format.json { render :json => [@ranking_publicadores, @ranking_tocadores, @ranking_media_toques] }
    end
  end
end
