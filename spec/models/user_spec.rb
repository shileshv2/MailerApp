require 'spec_helper'

describe User do
	before(:each) do
		@valid_params = {:user_name => "Example user", :email => "user@example.com", :password => "example"}
	end

	it "should create user with valid params" do
		User.find_by_email("user@example.com").should be_nil
		User.create @valid_params
		User.find_by_email("user@example.com").user_name.should == "Example user" 

	end

	it "when email format is invalid" do
		@valid_params[:email] = "xyz"
		user = User.create(@valid_params)
		user.errors[:email].should == "is invalid"	
		User.new.should_not be_valid

	end

	it "when username is not present" do
		@valid_params[:user_name] = nil
		user = User.create(@valid_params)
		user.errors_on(:user_name).should == ["can't be blank", "is too short (minimum is 5 characters)"]
		User.find_by_email("user@example.com").should be_nil
	end

	it "when password is not present" do
		@valid_params[:password] = nil
		user = User.create(@valid_params)
		user.errors_on(:password).should == ["can't be blank"]
		User.find_by_email("user@example.com").should be_nil
	end


	it "when username is too short" do
		@valid_params[:user_name] = "a"
		user = User.create @valid_params
		user.errors_on(:user_name).should == ["is too short (minimum is 5 characters)"]
		User.find_by_email("user@example.com").should be_nil	
	end

	it "user with duplicate username" do
		duplicate_username = @valid_params.dup
		User.create @valid_params
		User.find_by_email("user@example.com").should_not be_nil
		user = User.create duplicate_username
		#User.count { |rec| rec.email == "user@example.com"}.should == 1
		user.errors_on(:user_name).should == ["has already been taken"]
		User.count(:conditions => "email='user@example.com'").should == 1
		expect 
	end	

	it "when password doesn't match confirmation" do
		@valid_params[:password_confirmation] = 'mismatch'
		user = User.create @valid_params
		user.errors_on(:password).should == ["doesn't match confirmation"]
		User.find_by_email("user@example.com").should be_nil
	end
end