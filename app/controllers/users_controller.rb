class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  before_filter :authenticate, :only => [:edit, :update, :index]
  before_filter :correct_user, :only => [:edit, :update,]  
  
  
#  def index
#    @users = User.all

#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @users }
#    end
#  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
   # @title = @user.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    @title = "Sign up"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = "Edit User"
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    if @user.save
       sign_in @user
       flash[:success] = "Welcome to John's Movies. Again."
       redirect_to @user
    else
       @title = "Sign Up"
       render "new"
      end
   
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end

  def index
    @title = "All Users"
    @users = User.all
  end
  
  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  private

  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
     
end


