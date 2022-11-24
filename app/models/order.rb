class Order < ApplicationRecord
  
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :adjust_inventory

  def adjust_inventory
    self.line_items.each do |item|
      inventory = item.product.quantity
      order_quantity = item.quantity
      item.product.update(quantity: inventory - order_quantity)
    end
  end

end
