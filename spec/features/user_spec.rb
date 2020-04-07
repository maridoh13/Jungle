require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "password")
    expect(@user).to be_valid
  end

  it 'is not valid without a name' do
    @user = User.new(email: "test", password: "password", password_confirmation: "password")
    expect(@user).to_not be_valid
    expect(@user.errors.full_messages.first).to eq "Name can't be blank"
  end

  describe 'password' do 
    it 'is not valid without password' do
      @user = User.new(name: "test", email: "test", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password can't be blank"
    end

    it 'is not valid without password confirmation' do
      @user = User.new(name: "test", email: "test", password: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eql "Password confirmation can't be blank"
    end

    it 'is not valid with a password confirmation different from the password' do
      @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "PASSWORD")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end

    it 'is not valid with a password of less than 5 characters' do
      @user = User.new(name: "test", email: "test", password: "pwd", password_confirmation: "pwd")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Password is too short (minimum is 5 characters)"
    end
  end

  describe 'email' do
    it 'is not valid without an email' do
      @user = User.new(name: "test", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages.first).to eq "Email can't be blank"
    end

    it 'is not valid with an already existing email address' do
      @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @new_user = User.new(name: "test2", email: "test", password: "password", password_confirmation: "password")
      expect(@new_user).to_not be_valid
    end

    it 'is not valid with the same email but different cases' do
      @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @new_user = User.new(name: "test2", email: "TEST", password: "password", password_confirmation: "password")
      expect(@new_user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'is valid with the correct attributes' do
      @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @user2 = User.authenticate_with_credentials('test', 'password')
      expect(@user2).to_not be nil
    end

    it 'is not valid with a non existing email' do
      @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @user2 = User.authenticate_with_credentials('email', 'password')
      expect(@user2).to be nil
    end

    it 'is not valid with an incorrect password' do
      @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @user2 = User.authenticate_with_credentials('test', 'wrong_password')
      expect(@user2).to be nil
    end

    it 'is valid with an email with spaces around' do
      @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @user2 = User.authenticate_with_credentials('  test   ', 'password')
      expect(@user2).to_not be nil
    end

    it 'is valid with an email with different cases' do
      @user = User.new(name: "test", email: "test", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
      @user.save
      @user2 = User.authenticate_with_credentials('TEsT', 'password')
      expect(@user2).to_not be nil
    end
  end
end