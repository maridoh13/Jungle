require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      @category = Category.new
      @product = Product.new(name: 'Socks', price: 1000, quantity: 5, category: @category)
      expect(@product).to be_valid
    end

    it 'is not valid without a name' do
      @category = Category.new
      @product = Product.new(price: 1000, quantity: 5, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Name can't be blank"
    end

    it 'is not valid without a price' do
      @category = Category.new
      @product = Product.new(name: 'Socks', quantity: 5, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.second).to eq "Price is not a number"
    end

    it 'is not valid without a quantity' do
      @category = Category.new
      @product = Product.new(name: 'Socks', price: 1000, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Quantity can't be blank"
    end

    it 'is not valid without a category' do
      @category = Category.new
      @product = Product.new(name: 'Socks', price: 1000, quantity: 5)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Category can't be blank"
    end
  end
end