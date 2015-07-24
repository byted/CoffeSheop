class UsersController < ApplicationController
  before_filter :authorize_admin, except: [:show, :edit, :edit_me, :update ]
  before_filter :authorize 

    
  LEVELS = %w( Admin User )

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate page: params[:page], order: "login ASC"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @histories = History.where(user_id: @user.id).paginate(page: params[:page], per_page: 5).order("created_at DESC")

    #check if user is either admin or he is just looking on his own profile
    if_current_user_or_admin(@user.id) do
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def edit_me
    @user = User.find(current_user.id)
    @histories = History.where(user_id: @user.id).paginate(page: params[:page], per_page: 5).order("created_at DESC")
  end

  # GET /users/add_money
  def add_money
    @users = User.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.login} was successfully created." }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    #check whether the pw is empty to work around authlogic
    if params[:user][:password] == ''
      @user.emptypw = true
    else
      @user.emptypw = false
    end

    #filter attributes not set-able by normal users
    unless is_admin
      params[:user].delete(:level);
      params[:user].delete(:balance);
    end    
    old_balance = @user.balance

    respond_to do |format|
      if @user.update_attributes(params[:user])
      	@user.add_balance_change_to_history(params[:user][:balance].to_f - old_balance) unless params[:user][:balance].blank?
        format.html { redirect_to user_url(@user.id) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_balance
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attribute(:balance, @user.balance + params[:balance].to_f)
      	@user.add_balance_change_to_history(params[:balance].to_f)
      
        format.html { redirect_to admin_url, notice: "Updated balance for #{@user.login}: #{view_context.number_to_currency(@user.balance)}" }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_url, alert: "Could not update balance" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User #{@user.login} was successfully removed." }
      format.json { head :no_content }
    end
  end
end
