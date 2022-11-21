require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'adds a product to the database when all fields are filled in' do
      category = Category.create(name: "test category")
      product = category.products.create!(
                              name: "test product name", 
                              description: "test product description", 
                              image: "test image", 
                              price_cents: 100, 
                              quantity: 1
                              )
      expect(product.id).not_to be_nil
    end

    it 'does not add the product and displays the right error when name is omitted' do
      begin
        category = Category.create(name: "test category")
        product = category.products.new( 
                                name: nil,
                                description: "test product description", 
                                image: "test image", 
                                price_cents: 100, 
                                quantity: 1
                                )
        product.save!
      rescue
        expect(product.errors.full_messages).to include("Name can't be blank")
      ensure
        expect(product.id).to be_nil
      end
    end

    it 'does not add the product and displays the right error when price is omitted' do
      begin
        category = Category.create(name: "test category")
        product = category.products.new( 
                                name: "test",
                                description: "test product description", 
                                image: "test image", 
                                quantity: 1
                                )
        product.save!
      rescue
        expect(product.errors.full_messages).to include("Price can't be blank")
      ensure
        expect(product.id).to be_nil
      end
    end

    it 'does not add the product and displays the right error when quantity is omitted' do
      begin
        category = Category.create(name: "test category")
        product = category.products.new( 
                                name: "test",
                                description: "test product description", 
                                image: "test image",
                                price_cents: 100
                                )
        product.save!
      rescue
        expect(product.errors.full_messages).to include("Quantity can't be blank")
      ensure
        expect(product.id).to be_nil
      end
    end

    it 'does not add the product and displays the right error when Category is omitted' do
      begin
        category = Category.create(name: "test category")
        product = Product.new( 
                                name: "test",
                                description: "test product description", 
                                image: "test image",
                                price_cents: 100,
                                quantity: 1
                                )
        product.save!
      rescue
        expect(product.errors.full_messages).to include("Category can't be blank")
      ensure
        expect(product.id).to be_nil
      end
    end
  end
end
