class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_admin_user!
  def ensure_admin_user!
  unless current_user and current_user.admin?
    redirect_to root_path, notice:"you are not admin, ask for help?"
  end
  end
def index  
User.find_each do |user|
    @users = User.all  
end
@search=User.search(params[:q])
if params[:q]
@users=@search.result
end
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
        format.html { redirect_to admin_users_path(@user), notice: 'User was successfully created.' }
        format.json { render :index, status: :created, location: admin_users_path(@user) }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
  if params[:mentor]
    @user.update(mentor: params[:mentor])
      redirect_to admin_user_path(@user), notice: 'user changed'
  elsif @user.update(user_params)
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :index, status: :ok, location: admin_user_path(@user) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
    
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
     redirect_to admin_users_path, notice: 'User was successfully destroyed.'  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstName, :lastName, :email, :address, :bio, :occupation, :expertise, :admin, :mentor, :password, :password_confirmation)
    end
end
