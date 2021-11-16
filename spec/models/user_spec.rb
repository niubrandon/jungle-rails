require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    
    it 'validates presece' do
    record = User.new
    record.first_name = nil
    record.validate
    expect(record.errors[:first_name]).to include("can't be blank")
    
    record.last_name = nil
    record.validate
    expect(record.errors[:first_name]).to include("can't be blank")

    record.email = nil
    record.validate
    expect(record.errors[:email]).to include("can't be blank")

    record.password = nil
    record.validate
    expect(record.errors[:password]).to include("can't be blank")

    record.password_confirmation = nil
    record.validate
    expect(record.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'validates match between password and password_confirmation' do
      record = User.new
      record.first_name = "Brandon"
      record.last_name ="Niu"
      record.email = "niu@gmail.com"
      record.password = "Super12345"
      record.password_confirmation = "Super123456"
      expect(record.save).to eq(false)

      record.password_confirmation = "Super12345"
      expect(record.save).to eq(true)
    end

  end

  describe "password must be at least 7 characters" do
    it 'password must be at least 7 characters in length' do
    
      record = User.new
      record.first_name = "Brandon"
      record.last_name ="Niu"
      record.email = "niu@gmail.com"
      record.password = "Super"
      record.password_confirmation = "Super"
      record.validate
      expect(record.errors[:password]).to include("Please enter at least 7 characters")
    end

  
  end

  describe "Email must be unique" do
    it 'check email uniqueness' do
      record1 = User.new(first_name: "niu", last_name: "dong", email: "niu@163.com", password: "masterpassword123", password_confirmation: "masterpassword123")
      record1.save
      record2 = User.new(first_name: "ni", last_name: "don", email: "nIU@163.com", password: "masterpassword123", password_confirmation: "masterpassword123")
     
      record2.validate
      expect(record2.save).to eq(false)

    end
  end
      

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'pass authentication with extra spaces around email' do
    record1 = User.new(first_name: "niu", last_name: "dong", email: "niu@163.com", password: "masterpassword123", password_confirmation: "masterpassword123")
    record1.save
    login = User.authenticate_with_credentials(" NIU@163.com ", "masterpassword123")
    expect(login).to eq(record1)

    end
  
    it 'pass authentication with same email case insensitivity' do
      record1 = User.new(first_name: "niu", last_name: "dong", email: "niu@163.com", password: "masterpassword123", password_confirmation: "masterpassword123")
      record1.save
      login = User.authenticate_with_credentials("NIu@163.com", "masterpassword123")
      expect(login).to eq(record1)

    end
  

    it 'fail authentication with wrong password' do
      record1 = User.new(first_name: "niu", last_name: "dong", email: "niu@163.com", password: "masterpassword123", password_confirmation: "masterpassword123")
      record1.save
      login = User.authenticate_with_credentials("niu@163.com", "rpassword123")
      expect(login).to eq(false)

    end
  end


end
