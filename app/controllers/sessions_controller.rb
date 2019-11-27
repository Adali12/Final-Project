class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_users_path
        flash[:notice] = 'Welcome administrator'
      elsif user.mentor?
        redirect_to mentor_users_path(user.id)
        flash[:notice] = 'Welcome mentor pages'
      else
        flash[:notice] = 'welcome to sessions !'
      redirect_to users_path(user.id)
    end
    else
      flash[:notice] = 'Invalid email or password'
      render 'new'
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'You logged out'
    redirect_to new_session_path
  end
end
