require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    category = Category.new(name: "Furniture")
    product = Product.new(name: "Red sofa", price: 5460, quantity: 20, category: category)

    it 'should valid' do
      expect(product).to be_valid
    end

    it "should have a name" do
      product.name = nil
      expect(product).to_not be_valid
      expect(product.errors.messages[:name]).to eq ["can't be blank"]
    end

    it "should have a price" do
      product.price_cents = nil
      expect(product).to_not be_valid
      expect(product.errors.messages[:price]).to eq ["is not a number", "can't be blank"]
    end

    it "should have quantity" do
      product.quantity = nil
      expect(product).to_not be_valid
      expect(product.errors.messages[:quantity]).to eq ["can't be blank"]
    end

    it "should have category" do
      product.category = nil
      expect(product).to_not be_valid
      expect(product.errors.messages[:category]).to eq ["can't be blank"]
    end
  end
end