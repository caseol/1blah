# coding: utf-8
class ButtonsController < ApplicationController
  before_filter :authorize, :only=> [:new, :edit, :update, :favorites, :private]
  before_filter :verify_owner, :only=> [:show, :edit, :update]

  # GET /buttons
  # GET /buttons.json
  def index
    @category = nil
    order = params[:order] || "DESC"
    if params[:search] && !params[:search].to_s.empty?
      @buttons = Button.where("title like ? or description like ?", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page])
    else
      if params[:category]
        @category = Category.find_by_name(params[:category].gsub("+", " "))
        if @category
          @buttons = Button.page(params[:page]).order("created_at #{order}").find_all_by_category_id(@category.id)
        else
          @buttons = Button.where("title like ? or description like ?", "%#{params[:category]}%", "%#{params[:category]}%").page(params[:page])
        end
      else
        @buttons = Button.page(params[:page]).order("created_at #{order}").all
      end
    end

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render :json => @buttons }
    #end
  end

  # GET /buttons/1
  # GET /buttons/1.json
  def show
    @button = Button.find(params[:id])
    #gon.button = @button

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @button }
    end
  end

  # GET /buttons/new
  # GET /buttons/new.json
  def new
    @button = Button.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @button }
    end
  end

  # GET /buttons/1/edit
  def edit
    @button = Button.find(params[:id])
  end

  # POST /buttons
  # POST /buttons.json
  def create
    @button = Button.new(params[:button])
    @button.user_id=session[:user_id]
    @button.share_code=generate_share_code
    respond_to do |format|
      if @button.save
        format.html { redirect_to @button, :notice => t("messages.button_created") }
        format.json { render :json => @button, :status => :created, :location => @button }
      else
        format.html { render :action => "new" }
        format.json { render :json => @button.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /buttons/1
  # PUT /buttons/1.json
  def update
    @button = Button.find(params[:id])

    respond_to do |format|
      if @button.update_attributes(params[:button])
        format.html { redirect_to @button, :notice => t("messages.button_edited") }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @button.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /buttons/1
  # DELETE /buttons/1.json
  def destroy
    @button = Button.find(params[:id])
    @button.destroy

    respond_to do |format|
      format.html { redirect_to buttons_url }
      format.json { head :no_content }
    end
  end

  # Not RESTFUL Methods
  def count_play
      if params[:button_id]
        @count = Count.find_or_create_by_button_id(params[:button_id])
        value = @count.value

        if value
          @count.value=value+1
        else
          @count.value=1
        end
        @count.save

        respond_to do |format|
          format.html { render :text => "Button counted: #{@count.value}" }
          format.json { render :json => @count, :status => :ok}
        end
      end
  end

  def best_ever
    order = params[:order] || "DESC"
    @buttons = Button.por_mais_tocados(order).page(params[:page])
    respond_to do |format|
      format.html { render "index.html.erb" }
      format.json { render :json => @buttons, :status => :created}
    end
  end

  def favorites
    @buttons = Button.favoritos(session[:user_id]).page(params[:page])
    respond_to do |format|
      format.html { render "index.html.erb" }
      format.json { render :json => @buttons, :status => :created}
    end
  end

  def manage_favorite
    if !params[:button_id].nil? && session[:user_id]
      @button = Button.find(params[:button_id])
      if @button.is_favorite(session[:user_id])
        @favorite = Favorite.where("user_id = ? && button_id = ?",session[:user_id], params[:button_id]).first
        @favorite.destroy
      else
        @favorite = Favorite.new(:user_id => session[:user_id], :button_id => params[:button_id])
        @button.favorites << @favorite
        @button.save
      end
      respond_to do |format|
        format.html { render :text => "Button Favorite Status Changed: #{@button.title}" }
        format.json { render :json => @button, :status => :ok}
      end
    else
      respond_to do |format|
        format.html { head :no_content }
        format.json { head :no_content }
      end
    end
  end

  def view
    @button = Button.find_by_share_code(params[:b])

    respond_to do |format|
      format.html # view.html.erb
      format.json { render :json => @button }
    end
  end

  def private
    @buttons = Button.find_all_by_user_id(session[:user_id])

    respond_to do |format|
      format.html # private.html.erb
      format.json { render :json => @buttons }
    end
  end

  def verify_owner
    @button = Button.find(params[:id])
    if (@button.user.id != session[:user_id])
      redirect_to root_url, :alert => "Não Autorizado"
    end
  end
end
