class OrderMailer < ApplicationMailer
  #order receipt

  def order_receipt_email(order)
    @order = order
    @line_items_belong_to_order = LineItem.all.where("order_id = #{@order.id}")
    mail(to: @order.email, subject: `Order receipt for # #{@order.id}`)
  end
  #order receipt
end
