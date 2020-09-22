class ErrorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_mailer.error_thrown.subject
  #
  def error_thrown(msg)
    @msg = msg
    @greeting = "Hi Aaron,"

    mail to: "aarons.coding.stuff@gmail.com", subject: "Error: #{@msg}"
  end
end
