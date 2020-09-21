class OrderMailer < ApplicationMailer
  default from: 'Aaron Parisi <aarons.coding.stuff@gmail.com>'
  default to: 'Aaron Parisi <parisi.aaron@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(order)
    @order = order
    @greeting = "Dear #{@order.name}"

    mail to: order.email, subject: 'Thank you for your order!'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order
    @greeting = "Dear #{@order.name}"

    mail to: order.email, subject: 'Your Depot order has shipped!'
  end
end
