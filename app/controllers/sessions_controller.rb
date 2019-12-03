class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    totp = ROTP::TOTP.new(user.token) if user
    if user && user.authenticate(params[:password]) && totp.now.eql?(params[:authentication_code])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash[:alert] = "Email, password or authentication_code wrong"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
