class UsergroupsController < ApplicationController
  before_filter :authorize_admin
  # GET /usergroups
  # GET /usergroups.json
  def index
    @usergroups = Usergroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usergroups }
    end
  end

  # GET /usergroups/1
  # GET /usergroups/1.json
  def show
    @usergroup = Usergroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usergroup }
    end
  end

  # GET /usergroups/new
  # GET /usergroups/new.json
  def new
    @usergroup = Usergroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usergroup }
    end
  end

  # GET /usergroups/1/edit
  def edit
    @usergroup = Usergroup.find(params[:id])
  end

  # POST /usergroups
  # POST /usergroups.json
  def create
    @usergroup = Usergroup.new(params[:usergroup])

    respond_to do |format|
      if @usergroup.save
        format.html { redirect_to @usergroup, notice: 'Usergroup was successfully created.' }
        format.json { render json: @usergroup, status: :created, location: @usergroup }
      else
        format.html { render action: "new" }
        format.json { render json: @usergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usergroups/1
  # PUT /usergroups/1.json
  def update
    @usergroup = Usergroup.find(params[:id])

    respond_to do |format|
      if @usergroup.update_attributes(params[:usergroup])
        format.html { redirect_to @usergroup, notice: 'Usergroup was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usergroups/1
  # DELETE /usergroups/1.json
  def destroy
    @usergroup = Usergroup.find(params[:id])
    @usergroup.destroy

    respond_to do |format|
      format.html { redirect_to usergroups_url }
      format.json { head :no_content }
    end
  end
end
