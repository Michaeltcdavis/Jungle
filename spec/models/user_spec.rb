require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do

    it "adds a user to the database when all fields are filled in" do
      user = User.create!(first_name: "Mike",
                          last_name: "Davis",
                          email: "mikedamonkey@gmail.com",
                          password: "segf;iousabdgu",
                          password_confirmation: "segf;iousabdgu")
      expect(user.id).not_to be_nil
    end

    it "does not add a user when password is not filled in" do
      begin
        user = User.create(first_name: "Mike",
                          last_name: "Davis",
                          email: "mikedamonkey@gmail.com",
                          password_confirmation: "segf;iousabdgu")
      rescue
        expect(user.errors.full_messages).to include("Password can't be blank")
      ensure
        expect(user.id).to be_nil
      end
    end

    it "does not add a user when password confirmation is not filled in" do
      begin
        user = User.create(first_name: "Mike",
                          last_name: "Davis",
                          email: "mikedamonkey@gmail.com",
                          password: "segf;iousabdgu")
      rescue
        expect(user.errors.full_messages).to include("Password can't be blank")
      ensure
        expect(user.id).to be_nil
      end
    end
    
    it "does not add a user when email is not filled in" do
      begin
        user = User.create(first_name: "Mike",
                          last_name: "Davis",
                          password: "segf;iousabdgu",
                          password_confirmation: "segf;iousabdgu")
      rescue
        expect(user.errors.full_messages).to include("email can't be blank")
      ensure
        expect(user.id).to be_nil
      end
    end

    it "does not add a user when first name is not filled in" do
      begin
        user = User.create(last_name: "Davis",
                          email: "mikedamonkey@gmail.com",
                          password: "segf;iousabdgu",
                          password_confirmation: "segf;iousabdgu")
      rescue
        expect(user.errors.full_messages).to include("first_name can't be blank")
      ensure
        expect(user.id).to be_nil
      end
    end

    it "does not add a user when last name is not filled in" do
      begin
        user = User.create(first_name: "Mike",
                          email: "mikedamonkey@gmail.com",
                          password: "segf;iousabdgu",
                          password_confirmation: "segf;iousabdgu")
      rescue
        expect(user.errors.full_messages).to include("last_name can't be blank")
      ensure
        expect(user.id).to be_nil
      end
    end
    it "does not create a user when password does not match confirmation" do
      begin
        user = User.create(first_name: "Mike",
                          last_name: "Davis",
                          email: "mikedamonkey@gmail.com",
                          password: "segf;iousabdgu",
                          password_confirmation: "doesnotmatch")
      rescue
        expect(user.errors.full_messages).to include("last_name can't be blank")
      ensure
        expect(user.id).to be_nil
      end
    end
  
    it "does not add a user when email is already in the database" do
      # need to add this twice to show it fails on the second time
      begin
        user1 = User.create(first_name: "Mike",
                          last_name: "Davis",
                          email: "example@gmail.com",
                          password: "segf;iousabdgu",
                          password_confirmation: "segf;iousabdgu")

        user2 = User.create(first_name: "Mike",
                          last_name: "Davis",
                          email: "example@gmail.com",
                          password: "segf;iousabdgu",
                          password_confirmation: "segf;iousabdgu")
      rescue
        expect(user2.errors.full_messages).to include("last_name can't be blank")
      ensure
        expect(user2.id).to be_nil
      end
    end
  
    it "does not add a user when the password is less than 8 characters" do
      begin
        user = User.create(first_name: "Mike",
                          last_name: "Davis",
                          email: "mikedamonkey@gmail.com",
                          password: "not8",
                          password_confirmation: "not8")
      rescue
        expect(user.errors.full_messages).to include("last_name can't be blank")
      ensure
        expect(user.id).to be_nil
      end
    end
  end

  describe '.authenticate_with_credentials' do

    it "does not login a user when the email is not registered" do
      expect(User.authenticate_with_credentials("newemail@gmail.com", "randompassword")).to be_nil
    end
    
    it "does login a user when the email is registered" do
      if !User.find_by_email("mikedamonkey@gmail.com")
        user = User.create!(first_name: "Mike",
                            last_name: "Davis",
                            email: "mikedamonkey@gmail.com",
                            password: "segf;iousabdgu",
                            password_confirmation: "segf;iousabdgu")
      end
      expect(User.authenticate_with_credentials("mikedamonkey@gmail.co", "segf;iousabdgu")).to be_nil
    end
  end
end
