class VisitsController < ApplicationController
  # GET /visits
  # GET /visits.json
  def index
    @visits = Visit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @visits }
    end
  end

  def count_visit
    now = DateTime.now.to_i

    if session[:user_id]
      user_id = session[:user_id]
    else
      user_id = 0
    end

    @visit = Visit.find_or_create_by_user_id(user_id)
    count = @visit.count

    if (session[:last_click] && session[:last_click] < (now - 60*5)) || !session[:last_click]
      if count
        @visit.count=count+1
      else
        @visit.count=1
      end
      @visit.save
      session[:last_click] = DateTime.now.to_i
    end
    @visit

    #respond_to do |format|
    #  format.html { render :text => "Aqui" }
    #  format.json { render :json => @visit, :status => :created, :location => @visit }
    #end
  end
end
