class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:notice]  = "Email/password is invalid" 
      redirect_to signup_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end