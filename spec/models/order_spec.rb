require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      cat1 = Category.find_or_create_by! name: 'Evergreens'
      @product1 = cat1.products.create!(
        name: "product1",
        description: "product1_description",
        image: "product1_image",
        price_cents: 100,
        quantity: 2
      )
      @product2 = cat1.products.create!(
        name: "product2",
        description: "product2_description",
        image: "product2_image",
        price_cents: 100,
        quantity: 2
      )
      # Setup at least one product that will NOT be in the order
      @product3 = cat1.products.create!(
        name: "product3",
        description: "product3_description",
        image: "product3_image",
        price_cents: 100,
        quantity: 2
      )
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: "test@gmail.com",
        total_cents: 100,
        stripe_charge_id: "ch_3M7TguEbmWgZt87o0QHOKhOm", # mimicking a confirmation from stripe
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price
      )
      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product2.price,
        total_price: @product2.price
      )
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eql(1);
      expect(@product2.quantity).to eql(1);
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      @product3.reload
      expect(@product3.quantity).to eql(2);
    end
  end
end
