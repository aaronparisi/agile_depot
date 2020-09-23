class UserMailer < ApplicationMailer
  def reset(user)
    mail to: user.email, subject: "Password Reset"
  end
  
end
