# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def generate_share_code
      characters = 'a b c d e f g h i j k l m n o p q r s t u v x w y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9'
      characterArray = characters.split

      button = true
      random = ''
      while button
        random = "#{Array.new(10){characterArray[rand(62)-1]}.join}"
        button = Button.find_by_share_code(random)
      end
      random
  end
  
  def update_button_with_share_code
    @buttons = Button.all
    @buttons.each do |button|
      button.share_code=generate_share_code
      button.save
    end
    render :text => "FIM"
  end

  def generate_nickname
    result=''
    @users = User.all
    @users.each do |user|
      nickname = user.email.split("@")[0]
      user.nickname=nickname
      if user.save(:validate => false)
        result.concat "#{user.email} - OK<br />"
      else
        result.concat "#{user.email} - NOK<br />"
      end
    end
    render :text => "#{result}FIM"
  end

  def teste
    render :text => "Locale: #{extract_locale_from_accept_language_header} - #{request.env["HTTP_REFERER"]} - #{request.env["HTTP_USER_AGENT"]}"
  end

  private

  # Rails Request.env Variables
  # SERVER_NAME
  # PATH_INFO
  # REMOTE_HOST
  # HTTP_ACCEPT_ENCODING
  # HTTP_USER_AGENT
  # SERVER_PROTOCOL
  # HTTP_CACHE_CONTROL
  # HTTP_ACCEPT_LANGUAGE
  # HTTP_HOST
  # REMOTE_ADDR
  # SERVER_SOFTWARE
  # HTTP_KEEP_ALIVE
  # HTTP_REFERER
  # HTTP_COOKIE
  # HTTP_ACCEPT_CHARSET
  # REQUEST_URI
  # SERVER_PORT
  # GATEWAY_INTERFACE
  # QUERY_STRING
  # REMOTE_USER
  # HTTP_ACCEPT
  # REQUEST_METHOD
  # HTTP_CONNECTION

  def set_locale
    #I18n.locale = params[:locale] if params[:locale].present?
    if params[:locale]
      I18n.locale = params[:locale]
      session[:locale] = params[:locale]
    else
      if session[:locale]
        I18n.locale = session[:locale]
      else
        I18n.locale = current_locale
      end
    end

    # current_user.locale
    # request.subdomain
    # request.env["HTTP_ACCEPT_LANGUAGE"]
    # request.remote_ip
  end

  def current_locale
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
  helper_method :current_locale

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def authorize
    redirect_to login_url, :alert => t("messages.not_authorized") if current_user.nil?
  end
end
