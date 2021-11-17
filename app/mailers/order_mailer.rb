class OrderMailer < ApplicationMailer
  #order receipt
  default from: 'notifications@example.com'

  def order_receipt_email(order)
    @order = order
    mail(to: @order.email, subject: `Order receipt for # #{@order.id}`)
  end
  #order receipt
end
