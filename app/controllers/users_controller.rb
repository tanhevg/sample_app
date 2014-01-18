class UsersController < ApplicationController
  before_action :not_signed_in_user, only: [:new, :create]
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Ruby Sample"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success]="Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.admin?
      flash[:error] = "Cannot delete admin user"
    else
      user.destroy
      flash[:success] = "User deleted."
    end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def not_signed_in_user
      if signed_in?
        redirect_to root_url
      end
    end

    def signed_in_user
      unless signed_in?
        store_location 
        redirect_to signin_url, notice: "Please sign in."  
      end
    end

    def correct_user
      @user=User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
