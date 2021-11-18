class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  # update the product quantity after order created
  after_create do
  # find the order id from self.id
  line_items_belong_to_order = LineItem.all.where("order_id = #{self.id}")
  #  line_items find order id gives line item
  line_items_belong_to_order.each_with_index do |item, index|
    @quantity = Product.find_by(id: item.product_id).quantity
    Product.update(item.product_id, :quantity => (@quantity - item.quantity) )
    #Product.save!
  end

  end
  
end
