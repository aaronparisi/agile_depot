require 'byebug'
class ApplicationController < ActionController::Base
# rescue_from ActiveRecord::RecordNotFound, with: :email_admin
# rescue_from ActiveRecord::ActiveRecordError, with: :email_admin
# rescue_from StandardError, with: :email_admin

  before_action :authorize
  AUTHORIZE_CONTROLLER_EXCEPTIONS = ['store', 'carts', 'line_items', 'sessions']

# private

  def email_admin(e)
    ErrorMailer.error_thrown(e.message).deliver_later
    render 'shared/mistake'
  end

  protected

  def authorize
    unless exception?
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "You must be logged in to access admin pages"
      end
    end
  end

  private
  
  def exception?
    AUTHORIZE_CONTROLLER_EXCEPTIONS.include?(params[:controller]) ||
    (params[:controller] == "users" && params[:action] == "new") ||
    (params[:controller] == "users" && params[:action] == "create")

  end
  

end
