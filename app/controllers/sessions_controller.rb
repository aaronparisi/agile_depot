class SessionsController < ApplicationController
  def new
    redirect_to new_user_path if User.none?
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to admin_index_url
    else
      redirect_to login_url, notice: "Invalid user/password combo"
    end
  end

  def destroy
    session[:user_id] = nil
    #redirect_to store_index_url, notice: "Logged out"
    redirect_to login_url, notice: "Logged Out"
  end
end
