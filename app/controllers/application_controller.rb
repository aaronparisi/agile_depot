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
    case request.format
    when Mime[:html]
      do_auth unless no_auth?
    else
      authenticate_or_request_with_http_basic do |username, password|
        # username == "fred" && password == "word"
        aUser = User.find_by(name: username)
        if aUser.try(:authenticate, password)
          true
        else
          redirect_to login_url, notice: "Bad boy"
        end
      end
    end
  end
  

  private

  def do_auth
    redirect_to login_url, notice: "You must be logged in to access admin pages"
  end
  
  def no_auth?
    AUTHORIZE_CONTROLLER_EXCEPTIONS.include?(params[:controller]) ||
    (params[:controller] == "users" && params[:action] == "new") ||
    (params[:controller] == "users" && params[:action] == "create") ||
    logged_in_already?
  end

  def logged_in_already?
    # debugger
    User.find_by(id: session[:user_id])
  end

end
