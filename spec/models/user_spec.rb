require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    user = User.new(name: "Michel Motongi", email: "MichelMotongi@gmail.com", password: "password", password_confirmation: "password")

    it 'should valid' do
      expect(user).to be_valid
    end

    it "should have password confirmation" do
        user.password_confirmation = "password"
        expect(user).to be_valid
    end
    it "doesn't create a user without password or password_confirmation" do
        @user = User.new(name: "Michel Motongi", email: "MichelMotongi@gmail.com", password: "", password_confirmation: "")
        @user.save
        expect(@user.errors.messages[:password_confirmation]).to eq ["can't be blank"]
    end

    it "doesn't create a user without a name" do
        @user = User.new(name: "", email: "MichelMotongi@gmail.com", password: "password", password_confirmation: "password")
        @user.save
        expect(@user.errors.messages[:name]).to eq ["can't be blank"]
    end

    it "doesn't create a user without an email" do
        @user = User.new(name: "Michel Motongi", email: "", password: "password", password_confirmation: "password")
        @user.save
        expect(@user.errors.messages[:email]).to eq ["can't be blank"]
    end
    
    it "has a password longer than the minimum lenght requirement" do
        @user = User.new(name: "Michel Motongi", email: "MichelMotongi@gmail.com", password: "1234", password_confirmation: "1234")
        @user.save
        expect(@user.errors.messages[:password]).to eq ["is too short (minimum is 5 characters)"]
    end

    it "should have a name" do
      user.name = "Michel Motongi"
      expect(user).to be_valid
    end
  end

  
  describe '.authenticate_with_credentials' do
    it "authenticates the user based on email address and password" do
      @user = User.new({name: 'Michel Motongi', email: 'michelmotongi@gmail.com', password: '12345', password_confirmation: '12345'})
      @user.save
      expect(User.authenticate_with_credentials('michelmotongi@gmail.com', '12345')).to eq @user
    end

    it "authenticates the user even if the user types in spaces before/after their email" do
      @user = User.new({name: 'Michel Motongi', email: 'michelmotongi@gmail.com', password: '12345', password_confirmation: '12345'})
      @user.save
      expect(User.authenticate_with_credentials(' michelmotongi@gmail.com  ', '12345')).to eq @user
    end
    
    it "authenticates the user even if the user types in the wrong case for their email" do
      @user = User.new({name: 'Michel Motongi', email: 'michelmotongi@gmail.com', password: '12345', password_confirmation: '12345'})
      @user.save
      expect(User.authenticate_with_credentials('MICHELmotongi@gmail.com', '12345')).to eq @user
    end
  end
end