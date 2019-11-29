class Mentor::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all
    @profiles= Profile.all
  end
  def show
  end
  def new
    @user = User.new
  end
  def edit
  end
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id]= @user.id
        redirect_to mentor_users_path(@user), notice: 'User was successfully created.'
      else
        render :new
      end
    end
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.' 
      else
        render :edit
      end
    end
  end
  def destroy
    @user.destroy
    respond_to do |format|
    redirect_to users_url, notice: 'User was successfully destroyed.' 
    end
  end
  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:firstName, :lastName, :email, :address, :bio, :occupation, :expertise, :admin, :mentor, :password, :password_confirmation)
    end
end
