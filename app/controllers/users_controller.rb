class UsersController < ApplicationController

  before_filter :authenticate, :only => [:edit, :update, :index]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy  
  
  
  def show
    @user = User.find(params[:id])
   # @title = @user.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new
    @title = "Sign up"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @title = "Edit User"
  end

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
    @users = User.paginate(:page => params[:page])
  end
  

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end
  
  private

  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
     
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
       
     
end


