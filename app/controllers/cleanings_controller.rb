class CleaningsController < ApplicationController
  before_filter :authorize_admin, :except => [ :howto, :create ]
  before_filter :authorize

  def howto

  end

  # GET /cleanings
  # GET /cleanings.json
  def index
    @cleanings = Cleaning.paginate page: params[:page], order: "created_at DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cleanings }
    end
  end

  # GET /cleanings/1
  # GET /cleanings/1.json
  def show
    @cleaning = Cleaning.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cleaning }
    end
  end

  # GET /cleanings/new
  # GET /cleanings/new.json
  # def new
  #   @cleaning = Cleaning.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @cleaning }
  #   end
  # end

  def new
    @users = User.all
  end

  # POST /cleanings
  # POST /cleanings.json
  def create
    unless params[:id].blank?
      user = User.find(params[:id])
    else
      user = current_user
    end
    @cleaning = Cleaning.new({ user_id: user.id })
    user.bonus_points += Settings['gui.points_for_cleaning'].to_i 
    user.save

    Settings.coffees_since_last_clean_up = 0

    respond_to do |format|
      if @cleaning.save
        format.html { redirect_to store_url, notice: "Thank you for cleaning!" }
        format.json { render json: @cleaning, status: :created, location: @cleaning }
      else
        format.html { render action: "new" }
        format.json { render json: @cleaning.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cleanings/1
  # DELETE /cleanings/1.json
  def destroy
    @cleaning = Cleaning.find(params[:id])
    @cleaning.destroy

    respond_to do |format|
      format.html { redirect_to cleanings_url }
      format.json { head :no_content }
    end
  end
end
