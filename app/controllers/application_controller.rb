class ApplicationController < ActionController::Base
rescue_from ActiveRecord::RecordNotFound, with: :email_admin
rescue_from ActiveRecord::ActiveRecordError, with: :email_admin
rescue_from StandardError, with: :email_admin

# private

def email_admin(e)
  ErrorMailer.error_thrown(e.message).deliver_later
  render 'shared/mistake'
end

end
