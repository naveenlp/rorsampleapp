class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :non_signed_in_user, only: [:create, :new]
  
  def new 
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
     @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
  	@user = User.new(params[:user])
    if @user.save
    	sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Successfully updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end


  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    user = User.find(params[:id])
    if(!user.admin?)
      user.destroy
      flash[:success] = "User destroyed."
    else
      flash[:notice] = "Cannot delete admin user!"
    end
    redirect_to users_url
  end


  private

    def non_signed_in_user
      redirect_to root_path, notice: "You have already signed in!" if signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: "You are not authorized!" unless current_user?(@user)
    end

     def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
