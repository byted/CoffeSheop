class UserSessionsController < ApplicationController
  before_filter :authorize_admin, :except => [:new, :create, :destroy, :ask_pin, :verify]
  # GET /user_sessions/new
  # GET /user_sessions/new.json
  def new
    @user_session = UserSession.new
    @users = User.all
  end

  def ask_pin

  end

  def verify
    if current_user.valid_password?(params[:password])
      session[:pin_entered] = true
      redirect_to admin_path
    else
      redirect_to :ask_pin
    end
  end

  # POST /user_sessions
  # POST /user_sessions.json
  def create
    # if the user has no password set, create a new session from just the login-name (workaround for authlogic)
    if User.find_by_login(params[:user_session][:login]).emptypw == true
      @user_session = UserSession.new(User.find_by_login(params[:user_session][:login]))
      session[:pin_entered] = false
    else
      @user_session = UserSession.new(params[:user_session])
      session[:pin_entered] = true
    end

    respond_to do |format|
      if @user_session.save
        format.html { redirect_to :store }
        format.json { render json: @user_session, status: :created, location: @user_session }
      else
        format.html { redirect_to root_url, alert: "Could not login. Check PIN" }
        format.json { render json: @user_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    # also destroy the user's cart!
    current_cart.destroy
    session[:pin_entered] = false

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end 
end
